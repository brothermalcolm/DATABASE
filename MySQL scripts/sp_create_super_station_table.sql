DROP PROCEDURE IF EXISTS sp_create_super_station_table;

DELIMITER //
CREATE PROCEDURE sp_create_super_station_table(station_id int)
BEGIN
    SET @id = station_id;
    SET @q = CONCAT('
        CREATE TABLE IF NOT EXISTS `tbl_live_super_station_' , @id, '` 
        (
        `station_id` int,
		`Tm`		 datetime,
		`Rec_ID`	 int,
		`AvgTamb`	 float,
		`AvgHamb`	 float,
		`AvgGSi00`	 float,
		`AvgTSi00`	 float,
		`AvgSPN1_G`	 float,
		`AvgSPN1_D`  float,
		`AvgWind_S`  float,
		`AvgWind_D`	 float,
		`AvgAir_P`	 float,
		`missing`	 char(1),
        unique (`Tm`)
        ) 
    ');
    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
END //