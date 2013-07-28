    DROP VIEW IF EXISTS muusa_thisyear_staff&
    CREATE VIEW muusa_thisyear_staff AS
    	SELECT bsp.year, familyid, camperid, staffpositionid, firstname, lastname,
    		positionname, programid, registration_amount, housing_amount
    	FROM muusa_byyear_staff bsp, muusa_year y
    	WHERE bsp.year=y.year AND y.is_current=1&