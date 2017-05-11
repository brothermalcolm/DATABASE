/* fn_JD: 
 * Computes Julian day. Reproduces the R utio function JD in insol package
 *  SELECT fn_jd('2013-01-01 05:00:00')
 */
DELIMITER $$
CREATE FUNCTION fn_jd
(
    sourcedatetime	DATETIME
)
RETURNS double precision
BEGIN

    DECLARE jd double precision;
    #DECLARE converted_time DATETIME;
    #SET converted_time = CONVERT_TZ(sourcedatetime, 'Asia/Singapore', 'GMT');
    SET jd = (UNIX_TIMESTAMP(sourcedatetime)+28800)/86400  + 2440587.5;
    #SET jd = TO_DAYS(sourcedatetime) + 1721060;

    RETURN jd;
	
END$$
DELIMITER ;