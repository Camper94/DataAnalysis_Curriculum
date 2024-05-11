--Chapter I : Exploring the Olympics Dataset
/*Before you can start building out reports to answer specific questions, 
you should get familiar with the data. In this chapter, 
you will learn how to use E:R diagrams and data exploration techniques 
to get a solid understanding of the data to better answer business-related questions.

Building the base report
Now, build the base report for this visualization:

Most Athletes Represented
Top 3 Sports 

	Sport A |----------------------
	Sport B |------------------
	Sport C |------------

This should be built by querying the summer_games table, 
found in the explorer on the bottom right.

Instructions :
    -Using the console on the right, select the sport field from 
		the summer_games table.
    -Create athletes by counting the distinct occurrences of athlete_id.
    -Group by the sport field.
    -Make the report only show 3 rows, with the highest athletes at the top.
*/

SELECT 
	sport, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY sport
-- Only include the 3 sports with the most athletes
ORDER BY athletes
LIMIT 3;

/*
Athletes vs events by sport
Now consider the following visualization:

		|
		|
	  	|            x
Events		|   x      x    
		| x   x  x
		|       x          x
	 	 ---------------------
				Athletes
Using the summer_games table. run a query that creates the base report that sources
this visualization.

Insctructions:
    -Pull a report that shows each sport, 
		the number of unique events, 
		and the number of unique athletes from the summer_games table.
    -Group by the non-aggregated field, which is sport.
*/

SELECT 
	sport, 
    COUNT(DISTINCT event) AS events, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY sport;

/*
Age of the oldest athlete by region

In the previous exercise, 
you identified which tables are needed to create a report that shows Age of 
Oldest Athlete by Region. Now, set up the query to create this report.

Instructions

    -Create a report that shows region and age_of_oldest_athlete.
    -Include all three tables by running two separate JOIN statements.
    -Group by the non-aggregated field.
    -Alias each table AS the first letter in the table (in lower case).
*/
SELECT 
	region, 
    MAX(a.age) AS age_of_oldest_athlete
FROM athletes a
-- First JOIN statement
JOIN summer_games sg
ON a.id = sg.athlete_id
-- Second JOIN statement
JOIN countries c
ON c.id= sg.country_id
GROUP BY region;
/*
Number of events in each sport

Since the company will be involved in both summer sports and winter sports, 
it is beneficial to look at all sports in one centralized report.
Your task is to create a query that shows the unique number of events 
held for each sport. Note that since no relationships 
exist between these two tables, you will need to use a UNION instead of a JOIN.

Instructions

    -Create a report that shows unique events by sport for both summer and winter events.
    -Use a UNION to combine the relevant tables.
    -Use two GROUP BY statements as needed.
    -Order the final query to show the highest number of events first.
*/
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM summer_games
GROUP BY sport
UNION
-- Select sport and events for winter sports
SELECT 
	sport, 
    COUNT(DISTINCT event) AS events
FROM winter_games
GROUP BY sport
-- Show the most events at the top of the report
ORDER BY events DESC;

/*
Exploring summer_games

Exploring the data in a table can provide further insights into the database 
as a whole. In this exercise, you will try out a series of different techniques 
to explore the summer_games table.

Insctructions
	-Select bronze from the summer_games table, but do not use DISTINCT or GROUP BY.
*/
-- Update the query to explore the bronze field
SELECT bronze
FROM summer_games;
/*
The results do not provide much insight as we mostly see NULL.
Add a DISTINCT to only show unique bronze values.
*/
SELECT DISTINCT bronze
FROM summer_games;
/*
GROUP BY is an alternative to using DISTINCT. 
Remove the DISTINCT and add a GROUP BY statement.
*/
SELECT  bronze
FROM summer_games
GROUP BY bronze;
/*
Let's see how much of our dataset is NULL.
Add a field that shows number of rows to your query.
*/
SELECT 
	bronze, 
	COUNT(*) AS rows
