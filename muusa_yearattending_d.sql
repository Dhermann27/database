DROP TRIGGER IF EXISTS muusa_yearattending_d&
CREATE TRIGGER muusa_yearattending_d AFTER DELETE ON muusa_yearattending
FOR EACH ROW
BEGIN
	DELETE FROM muusa_yearattending__staff WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_yearattending__volunteer WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_yearattending__workshop WHERE yearattendingid=OLD.id;
	DELETE FROM muusa_roommatepreference WHERE yearattendingid=OLD.id;
	DELETE FROM jml_user_usergroup_map WHERE user_id=(SELECT u.id FROM jml_users u, muusa_camper c WHERE u.email=c.email AND c.id=OLD.camperid) AND group_id=(SELECT id FROM jml_usergroups WHERE title LIKE OLD.year);
END&