DROP VIEW IF EXISTS muusa_byyear_volunteer&
CREATE VIEW muusa_byyear_volunteer AS
	SELECT ya.year, c.familyid, c.id camperid, vp.id volunteerpositionid, vp.name positionname, 
    	c.firstname, c.lastname
    FROM muusa_camper c, muusa_yearattending ya, 
    	muusa_yearattending__volunteer yvp, muusa_volunteerposition vp
    WHERE c.id=ya.camperid AND ya.id=yvp.yearattendingid AND yvp.volunteerpositionid=vp.id&