DROP TRIGGER IF EXISTS muusa_yearattending_i&
CREATE TRIGGER muusa_yearattending_i AFTER INSERT ON muusa_yearattending
FOR EACH ROW
BEGIN
	INSERT INTO muusa_yearattending__staff (staffpositionid, yearattendingid, created_by) SELECT staffpositionid, NEW.id, 'muusa_yearattending_i' FROM muusa_camperid__staff WHERE camperid=NEW.camperid;
	DELETE FROM muusa_camperid__staff WHERE camperid=NEW.camperid;
END&