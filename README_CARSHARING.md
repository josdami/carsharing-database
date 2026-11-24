# CarSharing Database and SQL Report

**Name:** Joshua Bolarinwa Aboluwarin
**Course:** SIWES-CYBERSECURITY

## Project summary

This project works with hourly data from a car-sharing company covering January 2017 to August 2018. Each row records the rental demand for one hour, along with time, weather, temperature, humidity and wind speed.

The work has three parts:
1. **Data preparation in Google Sheets:** filling missing temperature values, creating temperature and weather categories, and splitting the data into four tables.
2. **Database design in SQLite and MySQL:** building the `carsharing` database with four linked tables.
3. **SQL analysis:** answering the business questions in a report for the marketing team.

## Files

| File | Description |
|---|---|
| `carsharing.db` | Finished SQLite database (open with DB Browser for SQLite) |
| `carsharing_schema.sql` | SQLite table definitions and relationships |
| `carsharing_mysql.sql` | MySQL version: creates the database, tables, relationships, and loads the CSVs |
| `weather.csv`, `temperature.csv`, `time.csv`, `carsharing.csv` | The four tables as CSV files |
| `carsharing_queries_2017.sql` | SQL queries answering the business questions for 2017 |
| `CarSharing_Report_2017.md` | Written report with the query results |
| `Joshua_SIWES_Project.xlsx` | Google Sheets work: the cleaned data in four sheets |
| `Joshua_Database_Tables.xlsx` | Summary of the database tables and checks |

## Database structure

The `carsharing` database has four tables:

- **carsharing** (main table): `id`, `holiday`, `workingday`, `weather_code`, `temp_code`, `humidity`, `windspeed`, `demand`
- **time**: `id`, `timestamp`, `season`, `hour`, `weekday_name`, `month_name`
- **weather**: `weather_code`, `weather`
- **temperature**: `temp_code`, `temp`, `temp_feel`, `temp_category`

Relationships: `carsharing.id` links to `time.id`, `carsharing.weather_code` links to `weather.weather_code`, and `carsharing.temp_code` links to `temperature.temp_code`.

## How to load the database

**Option 1: SQLite (quickest)**
1. Install [DB Browser for SQLite](https://sqlitebrowser.org/).
2. Open `carsharing.db` with File → Open Database.

**Option 2: SQLite, built from scratch**
1. Place `carsharing_schema.sql` and the four CSV files in one folder.
2. Run `sqlite3 carsharing.db`, then `.read carsharing_schema.sql`.
3. Import each CSV with `.import --skip 1 <file>.csv <table>`, in the order weather, temperature, time, carsharing.

**Option 3: MySQL Workbench**
1. Put the four CSV files in one folder.
2. Open `carsharing_mysql.sql` in MySQL Workbench.
3. Replace `C:/path/to/carsharing_csv/` in the four `LOAD DATA` lines with your folder path.
4. Enable `OPT_LOCAL_INFILE=1` in the connection's Advanced settings, then run the script.
5. The final check should show 4, 331, 8708, and 8708 rows.

## Notes

- The `demand` column is on a log scale: each value is log(1 + number of rentals). Averages in the report are averages of this value.
- The MySQL script uses `DATETIME` for timestamps, while the SQLite version stores them as text.
