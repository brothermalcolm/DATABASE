/* fn_sunvector: 
 * Computes Julian day. Reproduces the R utio function JD in insol package
 *  SELECT fn_eqtime('2013-01-01 05:00:00')
 */

 DELIMITER $$
 CREATE FUNCTION fn_solpos
(
    jd			double precision,
    latitude	double precision,
    longitude	double precision,
    timezone	INT,
    param		CHAR(3)
)
RETURNS double precision
BEGIN

	DECLARE omegar, deltar, lambdar, svx, svy, svz, solpos double precision;

	SET omegar = fn_hourangle(jd,longitude,timezone);
	SET deltar = radians(fn_declination(jd));
	SET lambdar = radians(latitude);
	SET svx = -sin(omegar)*cos(deltar);
	SET svy = sin(lambdar)*cos(omegar)*cos(deltar)-cos(lambdar)*sin(deltar);
	SET svz = cos(lambdar)*cos(omegar)*cos(deltar)+sin(lambdar)*sin(deltar);
    
    #azimuth = degrees(pi - atan2(sunv[,1],sunv[,2]  ) )
	#zenith = degrees(acos(sunv[,3]))
    
    IF param = 'azi' THEN SET solpos = degrees(pi() - atan2(svx,svy));
    ELSEIF param = 'zen' THEN SET solpos = degrees(acos(svz));
    END IF;
    
    #return svx;
    return solpos;
	#return(cbind(svx,svy,svz));
    
END$$
DELIMITER ;