/* fn_declination: 
 * Computes Julian day. Reproduces the R utio function JD in insol package
 *  SELECT fn_eqtime('2013-01-01 05:00:00')
 */

 DELIMITER $$
 CREATE FUNCTION fn_declination
(
    jd		double precision
)
RETURNS double precision
BEGIN

    DECLARE jdc, sec, e0, oblcorr, l0, gmas, seqcent, suntl, sal, delta 
    double precision;
    
    SET jdc=(jd - 2451545.0)/36525.0;
	SET sec = 21.448 - jdc*(46.8150 + jdc*(0.00059 - jdc*(0.001813)));
	SET e0 = 23.0 + (26.0 + (sec/60.0))/60.0;
	SET oblcorr = e0 + 0.00256 * cos(radians(125.04 - 1934.136 * jdc))  ;
	SET l0 = 280.46646 + jdc * (36000.76983 + jdc*(0.0003032));
	#SET l0 = (l0-360*(l0 DIV 360))%360;
    SET l0 = mod((l0-360*(l0 DIV 360)),360);
	SET gmas = 357.52911 + jdc * (35999.05029 - 0.0001537 * jdc);
	SET gmas=radians(gmas);
	SET seqcent = sin(gmas) * (1.914602 - jdc * (0.004817 + 0.000014 * jdc)) + 
		sin(2*gmas) * (0.019993 - 0.000101 * jdc) + sin(3*gmas) * 0.000289;
	SET suntl = l0 + seqcent;
	SET sal = suntl - 0.00569 - 0.00478 * sin(radians(125.04 - 1934.136 * jdc));
	SET delta = asin( sin(radians(oblcorr))*sin(radians(sal)) );
	return degrees(delta);
    
END$$
DELIMITER ;