DROP PROCEDURE IF EXISTS sp_populate_super_station;

DELIMITER //
CREATE PROCEDURE sp_populate_super_station(station_id int)

BEGIN

	case station_id
    
		when 401 then 	
			replace into tbl_live_super_station_401
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 402 then 	
			replace into tbl_live_super_station_402
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 403 then 	
			replace into tbl_live_super_station_403
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 404 then 	
			replace into tbl_live_super_station_404
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 405 then 	
			replace into tbl_live_super_station_405
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 406 then 	
			replace into tbl_live_super_station_406
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 407 then 	
			replace into tbl_live_super_station_407
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 408 then 	
			replace into tbl_live_super_station_408
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 409 then 	
			replace into tbl_live_super_station_409
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
		when 410 then 	
			replace into tbl_live_super_station_410
			select station_id, Tm, Rec_ID, AvgTamb, AvgHamb, AvgGSi00, AvgTSi00, AvgSPN1_G, AvgSPN1_D, AvgWind_S, AvgWind_D, AvgAir_P, missing 
			from tbl_staging_super_station;
                        
	end case;
    
END //
    