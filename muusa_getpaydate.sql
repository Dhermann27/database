DROP FUNCTION IF EXISTS muusa_getpaydate&
CREATE FUNCTION muusa_getpaydate (familyid INT, year YEAR)
   RETURNS TIMESTAMP DETERMINISTIC
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE credit, charges FLOAT DEFAULT 0.0;
	DECLARE stamp TIMESTAMP DEFAULT NULL;
	DECLARE cur1 CURSOR FOR
		SELECT SUM(s1.amount), s1.timestamp FROM
			(SELECT h.amount, h.timestamp FROM muusa_charge h, muusa_camper c
			WHERE h.camperid=c.id AND h.amount<0 AND c.familyid=familyid AND h.year=year
				UNION ALL
			SELECT -(bsp.registration_amount+bsp.housing_amount), bsp.created_at 
			FROM muusa_byyear_staff bsp
			WHERE bsp.familyid=familyid AND bsp.year=year) s1
		GROUP BY timestamp ORDER BY timestamp;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	SELECT muusa_getnowbalance(familyid, year) INTO charges;
		
	OPEN cur1;
	countdown: LOOP
 		FETCH cur1 INTO credit, stamp;
 		SET charges = charges + credit;
        IF charges<=0.0 or done THEN
        	LEAVE countdown;
        END IF;
	END LOOP countdown;
	CLOSE cur1;
	IF charges<=0.0 THEN
		RETURN stamp;
	ELSE 
		RETURN NULL;
	END IF;
END&