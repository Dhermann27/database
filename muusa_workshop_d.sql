DROP TRIGGER IF EXISTS muusa_workshop_d&
CREATE TRIGGER muusa_workshop_d AFTER DELETE ON muusa_workshop
FOR EACH ROW
BEGIN
	DELETE FROM muusa_yearattending__workshop WHERE workshopid=OLD.id;
END&