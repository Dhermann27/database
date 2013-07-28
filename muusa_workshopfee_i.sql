DROP TRIGGER IF EXISTS muusa_workshopfee_i&
CREATE TRIGGER muusa_workshopfee_i AFTER INSERT ON muusa_yearattending__workshop
FOR EACH ROW
BEGIN
	DECLARE name VARCHAR(50);
	DECLARE camperid, timeslotid INT DEFAULT 0;
	DECLARE year YEAR(4);
	DECLARE fee FLOAT DEFAULT 0.0;
	SELECT w.name, w.fee, w.timeslotid INTO name, fee, timeslotid
	FROM muusa_workshop w WHERE w.id=NEW.workshopid;
	IF fee>0 AND (NEW.choicenbr=1 OR timeslotid=1020) THEN
		SELECT ya.camperid, ya.year INTO camperid, year FROM muusa_yearattending ya 
		WHERE id=NEW.yearattendingid;
		INSERT INTO muusa_charge
			(camperid, amount, memo, chargetypeid, timestamp, year, created_by, created_at)
		VALUES (camperid, fee, name, 1002, CURRENT_TIMESTAMP, year, 'muusa_workshopfee_i', CURRENT_TIMESTAMP);
   END IF;
END&