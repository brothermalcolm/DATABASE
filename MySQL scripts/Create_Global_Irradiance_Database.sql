###################################################################################################
## Script Name:   Create_Global_Irradiance_Database.SQL
## Purpose:       All tables, stored proceduires and functions for global database
## Date Created:  23rd August 2016
## Dependencies:  MySQL installation

##  !!!Any changes must be commented here!!!
##  Dev notes:    v1.0 created  23/08/2016  MR
##                v1.1 modified DD/MM/YYYY  WHO?
###################################################################################################


#Create the database (delete it first if we need to)
drop database if exists seriscixi;
create database seriscixi;

use seriscixi;

###################################################################################################

#Location static data table
drop table if exists tbl_station_information;
create table tbl_station_information
(
original_id			int,
station_id			int,
station_name		varchar(100),
latitude			float,
longitude			float,
elevation			float,
che_basin_id		int,
che_basin_name		varchar(50),
station_type		varchar(5)
);

#Load the source csv file
LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/stations.txt'
INTO TABLE tbl_station_information
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES; #header

###################################################################################################

#staging tables for super and basic stations
drop table if exists tbl_staging_super_station;
create table tbl_staging_super_station
(
station_id	int,
obsTm		varchar(40),
Tm			datetime,
Rec_ID		int,
AvgTamb		float,
AvgHamb		float,
AvgGSi00	float,
AvgTSi00	float,
AvgSPN1_G	float,
AvgSPN1_D	float,
AvgWind_S	float,
AvgWind_D	float,
AvgAir_P	float,
missing		char(1)
);

drop table if exists tbl_staging_basic_station;
create table tbl_staging_basic_station
(
station_id	int,
obsTm		varchar(40),
Tm			datetime,
Rec_ID		int,
AvgTamb		float,
AvgHamb		varchar(10), #sometimes NaN
AvgGSi00	float,
AvgTSi00	float,
missing		char(1)
);

#live tables for super stations
drop table if exists tbl_live_super_station_401;
call sp_create_super_station_table(401);
drop table if exists tbl_live_super_station_402;
call sp_create_super_station_table(402);
drop table if exists tbl_live_super_station_403;
call sp_create_super_station_table(403);
drop table if exists tbl_live_super_station_404;
call sp_create_super_station_table(404);
drop table if exists tbl_live_super_station_405;
call sp_create_super_station_table(405);
drop table if exists tbl_live_super_station_406;
call sp_create_super_station_table(406);
drop table if exists tbl_live_super_station_407;
call sp_create_super_station_table(407);
drop table if exists tbl_live_super_station_408;
call sp_create_super_station_table(408);
drop table if exists tbl_live_super_station_409;
call sp_create_super_station_table(409);
drop table if exists tbl_live_super_station_410;
call sp_create_super_station_table(410);

#live tables for basic stations
drop table if exists tbl_live_basic_station_411;
call sp_create_basic_station_table(411);
drop table if exists tbl_live_basic_station_412;
call sp_create_basic_station_table(412);
drop table if exists tbl_live_basic_station_413;
call sp_create_basic_station_table(413);
drop table if exists tbl_live_basic_station_414;
call sp_create_basic_station_table(414);
drop table if exists tbl_live_basic_station_415;
call sp_create_basic_station_table(415);
drop table if exists tbl_live_basic_station_416;
call sp_create_basic_station_table(416);
drop table if exists tbl_live_basic_station_417;
call sp_create_basic_station_table(417);
drop table if exists tbl_live_basic_station_418;
call sp_create_basic_station_table(418);
drop table if exists tbl_live_basic_station_419;
call sp_create_basic_station_table(419);
drop table if exists tbl_live_basic_station_420;
call sp_create_basic_station_table(420);
drop table if exists tbl_live_basic_station_421;
call sp_create_basic_station_table(421);
drop table if exists tbl_live_basic_station_422;
call sp_create_basic_station_table(422);
drop table if exists tbl_live_basic_station_423;
call sp_create_basic_station_table(423);
drop table if exists tbl_live_basic_station_424;
call sp_create_basic_station_table(424);
drop table if exists tbl_live_basic_station_425;
call sp_create_basic_station_table(425);

###################################################################################################

#Data for flaggin missing data and generating filler data with clear sky irradiance model
drop table if exists tbl_station_missing_data;
create table tbl_station_missing_data
(
station_id		int,
Tm				datetime,
jd				double precision,
azimuth			float,
zenith			float,
azimuth_rad		float,
zenith_rad		float,
declination		float,
declination_rad	float,
E0				float,
csi				float
);

#Data for flagging duplicates
drop table if exists tbl_station_duplicate_data;
create table tbl_station_duplicate_data
(
station_id		int,
Tm				datetime,
cnt				int
);

#table for reporting missing data
drop table if exists tbl_station_process_status;
create table tbl_station_process_status
(
station_id	int,
Tm			datetime,
cnt			float
);

drop table if exists tbl_station_process_history;
create table tbl_station_process_history
(
station_id	int,
d			date,
processed	char(1),
comments	varchar(50)
);

drop table if exists tbl_station_spurious_data;
create table tbl_station_spurious_data
(
station_id	int,
Tm 			datetime,
irradiance	float,
comments	varchar(30)
);


###################################################################################################

#Calendar tables for processing missing information
CREATE TABLE tbl_calendar(dt datetime);
CREATE TABLE tbl_calendar_time(t time);

LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/tbl_calendar_time.csv'
INTO TABLE tbl_calendar_time
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';

#CREATE TABLE tbl_calendar_2013(dt datetime);
#CREATE TABLE tbl_calendar_2014(dt datetime);
#CREATE TABLE tbl_calendar_2015(dt datetime);
#CREATE TABLE tbl_calendar_2016(dt datetime);

#LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/tbl_calendar_2013.csv'
#INTO TABLE tbl_calendar_2013
#FIELDS TERMINATED BY ','
#LINES TERMINATED BY '\r\n';
#delete from tbl_calendar_2013 where dt < "2013-05-01 00:06:00";

#LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/tbl_calendar_2014.csv'
#INTO TABLE tbl_calendar_2014
#FIELDS TERMINATED BY ','
#LINES TERMINATED BY '\r\n';

#LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/tbl_calendar_2015.csv'
#INTO TABLE tbl_calendar_2015
#FIELDS TERMINATED BY ','
#LINES TERMINATED BY '\r\n';

#LOAD DATA LOCAL INFILE 'C:/MARTIN/PROJECTS/DATABASE/Source_Data/csv_files/tbl_calendar_2016.csv'
#INTO TABLE tbl_calendar_2016
#FIELDS TERMINATED BY ','
#LINES TERMINATED BY '\r\n';

