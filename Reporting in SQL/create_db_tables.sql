CREATE DATABASE Olympics
	
DROP TABLE IF EXISTS "athletes";
	CREATE TABLE athletes(
	 	id int,
		name VARCHAR(255),
		gender VARCHAR(8),
		age int,
		height int,
		weight int);

DROP TABLE IF EXISTS "summer_games";
	CREATE TABLE summer_games(
	 	sport VARCHAR(255),
		event VARCHAR(255),
		year date,
		athlete_id int,
		country_id int,
		medal VARCHAR(255));

DROP TABLE IF EXISTS "winter_games";
	CREATE TABLE winter_games(
	 	sport VARCHAR(255),
		event VARCHAR(255),
		year date,
		athlete_id int,
		country_id int,
		medal VARCHAR(255));

DROP TABLE IF EXISTS "countries";
	CREATE TABLE countries(
	 	id int,
		country VARCHAR(255),
		region varchar(50));

DROP TABLE IF EXISTS "country_stats";
	CREATE TABLE country_stats(
	 	year VARCHAR(255),
		country_id int,
		gdp float,
		pop_in_millions VARCHAR(255),
		nobel_prize_winners int);

COPY athletes
	FROM '/home/sofiane/Desktop/athletes.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY summer_games
	FROM '/home/sofiane/Desktop/summer_games.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY winter_games
	FROM '/home/sofiane/Desktop/winter_games.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY countries
	FROM '/home/sofiane/Desktop/countries.csv' (DELIMITER ',', FORMAT CSV, HEADER);

COPY country_stats
	FROM '/home/sofiane/Desktop/country_stats.csv' (DELIMITER ',', FORMAT CSV, HEADER);