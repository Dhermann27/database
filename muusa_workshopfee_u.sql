DROP TRIGGER IF EXISTS muusa_workshopfee_u&
CREATE TRIGGER muusa_workshopfee_u AFTER UPDATE ON muusa_workshop
FOR EACH ROW
BEGIN
	IF OLD.fee<1.0 AND NEW.fee>1.0 THEN
		INSERT INTO muusa_charge
			(camperid, amount, memo, chargetypeid, timestamp, year, created_by, created_at)
			SELECT ya.camperid, NEW.fee, NEW.name, 1002, CURRENT_TIMESTAMP, ya.year,
			'muusa_workshopfee_u', CURRENT_TIMESTAMP
			FROM muusa_yearattending ya, muusa_yearattending__workshop yw
			WHERE ya.id=yw.yearattendingid AND yw.workshopid=NEW.id;
	ELSEIF OLD.fee>1.0 AND NEW.fee<1.0 THEN
		DELETE h FROM muusa_charge h
		INNER JOIN (muusa_yearattending ya, muusa_yearattending__workshop yw)
			ON ya.id=yw.yearattendingid AND yw.workshopid=NEW.id 
		WHERE h.camperid=ya.camperid AND h.year=ya.year AND h.chargetypeid=1002 AND h.memo=OLD.name;
	ELSEIF (OLD.fee>1.0 AND NEW.fee>1.0 AND ABS(OLD.fee-NEW.fee)>1.0) OR OLD.name!=NEW.name THEN
		UPDATE muusa_charge h, muusa_yearattending ya, muusa_yearattending__workshop yw
		SET h.amount=NEW.fee, h.memo=NEW.name, h.created_by='muusa_workshopfee_u'
		WHERE h.camperid=ya.camperid AND h.year=ya.year AND ya.id=yw.yearattendingid 
			AND yw.workshopid=NEW.id AND h.chargetypeid=1002 AND h.memo=OLD.name;
	END IF;
END&
