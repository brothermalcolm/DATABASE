DELIMITER $$
CREATE FUNCTION fn_csi
(
    declination_rad float, 
    zenith float, 
    zenith_rad	float
)
RETURNS float
BEGIN

    DECLARE E0, csi float;
    
    IF cos(zenith_rad) < 0.0 THEN 
		#sun below horizon
		SET csi = 0.0;
	else
		SET E0 = 1.000110 + 0.034221 * cos(declination_rad) + 0.001280 * sin(declination_rad) + 0.000719 * cos(2 * declination_rad) + 0.000077 * sin(2 * declination_rad);
		SET csi = 0.8298 * E0 * 1362.0 * pow(cos(zenith_rad), 1.3585) * exp(-0.00135 * (90 - zenith));
	end if;

    RETURN csi;
	
END$$
DELIMITER ;