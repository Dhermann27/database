DROP VIEW IF EXISTS jml_docman_groups&
CREATE VIEW jml_docman_groups AS 
	SELECT groups_id, groups_name, groups_description, groups_access, 
	(SELECT GROUP_CONCAT(u.id) FROM jml_users u, muusa_camper c, muusa_yearattending ya 
		WHERE u.email=c.email AND c.id=ya.camperid AND ya.year=SUBSTR(groups_name,1,4)) AS groups_members
	FROM jml_docman_group&