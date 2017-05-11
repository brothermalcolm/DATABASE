DROP PROCEDURE IF EXISTS sp_create_basic_station_table;

DELIMITER //
CREATE PROCEDURE sp_create_basic_station_table(station_id int)
BEGIN
    SET @id = station_id;
    SET @q = CONCAT('
        CREATE TABLE IF NOT EXISTS `tbl_live_basic_station_' , @id, '` 
        (
        `station_id` int,
		`Tm`		 datetime,
		`Rec_ID`	 int,
		`AvgTamb`	 float,
		`AvgHamb`	 varchar(10),
		`AvgGSi00`	 float,
		`AvgTSi00`	 float,
		`missing`	 char(1),
       unique (`Tm`)
        ) 
    ');
    PREPARE stmt FROM @q;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
END //

