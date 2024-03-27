-- Script Name: Chapter_Two.sql
-- Description: Decision_Making_with_simple_SQL_queries
-- Author: Sofiane Boumelit
-- Date: March 24, 2024

/*First account for each country.
Conduct an analysis to see when the first customer accounts were created for each country.*/
SELECT  country, 
		MIN(date_account_start) AS first_account
FROM customers
GROUP BY country
ORDER BY first_account;
/*Average movie ratings
For each movie the average rating, 
the number of ratings and the number of views has to be reported. 
Generate a table with meaningful column names.*/
SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY avg_rating DESC;--The average is null because all of the ratings of the movie are null.
/*Average rating per customer
Similar to what you just did, you will now look at the average movie ratings, 
this time for customers. So you will obtain a table with the average rating given by each customer. 
Further, you will include the number of ratings and the number of movie rentals per customer. 
You will report these summary statistics only for customers with more than 7 movie rentals 
and order them in ascending order by the average rating.*/
SELECT customer_id, 
       AVG(rating)			AS avg_rating,  
       COUNT(rating)		AS number_rating,  
       COUNT(*) 			AS number_movie_rental 
FROM renting
GROUP BY customer_id
HAVING COUNT(*) > 7 
ORDER BY avg_rating;
/*Join renting and customers
For many analyses it is necessary to add customer information to the data in the table renting.*/
SELECT AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';
/*Aggregating revenue, rentals and active customers
The management of MovieNow wants to report key performance indicators (KPIs) for the performance of 
the company in 2018. They are interested in measuring the financial successes as well as user engagement. 
Important KPIs are, therefore, the revenue coming from movie rentals, the number of movie rentals and 
the number of active customers.*/
SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01'AND'2018-12-31';
/*Movies and actors
You are asked to give an overview of which actors play in which movie.*/
SELECT DISTINCT m.title, 
       a.name
FROM actsin ai
LEFT JOIN movies AS m
ON m.movie_id = ai.movie_id
LEFT JOIN actors AS a
ON a.actor_id = ai.actor_id;
/*Income from movies
How much income did each movie generate? 
To answer this question subsequent SELECT statements can be used.*/
SELECT title, 
       SUM(renting_price) AS income_movie
FROM
       (SELECT m.title,  
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
GROUP BY title
ORDER BY income_movie DESC;
/*Age of actors from the USA
Now you will explore the age of American actors and actresses. 
Report the date of birth of the oldest and youngest US actor and actress.*/
SELECT a.gender, -- Report for male and female actors from the USA 
       MIN(a.year_of_birth), -- The year of birth of the oldest actor
       MAX(a.year_of_birth) -- The year of birth of the youngest actor
FROM(
      SELECT * -- Use a subsequen SELECT to get all information about actors from the USA
   FROM 
   actors
   WHERE nationality ='USA') AS a -- Give the table the name a
GROUP BY gender;
/*Identify favorite movies for a group of customers
Which is the favorite movie on MovieNow? Answer this question for a specific group of customers: 
for all customers born in the 70s.*/
SELECT m.title, 
COUNT(*),
AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING count(*)>1 
ORDER BY count DESC;
/*Identify favorite actors for Spain
You're now going to explore actor popularity in Spain. Use as alias the first letter of the table, 
except for the table actsin use ai instead.*/
SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE country IN('Spain') 
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5 
ORDER BY avg_rating DESC, number_views DESC;
/*KPIs per country
In chapter 1 you were asked to provide a report about the development of the company. 
This time you have to prepare a similar report with KPIs for each country separately. 
Your manager is interested in the total number of movie rentals, the average rating of 
all movies and the total revenue for each country since the beginning of 2019.*/
SELECT 
	c.country,                   
	COUNT(*) AS number_renting, 
	AVG(r.rating) AS average_rating, 
	SUM(m.renting_price) AS revenue         
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY country;
/*Often rented movies
Your manager wants you to make a list of movies excluding those which are hardly ever watched. 
This list of movies will be used for advertising. 
List all movies with more than 5 views using a nested query which is a powerful tool to implement 
selection conditions.*/
SELECT *
FROM movies
WHERE movie_id IN  
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)
/*Frequent customers
Report a list of customers who frequently rent movies on MovieNow.*/
SELECT *
FROM customers
WHERE customer_id IN           
	(SELECT DISTINCT customer_id
	FROM renting
	GROUP BY customer_id
	HAVING COUNT(*) > 10);
/*Movies with rating above average
For the advertising campaign your manager also needs a list of popular movies with high ratings. 
Report a list of movies with rating above average.*/
SELECT title -- Report the movie titles of all movies with average rating higher than the total average
FROM movies
WHERE movie_id IN
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));
/*Analyzing customer behavior
A new advertising campaign is going to focus on customers who rented fewer than 5 movies.
Use a correlated query to extract all customer information for the customers of interest.*/
SELECT *
FROM customers as c
WHERE 5 > 
	(SELECT count(*)
	FROM renting as r
	WHERE r.customer_id = c.customer_id);
/*Customers who gave low ratings
Identify customers who were not satisfied with movies they watched on MovieNow. 
Report a list of customers with minimum rating smaller than 4.*/
SELECT *
FROM customers c
WHERE  4 > -- Select all customers with a minimum rating smaller than 4 
	(SELECT MIN(rating)
	FROM renting AS r
	WHERE r.customer_id = c.customer_id);
/*Movies and ratings with correlated queries
Report a list of movies that received the most attention on the movie platform,
(i.e. report all movies with more than 5 ratings and all movies with an average rating higher than 8).*/
SELECT *
FROM movies AS m
WHERE 8 < -- Select all movies with an average rating higher than 8
	(SELECT AVG(rating)
	FROM renting AS r
	WHERE r.movie_id = m.movie_id);
/*Customers with at least one rating
Having active customers is a key performance indicator for MovieNow. 
Make a list of customers who gave at least one rating.*/
SELECT *
FROM customers c
WHERE EXISTS
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL 
	AND r.customer_id = c.customer_id);
/*Actors in comedies
In order to analyze the diversity of actors in comedies, 
first, report a list of actors who play in comedies and then, 
the number of actors for each nationality playing in comedies.*/
SELECT a.nationality,
	   COUNT(*) -- Report the nationality and the number of actors for each nationality
FROM actors AS a
WHERE EXISTS
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id)
GROUP BY a.nationality;
/*Young actors not coming from the USA
As you've just seen, the operators UNION and INTERSECT are powerful tools when you work with two or more tables. 
Identify actors who are not from the USA and actors who were born after 1990.*/
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT 
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;
/*Dramas with high ratings
The advertising team has a new focus. They want to draw the attention of the customers to dramas. 
Make a list of all movies that are in the drama genre and have an average rating higher than 9.*/
SELECT *
FROM movies
WHERE movie_id = 
   (SELECT movie_id
    FROM movies
    WHERE genre = 'Drama'
    INTERSECT
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating)>9);