FROM summer_games
GROUP BY bronze;
/*
Validating our query

The same techniques we use to explore the data can be used to validate queries. By using the query as a subquery, 
you can run exploratory techniques to confirm the query results are as expected.
In this exercise, you will create a query that shows Bronze Medals by Country 
and then validate it using the subquery technique.
Feel free to reference the E:R Diagram as needed.

Instrcutions
Create a query that outputs total bronze medals from the summer_games table.
*/
SELECT COUNT(bronze) AS total_bronze_medals
FROM summer_games;
/*
The value for total_bronze_medals is commented out for reference. 
Setup a query that shows bronze_medals for summer_games by country.
*/

/* Pull total_bronze_medals from summer_games below
SELECT SUM(bronze) AS total_bronze_medals
FROM summer_games; 
>> OUTPUT = 141 total_bronze_medals */

-- Setup a query that shows bronze_medal by country
SELECT 
	country, 
    SUM(bronze) AS bronze_medals
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY country;

/*
Add parenthesis to your query you just created and alias as subquery.
Select the total number of bronze_medals and compare to the total bronze medals in summer_games.
*/

/* Pull total_bronze_medals below
SELECT SUM(bronze) AS total_bronze_medals
FROM summer_games; 
>> OUTPUT = 141 total_bronze_medals */

-- Select the total bronze_medals from your query
SELECT SUM(bronze_medals)
FROM( 
-- Previous query is shown below.  Alias this AS subquery
  SELECT 
      country, 
      SUM(bronze) AS bronze_medals
  FROM summer_games AS s
  JOIN countries AS c
  ON s.country_id = c.id
  GROUP BY country
) AS subquery;

/*
Report 1: Most decorated summer athletes

Now that you have a good understanding of the data, 
let's get back to our case study and build out the first element for the dashboard, 
Most Decorated Summer Athletes:
			
				|
				|	|
Gold Medals		|	|	|	|	|
				|	|	|	|	|
			 ---------------------
				A	B	C	D	E
				  Athlete Name
Your job is to create the base report for this element. Base report details:
    -Column 1 should be athlete_name.
    -Column 2 should be gold_medals.
	-The report should only include athletes with at least 3 medals.
	-The report should be ordered by gold medals won, 
		with the most medals at the top.

Instructions :

    -Select athlete_name and gold_medals by joining summer_games and athletes.
    -Only include athlete_name with at least 3 gold medals.
    -Sort the table so that the most gold_medals appears at the top.
*/
SELECT 
	a.name AS athlete_name, 
    COUNT(s.gold) AS gold_medals
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY name
-- Filter for only athletes with 3 gold medals or more
HAVING COUNT(s.gold) > 2 
-- Sort to show the most gold medals at the top
ORDER BY gold_medals DESC;

--Chapter II : Creating Reports
/*
Queries can get large, 
fast. It's important to take a logical approach when building more complicated queries.
In this chapter, you will take a step-by-step approach to plan and build a complex query 
that requires you to combine tables in multiple ways and create different types of fields.

Planning the filter
Your boss is looking to see which winter events include athletes over the age of 40. 
To answer this, you need a report that lists out all events that satisfy this condition.
In order to have a correct list, you will need to leverage a filter. 
In this exercise, you will decide which filter option to use.

Instructions : 
	-Create a query that shows all unique event names in the winter_games table.
*/
SELECT DISTINCT event
FROM winter_games;
/*
Question
Which of the following approaches will not work to filter this list for events 
that have athletes over the age of 40?

Possible answers
	-JOIN to athletes and add a WHERE age > 40 clause.
	-Add a WHERE clause that references the following subquery: 
		SELECT id FROM athletes WHERE age > 40
	-JOIN to athletes and add a HAVING AVG(age) > 40.(X)

JOIN then UNION query
Your goal is to create a report with the following fields:

    season, which outputs either summer or winter
    country
    events, which shows the unique number of events

There are multiple ways to create this report. In this exercise, 
create the report by using the JOIN first, 
UNION second approach.
As always, feel free to reference your E:R Diagram to identify relevant fields and tables.

Instructions :

    -Setup a query that shows unique events by country and season for summer events.
    -Setup a similar query that shows unique events by country and season for winter events.
    -Combine the two queries using a UNION ALL.
    -Sort the report by events in descending order.
*/
-- Query season, country, and events for all summer events
SELECT 
	'summer' AS season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM summer_games AS s
