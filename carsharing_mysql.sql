-- =====================================================================
-- carsharing: MySQL version (for MySQL Workbench)
-- Step 1: creates the database, tables and relationships
-- Step 2: loads the data from the four CSV files
-- =====================================================================

DROP DATABASE IF EXISTS carsharing;
CREATE DATABASE carsharing;
USE carsharing;

-- ---------- Lookup tables first ----------
CREATE TABLE weather (
    weather_code INT PRIMARY KEY,
    weather      VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE temperature (
    temp_code     VARCHAR(25) PRIMARY KEY,
    temp          DOUBLE NOT NULL,
    temp_feel     DOUBLE NOT NULL,
    temp_category VARCHAR(10) NOT NULL,
    CHECK (temp_category IN ('Cold', 'Mild', 'Hot'))
);

CREATE TABLE `time` (
    id           INT PRIMARY KEY,
    `timestamp`  DATETIME NOT NULL,
    season       VARCHAR(10) NOT NULL,
    hour         INT NOT NULL,
    weekday_name VARCHAR(10) NOT NULL,
    month_name   VARCHAR(10) NOT NULL
);

-- ---------- Main table, linked to all three ----------
CREATE TABLE carsharing (
    id           INT PRIMARY KEY,
    holiday      VARCHAR(3) NOT NULL,
    workingday   VARCHAR(3) NOT NULL,
    weather_code INT NOT NULL,
    temp_code    VARCHAR(25) NOT NULL,
    humidity     DOUBLE,
    windspeed    DOUBLE,
    demand       DOUBLE NOT NULL,
    CONSTRAINT fk_carsharing_time    FOREIGN KEY (id)           REFERENCES `time`(id),
    CONSTRAINT fk_carsharing_weather FOREIGN KEY (weather_code) REFERENCES weather(weather_code),
    CONSTRAINT fk_carsharing_temp    FOREIGN KEY (temp_code)    REFERENCES temperature(temp_code)
);

-- ---------- Load data ----------
-- Change the folder path below to where you saved the CSV files.
-- Use forward slashes, e.g. C:/Users/Joshua/Desktop/carsharing_csv
-- Requires local_infile to be enabled (see the notes below).

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/path/to/carsharing_csv/weather.csv'
INTO TABLE weather
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/path/to/carsharing_csv/temperature.csv'
INTO TABLE temperature
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/path/to/carsharing_csv/time.csv'
INTO TABLE `time`
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'C:/path/to/carsharing_csv/carsharing.csv'
INTO TABLE carsharing
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- ---------- Checks ----------
SELECT 'weather' AS table_name, COUNT(*) AS row_count FROM weather
UNION ALL SELECT 'temperature', COUNT(*) FROM temperature
UNION ALL SELECT 'time', COUNT(*) FROM `time`
UNION ALL SELECT 'carsharing', COUNT(*) FROM carsharing;
-- Expected: 4, 331, 8708, 8708
