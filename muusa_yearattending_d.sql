DROP TRIGGER IF EXISTS muusa_yearattending_d&
CREATE TRIGGER muusa_yearattending_d AFTER DELETE ON muusa_yearattending
FOR EACH ROW
BEGIN
	DELETE FROM muusa_yearattending__staff WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_yearattending__volunteer WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_yearattending__workshop WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_roommatepreference WHERE yearattendingid=OLD.id;
END&