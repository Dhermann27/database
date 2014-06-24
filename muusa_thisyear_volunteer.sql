DROP VIEW IF EXISTS muusa_thisyear_volunteer&
CREATE VIEW muusa_thisyear_volunteer AS
	SELECT familyid, camperid, volunteerpositionid, volunteerpositionname, firstname, lastname, email
    FROM muusa_byyear_volunteer bvp, muusa_year y
    WHERE bvp.year=y.year AND y.is_current=1&