JOIN countries AS c
ON s.country_id = c.id
GROUP BY season,country
-- Combine the queries
UNION ALL
-- Query season, country, and events for all winter events
SELECT 
	'winter' AS season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM winter_games AS w
JOIN countries AS c
ON w.country_id = c.id
GROUP BY season,country
-- Sort the results to show most events at the top
ORDER BY events DESC;
/*
UNION then JOIN query
Your goal is to create the same report as before, which contains with the following fields:
    season, which outputs either summer or winter
    country
    events, which shows the unique number of events
In this exercise, create the query by using the UNION first, 
JOIN second approach. When taking this approach, 
you will need to use the initial UNION query as a subquery. 
The subquery will need to include all relevant fields, including those used in a join.
As always, feel free to reference the E:R Diagram.

Instructions :

    -In the subquery, construct a query that outputs season, 
		country_id and event by combining summer and winter games with a UNION ALL.
    -Leverage a JOIN and another SELECT statement to show the fields season, 
		country and unique events.
    -GROUP BY any unaggregated fields.
    -Sort the report by events in descending order.
*/
-- Add outer layer to pull season, country and unique events
SELECT 
	season, 
    country, 
    COUNT(DISTINCT event) AS events
FROM
    -- Pull season, country_id, and event for both seasons
    (SELECT 
     	'summer' AS season, 
     	country_id, 
     	event
    FROM summer_games
    UNION ALL
    SELECT 
     	'winter' AS season, 
     	country_id, 
     	event
    FROM winter_games) AS subquery
JOIN countries AS c
ON subquery.country_id = c.id
-- Group by any unaggregated fields
GROUP BY season,country
-- Order to show most events at the top
ORDER BY events DESC;
/*
CASE statement refresher
CASE statements are useful for grouping values into different buckets based on 
conditions you specify. Any row that fails to satisfy any condition will fall to 
the ELSE statement (or show as null if no ELSE statement exists).
In this exercise, your goal is to create the segment field that buckets an athlete 
into one of three segments:
    -Tall Female, which represents a female that is at least 175 centimeters tall.
    -Tall Male, which represents a male that is at least 190 centimeters tall.
    -Other
Each segment will need to reference the fields height and gender from the athletes table. 
Leverage CASE statements and conditional logic (such as AND/OR) to build this.
Remember that each line of a case statement looks like this: CASE WHEN {condition} 
THEN {output}
Instructions :
	-Update the CASE statement to output three values: Tall Female, Tall Male, and Other.
*/
SELECT 
	name,
    -- Output 'Tall Female', 'Tall Male', or 'Other'
	CASE 
    WHEN  gender = 'F' AND height >= 175 THEN 'Tall Female'
    WHEN gender = 'M' AND height >= 190 THEN 'Tall Male'
    ELSE 'Other' END AS segment
