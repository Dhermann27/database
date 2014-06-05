DROP TRIGGER IF EXISTS muusa_yearattending_ib&
CREATE TRIGGER muusa_yearattending_ib BEFORE INSERT ON muusa_yearattending
FOR EACH ROW
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE familyid INT DEFAULT 0;
	DECLARE credit, charges FLOAT DEFAULT 0.0;
	DECLARE stamp TIMESTAMP DEFAULT NULL;
	DECLARE cur1 CURSOR FOR
		SELECT SUM(s1.amount), s1.timestamp FROM
			(SELECT h.amount, h.timestamp FROM muusa_charge h, muusa_camper c
			WHERE h.camperid=c.id AND h.amount<0 AND c.familyid=familyid AND h.year=NEW.year
				UNION ALL
			SELECT -(bsp.registration_amount+bsp.housing_amount), bsp.created_at 
			FROM muusa_byyear_staff bsp
			WHERE bsp.familyid=familyid AND bsp.year=NEW.year) s1
		GROUP BY timestamp ORDER BY timestamp;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	
	SELECT c.familyid INTO familyid FROM muusa_camper c WHERE c.id=NEW.camperid;

	IF familyid != 0 THEN
		SELECT muusa_getnowbalance(familyid, NEW.year) INTO charges;
		
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
			SET NEW.paydate=stamp;
		END IF;
	END IF;
END&