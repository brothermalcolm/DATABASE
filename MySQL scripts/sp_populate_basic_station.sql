DROP PROCEDURE IF EXISTS sp_populate_basic_station;

DELIMITER //
CREATE PROCEDURE sp_populate_basic_station(station_id int)

BEGIN

	case station_id
    
		when 411 then 	
			replace into tbl_live_basic_station_411
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 412 then 	
			replace into tbl_live_basic_station_412
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 413 then 	
			replace into tbl_live_basic_station_413
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 414 then 	
			replace into tbl_live_basic_station_414
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 415 then 	
			replace into tbl_live_basic_station_415
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 416 then 	
			replace into tbl_live_basic_station_416
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 417 then 	
			replace into tbl_live_basic_station_417
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 418 then 	
			replace into tbl_live_basic_station_418
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 419 then 	
			replace into tbl_live_basic_station_419
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 420 then 	
			replace into tbl_live_basic_station_420
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 421 then 	
			replace into tbl_live_basic_station_421
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 422 then 	
			replace into tbl_live_basic_station_422
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 423 then 	
			replace into tbl_live_basic_station_423
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 424 then 	
			replace into tbl_live_basic_station_424
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
		when 425 then 	
			replace into tbl_live_basic_station_425
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, missing from tbl_staging_basic_station;
                        
	end case;
    
END //