FROM athletes;
/*
BMI bucket by sport
You are looking to understand how BMI differs by each summer sport. 
To answer this, set up a report that contains the following:
    -sport, which is the name of the summer sport
    -bmi_bucket, which splits up BMI into three groups: <.25, .25-.30, >.30
    -athletes, or the unique number of athletes
Definition: BMI = 100 * weight / (height squared).
Also note that CASE statements run row-by-row, 
so the second conditional is only applied if the first conditional is false. 
This makes it that you do not need an AND statement excluding 
already-mentioned conditionals.
Feel free to reference the E:R Diagram.

Instructions: 

    -Build a query that pulls from summer_games and athletes to show sport, 
		bmi_bucket, and athletes.
    -Without using AND or ELSE, set up a CASE statement that splits bmi_bucket 
		into three groups: '<.25', '.25-.30', and '>.30'.
    -Group by the non-aggregated fields.
    -Order the report by sport and then athletes in descending order.
*/
-- Pull in sport, bmi_bucket, and athletes
SELECT 
	sport,
    -- Bucket BMI in three groups: <.25, .25-.30, and >.30	
    CASE WHEN (weight/height^2)*100 < .25 THEN '<.25'
    WHEN (weight/height^2)*100 >=.25 AND (weight/height^2)*100 <=.30 THEN '.25-.30'
    WHEN (weight/height^2)*100> .30 THEN '>.30' END AS bmi_bucket,
    COUNT(distinct athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
-- GROUP BY non-aggregated fields
GROUP BY sport,bmi_bucket
-- Sort by sport and then by athletes in descending order
ORDER BY sport,athletes DESC;
/*
Troubleshooting CASE statements

In the previous exercise, you may have noticed several null values in our case statement, 
which can indicate there is an issue with the code.
In these instances, 
it's worth investigating to understand why these null values are appearing. 
In this exercise, 
you will go through a series of steps to identify the issue and make 
changes to the code where necessary.

Instructions :
    -Comment out the query from last exercise (lines 2 - 12).
    -Create a query that pulls height, weight, 
		and bmi from athletes and filters for null bmi values.
*/
-- Query from last exercise shown below.  Comment it out.
/*SELECT 
	sport,
    CASE WHEN weight/height^2*100 <.25 THEN '<.25'
    WHEN weight/height^2*100 <=.30 THEN '.25-.30'
    WHEN weight/height^2*100 >.30 THEN '>.30' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY sport, bmi_bucket
ORDER BY sport, athletes DESC;
*/
-- Show height, weight, and bmi for all athletes
SELECT 
	height,
    weight,
    weight/height^2*100 AS bmi
FROM athletes
-- Filter for NULL bmi values
WHERE weight/height^2*100 IS NULL;

/*
Question

What is the reason we have null values in our bmi field?
Possible answers
	-Some athlete_ids found in our original query are not found in the athletes table.
	-There are numerous null height values, which will calculate null bmi values.
	-There are numerous null weight values, which will calculate null bmi values.(X)
	-Our case statement does not include values with a bmi that is extremely high.

Comment out the troubleshooting query, uncomment the original query, 
and add an ELSE line to the CASE statement that outputs 'no weight recorded'.
*/
-- Uncomment the original query
SELECT 
	sport,
    CASE WHEN weight/height^2*100 <.25 THEN '<.25'
    WHEN weight/height^2*100 <=.30 THEN '.25-.30'
    WHEN weight/height^2*100 >.30 THEN '>.30'
    -- Add ELSE statement to output 'no weight recorded'
    ELSE 'no weight recorded' END AS bmi_bucket,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id
GROUP BY sport, bmi_bucket
ORDER BY sport, athletes DESC;

-- Comment out the troubleshooting query
/*SELECT 
	sport, 
    weight, 
    weight/height^2*100 AS bmi
FROM athletes
WHERE weight/height^2*100 IS NULL;*/
/*
Filtering with a JOIN

When adding a filter to a query that requires you to reference a separate table, 
there are different approaches you can take. One option is to JOIN to the new table 
and then add a basic WHERE statement.
Your goal is to create a report with the following characteristics:

    First column is bronze_medals, or the total number of bronze.
    Second column is silver_medals, or the total number of silver.
    Third column is gold_medals, or the total number of gold.
    Only summer_games are included.
    Report is filtered to only include athletes age 16 or under.
In this exercise, use the JOIN approach.

Instructions : 

    -Create a query that pulls total bronze_medals, silver_medals, 
		and gold_medals from summer_games.
    -Use a JOIN and a WHERE statement to filter for athletes ages 16 and below.
*/
-- Pull summer bronze_medals, silver_medals, and gold_medals
SELECT 
	SUM(bronze) bronze_medals, 
    SUM(silver) silver_medals, 
    SUM(gold) gold_medals
    FROM summer_games AS s
JOIN athletes AS a
ON s.athlete_id = a.id 
-- Filter for athletes age 16 or below
WHERE age <= 16;

/*
Filtering with a subquery

Another approach to filter from a separate table is to use a subquery. 
The process is as follows:
    Create a subquery that outputs a list.
    In your main query, add a WHERE statement that references the list.
Your goal is to create the same report as the last exercise, 
which contains the following characteristics:
    First column is bronze_medals, or the total number of bronze.
    Second column is silver_medals, or the total number of silver.
    Third column is gold_medals, or the total number of gold.
    Only summer_games are included.
    Report is filtered to only include athletes age 16 or under.
In this exercise, use the subquery approach.

Instructions : 
    -Create a query that pulls total bronze_medals, silver_medals, 
		and gold_medals from summer_games.
    -Setup a subquery that outputs all athletes age 16 or below.
    -Add a WHERE statement that references the subquery to filter for athletes 
		age 16 or below.
*/
-- Pull summer bronze_medals, silver_medals, and gold_medals
SELECT 
	SUM(bronze) bronze_medals, 
    SUM(silver) silver_medals, 
    SUM(gold) gold_medals
FROM summer_games
-- Add the WHERE statement below
WHERE athlete_id IN
    -- Create subquery list for athlete_ids age 16 or below    
    (SELECT id
     FROM athletes
     WHERE age <= 16);
/*
Report 2: Top athletes in nobel-prized countries

It's time to bring together all the concepts brought up in this chapter to expand
on your dashboard! Your next report to build is 
Report 2: Athletes Representing Nobel-Prize Winning Countries.

Report Details:
    Column 1 should be event, which represents the Olympic event. Both summer and winter events should be included.
    Column 2 should be gender, which represents the gender of athletes in the event.
    Column 3 should be athletes, which represents the unique athletes in the event.
    Athletes from countries that have had no nobel_prize_winners should be excluded.
    The report should contain 10 events, where events with the most athletes show at the top.
Click to view the E:R Diagram.

Instructions :

-Select event from the summer_games table and create the athletes 
field by counting the distinct number of athlete_id.
*/
SELECT 	
	event,
	COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY event;
/*
Explore the event field to determine how to split up events by gender 
(without adding a join), then add the gender field by using a 
CASE statement that specifies a conditional for 'female' events 
(all other events should output as 'male').
*/
SELECT 
	event, 
    -- Add the gender field below
    CASE 
    WHEN event LIKE '%Men%' THEN 'male'
    ELSE 'female' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
GROUP BY event;
/*Filter for Nobel-prize-winning countries by creating a subquery that outputs 
country_id from the country_stats table for any country with more than zero 
nobel_prize_winners.*/
-- Pull event and unique athletes from summer_games 
SELECT 
    event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
-- Only include countries that won a nobel prize
WHERE country_id IN 
	(SELECT country_id
    FROM country_stats
    WHERE nobel_prize_winners > 0)
GROUP BY event;
/*
Copy your query with summer_games replaced by winter_games, 
UNION the two tables together, and order the final report to show the 10 rows 
with the most athletes.*/
-- Pull event and unique athletes from summer_games 
SELECT 
    event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games
-- Only include countries that won a nobel prize
WHERE country_id IN 
	(SELECT country_id 
    FROM country_stats 
    WHERE nobel_prize_winners > 0)
GROUP BY event
-- Add the second query below and combine with a UNION
UNION ALL
SELECT 
	event,
    -- Add the gender field below
    CASE WHEN event LIKE '%Women%' THEN 'female' 
    ELSE 'male' END AS gender,
    COUNT(DISTINCT athlete_id) AS athletes
FROM winter_games
WHERE country_id IN 
	(SELECT country_id
    FROM country_stats
    WHERE nobel_prize_winners > 0)
GROUP BY event,gender
-- Order and limit the final output
ORDER BY athletes DESC
LIMIT 10;

--Chapter III : Cleaning & Validation
/*
Although it would be nice, data in the real-world is rarely stored in an ideal way.
Simply put: data can get messy. In chapter 3, 
you will learn how to deal with this messy data by fixing data type issues, 
cleaning messy strings, handling nulls, and removing duplication.

Identifying data types

Being able to identify data types before setting up your query can help you plan 
for any potential issues. There is a group of tables, or a schema, 
called the information_schema, 
which provides a wide array of information about the database itself, 
including the structure of tables and columns.

The columns table houses useful details about the columns, including the data type.

Note that the information_schema is not the default schema SQL looks at when querying, 
which means you will need to explicitly tell SQL to pull from this schema. 
To pull a table from a non-default schema, use the syntax schema_name.table_name.

Instructions :
    -Select the fields column_name and data_type from the table columns that 
		resides within the information_schema schema.
    -Filter only for the 'country_stats' table.
*/
-- Pull column_name & data_type from the columns table
SELECT 
	column_name,
    data_type
FROM information_schema.columns
-- Filter for the table 'country_stats'
WHERE table_name = 'country_stats';
/*
Question

What is the data type of the year column?
Possible answers
	date
	character varying(X)
	double precision
	integer

Interpreting error messages

Inevitably, you will run into errors when running SQL queries. 
It is important to understand how to interpret these errors to correctly 
identify what type of error it is.

The console contains two separate queries, 
each which will output an error when ran. 
In this exercise, you will run each query, 
read the error message, and troubleshoot the error.

Instructions : 
    -Run the query in the console.
    -After reading the error, fix it by converting the data type to float.
*/
-- Run the query, then convert a data type to fix the error
SELECT AVG(CAST(pop_in_millions AS FLOAT)) AS avg_population
FROM country_stats;

/*SELECT 
	s.country_id, 
    COUNT(DISTINCT s.athlete_id) AS summer_athletes, 
    COUNT(DISTINCT w.athlete_id) AS winter_athletes
FROM summer_games AS s
JOIN winter_games_str AS w
ON s.country_id = w.country_id
GROUP BY s.country_id;*/

/*
    -Comment the first query and uncomment the second query.
    -Run the code and fix errors by making the join columns int.
*/
-- Comment out the previous query
/*SELECT AVG(CAST(pop_in_millions AS float)) AS avg_population
FROM country_stats;*/

-- Uncomment the following block & run the query
SELECT 
	s.country_id, 
    COUNT(DISTINCT s.athlete_id) AS summer_athletes, 
    COUNT(DISTINCT w.athlete_id) AS winter_athletes
FROM summer_games AS s
JOIN winter_games_str AS w
-- Fix the error by making both columns integers
ON s.country_id = w.country_id::int
GROUP BY s.country_id;

/*
Using date functions on strings
There are several useful functions that act 
specifically on date or datetime fields. For example:
    -DATE_TRUNC('month', date) truncates each date to the first day of the month.
    -DATE_PART('year', date) outputs the year, as an integer, of each date value.
In general, the arguments for both functions are ('period', field), 
where period is a date or time interval, such as 'minute', 'day', or 'decade'.

In this exercise, your goal is to test out these date functions on the country_stats table, 
specifically by outputting the decade of each year using two separate approaches. 
To run these functions, you will need to use CAST() function on the year field.

Instructions : 

    -Pulling from the country_stats table, select the decade using two methods: 
		DATE_PART() and DATE_TRUNC.
    -Convert the data type of the year field to fix errors.
    -Sum up gdp to get world_gdp.
    -Group and order by year (in descending order).
*/
SELECT 
	year,
    -- Pull decade, decade_truncate, and the world's gdp
    DATE_PART('decade',CAST(year AS date)) AS decade,
    DATE_TRUNC('decade',CAST(year AS date)) AS decade_truncated,
    SUM(gdp) AS world_gdp
FROM country_stats
-- Group and order by year in descending order
GROUP BY year
ORDER BY year DESC;
/*
String functions
There are a number of string functions that can be used to alter strings. 
A description of a few of these functions are shown below:
    The LOWER(fieldName) function changes the case of all characters in fieldName 
		to lower case.
    The INITCAP(fieldName) function changes the case of all characters 
		in fieldName to proper case.
    The LEFT(fieldName,N) function returns the left N characters of the string fieldName.
    The SUBSTRING(fieldName from S for N) returns N characters starting from position S 
		of the string fieldName. Note that both from S and for N are optional.

Instruction :
	-Update the field country_altered to output country in all lower-case.
*/
SELECT 
	country, 
    LOWER(country) AS country_altered
FROM countries
GROUP BY country;
--Update the field country_altered to output country in proper-case.
SELECT 
	country, 
    INITCAP(LOWER(country)) AS country_altered
FROM countries
GROUP BY country;
--Update the field country_altered to output the left 3 characters of country.
SELECT 
	country, 
    LEFT(country,3) AS country_altered
FROM countries
GROUP BY country;
--Update the field country_altered to output all characters 
--starting with the 7th character of country.
SELECT 
	country, 
    SUBSTRING(country FROM 7) AS country_altered
FROM countries
GROUP BY country;
/*
Replacing and removing substrings
The REPLACE() function is a versatile function that allows you to replace or 
remove characters from a string. The syntax is as follows:
REPLACE(fieldName, 'searchFor', 'replaceWith')
Where fieldName is the field or string being updated, 
searchFor is the characters to be replaced, and replaceWith is the replacement substring.
In this exercise, you will look at one specific value in the countries 
table and change up the format by using a few REPLACE() functions.

Instructions :

    Create the field character_swap that replaces all '&' characters with 'and' 
		from region.
    Create the field character_remove that removes all periods from region.
*/
SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;
/*
Add a new field called character_swap_and_remove that runs the alterations 
of both character_swap and character_remove in one go.
*/
SELECT 
	region, 
    -- Replace all '&' characters with the string 'and'
    REPLACE(region,'&','and') AS character_swap,
    -- Remove all periods
    REPLACE(region,'.','') AS character_remove,
    -- Combine the functions to run both changes at once
    REPLACE(REPLACE(region,'&','and'),'.','') AS character_swap_and_remove
FROM countries
WHERE region = 'LATIN AMER. & CARIB'
GROUP BY region;
/*
Fixing incorrect groupings
One issues with having strings stored in different formats is that you may 
incorrectly group data. If the same value is represented in multiple ways, 
your report will split the values into different rows, 
which can lead to inaccurate conclusions.
In this exercise, you will query from the summer_games_messy table, 
which is a messy, smaller version of summer_games. You'll notice that the same 
event is stored in multiple ways. Your job is to clean the event field 
to show the correct number of rows.

Instructions :

    -Create a query that pulls the number of distinct athletes by event from the table 
		summer_games_messy.
    -Group by the non-aggregated field.
*/
SELECT 
	event, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Group by the non-aggregated field
GROUP BY event;
/*
Notice how we see 6 rows that relate to only 2 events. 
Alter the event field by trimming all leading and trailing spaces, 
alias as event_fixed, and update the GROUP BY accordingly.
*/
SELECT
    -- Remove trailing spaces and alias as event_fixed
	TRIM(event) AS event_fixed,
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Update the group by accordingly
GROUP BY event_fixed;
/*
Notice how there are now only 4 rows. 
Alter the event_fixed field further by removing all dashes (-).
*/
SELECT 
    -- Remove dashes from all event values
    REPLACE(TRIM(event),'-','') AS event_fixed, 
    COUNT(DISTINCT athlete_id) AS athletes
FROM summer_games_messy
-- Update the group by accordingly
GROUP BY event_fixed;
