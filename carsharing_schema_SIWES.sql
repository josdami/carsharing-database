
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS carsharing;
DROP TABLE IF EXISTS time;
DROP TABLE IF EXISTS temperature;
DROP TABLE IF EXISTS weather;

CREATE TABLE weather (
    weather_code INTEGER PRIMARY KEY,
    weather      TEXT NOT NULL UNIQUE
);

CREATE TABLE temperature (
    temp_code     VARCHAR(25) PRIMARY KEY,
    temp          REAL NOT NULL,
    temp_feel     REAL NOT NULL,
    temp_category TEXT NOT NULL CHECK (temp_category IN ('Cold', 'Mild', 'Hot'))
);

CREATE TABLE time (
    id           INTEGER PRIMARY KEY,
    timestamp    TEXT NOT NULL,          -- YYYY-MM-DD HH:MM:SS
    season       TEXT NOT NULL,
    hour         INTEGER NOT NULL CHECK (hour BETWEEN 0 AND 23),
    weekday_name TEXT NOT NULL,
    month_name   TEXT NOT NULL
);

CREATE TABLE carsharing (
    id           INTEGER PRIMARY KEY REFERENCES time(id),
    holiday      TEXT NOT NULL CHECK (holiday IN ('Yes', 'No')),
    workingday   TEXT NOT NULL CHECK (workingday IN ('Yes', 'No')),
    weather_code INTEGER NOT NULL REFERENCES weather(weather_code),
    temp_code    VARCHAR(25) NOT NULL REFERENCES temperature(temp_code),
    humidity     REAL,
    windspeed    REAL,
    demand       REAL NOT NULL           -- log(1 + rentals)
);

CREATE INDEX idx_df_weather ON carsharing(weather_code);
CREATE INDEX idx_df_temp    ON carsharing(temp_code);
