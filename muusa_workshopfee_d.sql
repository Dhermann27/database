DROP TRIGGER IF EXISTS muusa_workshopfee_d&
CREATE TRIGGER muusa_workshopfee_d AFTER DELETE ON muusa_yearattending__workshop
FOR EACH ROW
BEGIN
	DECLARE fee FLOAT DEFAULT 0.0;
	DECLARE camperid, year INT DEFAULT 0;
	DECLARE name VARCHAR(50) DEFAULT '';
	SELECT w.name, w.fee INTO name, fee FROM muusa_workshop w WHERE w.id=OLD.workshopid;
	IF fee>0 THEN
		SELECT ya.camperid, ya.year INTO camperid, year FROM muusa_yearattending ya WHERE ya.id=OLD.yearattendingid;
		DELETE h FROM muusa_charge h WHERE h.camperid=camperid AND h.year=year AND h.chargetypeid=1002 AND h.memo=name;
   END IF;
END&