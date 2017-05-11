DROP PROCEDURE IF EXISTS sp_process_super_station;

DELIMITER //
CREATE PROCEDURE sp_process_super_station(station_id int, d date)

proc:BEGIN
	
    #testing file quality parameters
    declare rowcount, datecount integer;
    declare today date;
    #singapore regional information
    declare lat, lon, Isc, E0 float;
    declare timezone integer;
    set timezone = 8;
    set Isc = 1362.0;
    
    #query station table to get latitude and longitude of the station
    select latitude, longitude into @lat, @lon from tbl_station_information where station_id = station_id LIMIT 1;
    
    #datetime conversions
    update tbl_staging_super_station set Tm = str_to_date(obsTm, '%Y-%m-%d %H:%i:%s');
    
    #check if zero rows imported
    select count(1) from tbl_staging_super_station into @rowcount;
	if @rowcount = 0 then
		insert into tbl_station_process_history select station_id, d, 'N', 'Zero rows in file';
        leave proc;
	end if;
    
    #check if multiple dates in a file
    select count(distinct(date(Tm))) from tbl_staging_super_station into @datecount;
    if @datecount != 1 then
		insert into tbl_station_process_history select station_id, d, 'N', 'Multiple dates in file';
        leave proc;
	end if;
    
    #check date in file matches date being processed
    select distinct(date(Tm)) from tbl_staging_super_station into @today;
    if @today != d then
		insert into tbl_station_process_history select station_id, d, 'N', 'Date in file does not match process date';
        leave proc;
	end if;
    
    ##################################################################################################
    #TEST!!!
    #first flag any spurious irradiance measures e.g. too high (>1000 W/m2) or too low (<-10 Wm2)
    insert into tbl_station_spurious_data select station_id, d, greatest(AvgGsi00, AvgSPN1_G, AvgSPN1_D) as max_irradiance, 'Irradiance measure too high'
    from tbl_staging_super_station where max_irradiance > 1300;
    insert into tbl_station_spurious_data select station_id, d, least(AvgGsi00, AvgSPN1_G, AvgSPN1_D) as min_irradiance, 'Irradiance measure too low'
    from tbl_staging_super_station where min_irradiance < -10;
    ##################################################################################################
    
    #populate tbl_calendar from tbl_calendar_time
    truncate tbl_calendar;
    #select distinct(date(Tm)) into @today from tbl_staging_super_station;
    insert into tbl_calendar select STR_TO_DATE(CONCAT(d, ' ', time(t)), '%Y-%m-%d %H:%i:%s') from tbl_calendar_time;
    
    #truncate the missing data table for a new run
    truncate tbl_station_missing_data;
    
    #process missing data
    insert into tbl_station_missing_data(station_id, Tm) select station_id, dt from tbl_calendar where dt not in 
    (select Tm from tbl_staging_super_station);
    
    #set negative values of irradiance during the night to zero
    update tbl_staging_super_station set AvgGSi00 = 0 where AvgGSi00 < 0;
    
    #flag duplicates
    insert into tbl_station_duplicate_data
    select station_id, Tm, count(1) as cnt from tbl_staging_super_station group by tm having cnt > 1;

    #calculation for clear sky irradiance (csi)
    update tbl_station_missing_data set jd = fn_jd(Tm);
    update tbl_station_missing_data set azimuth = fn_solpos(jd, @lat, @lon, timezone, 'azi');
	update tbl_station_missing_data set zenith = fn_solpos(jd, @lat, @lon, timezone, 'zen');
    update tbl_station_missing_data set azimuth_rad = radians(azimuth);
    update tbl_station_missing_data set zenith_rad = radians(zenith);
    update tbl_station_missing_data set declination = fn_declination(jd);
    update tbl_station_missing_data set declination_rad = radians(declination);
    update tbl_station_missing_data	set csi = fn_csi(declination_rad, zenith, zenith_rad);
    
    #push csi into staging table for missing data points
    insert into tbl_staging_super_station(station_id, Tm, AvgGSi00, missing)
    select station_id, Tm, csi, 'Y' from tbl_station_missing_data;
	
    #generate feed statistics
    insert into tbl_station_process_status 
    select station_id, Tm, csi from tbl_station_missing_data;
    
    #push data from staging table into live table
    call sp_populate_super_station(station_id);
    
    #flag the station as processed in the history table
    insert into tbl_station_process_history select station_id, d, 'Y', '';
    
END //