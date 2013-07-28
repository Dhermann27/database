DROP TRIGGER IF EXISTS muusa_workshopfee_d&
CREATE TRIGGER muusa_workshopfee_d AFTER DELETE ON muusa_yearattending__workshop
FOR EACH ROW
BEGIN
	DECLARE fee FLOAT DEFAULT 0.0;
	SELECT w.fee INTO fee FROM muusa_workshop w WHERE w.id=OLD.workshopid;
	IF fee>0 THEN
		DELETE h FROM muusa_charge h
		INNER JOIN (muusa_yearattending ya, muusa_workshop w)
			ON ya.id=OLD.yearattendingid AND w.id=OLD.workshopid 
		WHERE h.camperid=ya.camperid AND h.year=ya.year AND h.chargetypeid=1002 AND h.memo=w.name;
   END IF;
END&