DROP VIEW IF EXISTS muusa_thisyear_volunteer&
CREATE VIEW muusa_thisyear_volunteer AS
	SELECT bvp.year, familyid, camperid, volunteerpositionid, positionname, firstname, lastname
    FROM muusa_byyear_volunteer bvp, muusa_year y
    WHERE bvp.year=y.year AND y.is_current=1&