DROP PROCEDURE IF EXISTS sp_process_station;

DELIMITER //
CREATE PROCEDURE sp_process_station(station_id int, d varchar(10))

BEGIN
    
    #Get station type (super or basic)
    select date(d) into d;
    
    if station_id in (401, 402, 403, 404, 405, 406, 407, 408, 409, 410) then
    	call sp_process_super_station(station_id, d);
    elseif station_id in (411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425) then
		call sp_process_basic_station(station_id, d);
    end if;
    
END //