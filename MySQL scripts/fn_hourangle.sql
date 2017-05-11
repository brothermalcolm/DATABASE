/* fn_hourangle: 
 * Computes Julian day. Reproduces the R utio function JD in insol package
 *  SELECT fn_eqtime('2013-01-01 05:00:00')
 */

 DELIMITER $$
 CREATE FUNCTION fn_hourangle
(
    jd			double precision,
    longitude	double precision,
    timezone	INT
)
RETURNS double precision
BEGIN

	DECLARE hr, eqtime, stndmeridian, deltalontime, omegar double precision;
	#SET hr = ((jd-floor(jd))*24+12) % 24;
    SET hr = mod(((jd-floor(jd))*24+12),24);
	SET eqtime = fn_eqtime(jd);
	SET stndmeridian = timezone*15;    			
	SET deltalontime = longitude-stndmeridian;
	SET deltalontime = deltalontime * 24.0/360.0;
	SET omegar = pi()*(((hr + deltalontime + eqtime/60)/12.0) - 1.0);
	RETURN omegar;
    
END$$
DELIMITER ;