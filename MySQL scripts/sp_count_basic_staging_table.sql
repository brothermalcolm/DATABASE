DROP PROCEDURE IF EXISTS sp_count_basic_staging_table;

DELIMITER //
CREATE PROCEDURE sp_count_basic_staging_table()

BEGIN
    
    select count(1) as rowcount from tbl_staging_basic_station;
    
END //
