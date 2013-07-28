DROP VIEW IF EXISTS muusa_thisyear_scholarship&
CREATE VIEW muusa_thisyear_scholarship AS 
	SELECT ysc.year, ysc.familyid, ysc.camperid, ysc.firstname, ysc.lastname,
    	ysc.name, ysc.registration_amount, ysc.housing_amount
    FROM muusa_byyear_scholarship ysc, muusa_year y 
    WHERE ysc.year=y.year AND y.is_current=1&