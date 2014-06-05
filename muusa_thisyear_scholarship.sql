DROP VIEW IF EXISTS muusa_thisyear_scholarship&
CREATE VIEW muusa_thisyear_scholarship AS 
	SELECT bsc.id, bsc.familyid, bsc.camperid, bsc.firstname, bsc.lastname,
    	bsc.chargetypeid, bsc.name, bsc.amount
    FROM muusa_byyear_scholarship bsc, muusa_year y 
    WHERE bsc.year=y.year AND y.is_current=1&