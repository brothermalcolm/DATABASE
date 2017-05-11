/* fn_eqtime: 
 * Computes Julian day. Reproduces the R utio function JD in insol package
 *  SELECT fn_eqtime('2013-01-01 05:00:00')
 */

 DELIMITER $$
 CREATE FUNCTION fn_eqtime
(
    jd		double precision
)
RETURNS DOUBLE precision
BEGIN

    DECLARE jdc DOUBLE precision;
    declare sec DOUBLE precision;
    declare e0 DOUBLE precision;
    declare ecc DOUBLE precision;
    declare oblcorr DOUBLE precision;
    declare y1 DOUBLE precision;
    declare l0 DOUBLE precision;
    declare rl0 DOUBLE precision;
    declare gmas DOUBLE precision; 
    declare EqTime DOUBLE precision;
    
    SET jdc = (jd - 2451545.0)/36525.0;
	SET sec = 21.448 - jdc*(46.8150 + jdc*(0.00059 - jdc*(0.001813)));
	SET e0 = 23.0 + (26.0 + (sec/60.0))/60.0;
	SET ecc = 0.016708634 - jdc * (0.000042037 + 0.0000001267 * jdc);
	SET oblcorr = e0 + 0.00256 * cos(radians(125.04 - 1934.136 * jdc)); 
	SET y1 = pow(tan(radians(oblcorr)/2),2);
	SET l0 = 280.46646 + jdc*(36000.76983 + jdc*0.0003032);
    #l0 = (l0-360*(l0%/%360))%%360
	#SET l0 = (l0-360*(l0 DIV 360))%360;
    SET l0 = mod((l0-360*(l0 DIV 360)), 360);
	SET rl0 = radians(l0);
	SET gmas = 357.52911 + jdc * (35999.05029 - 0.0001537 * jdc);
	SET gmas=radians(gmas);
	SET EqTime = y1*sin(2*rl0)-2.0*ecc*sin(gmas)+4.0*ecc*y1*sin(gmas)*cos(2*rl0)-
		0.5*pow(y1,2)*sin(4*rl0)-1.25*pow(ecc,2)*sin(2*gmas);
	#return jdc;
	RETURN degrees(EqTime)*4.0;
    
END$$
DELIMITER ;