DROP TRIGGER IF EXISTS muusa_charge_u&
CREATE TRIGGER muusa_charge_u AFTER UPDATE ON muusa_charge
FOR EACH ROW
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE familyid INT DEFAULT 0;
	DECLARE yearattendingids VARCHAR(1024) DEFAULT "";
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
	
	SELECT c.familyid, GROUP_CONCAT(ya.id) INTO familyid, yearattendingids 
		FROM muusa_camper c, muusa_camper cp, muusa_yearattending ya 
		WHERE c.id=NEW.camperid AND c.familyid=cp.familyid AND ya.camperid=cp.id AND ya.year=NEW.year 
		GROUP BY c.familyid;

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
			UPDATE muusa_yearattending SET paydate=stamp WHERE FIND_IN_SET(id, yearattendingids);
		ELSE
			UPDATE muusa_yearattending SET paydate=NULL WHERE FIND_IN_SET(id, yearattendingids);
		END IF;
	END IF;
END&