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