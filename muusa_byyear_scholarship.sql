    DROP VIEW IF EXISTS muusa_byyear_scholarship&
    CREATE VIEW muusa_byyear_scholarship AS
    	SELECT ya.year, c.familyid, c.id camperid, c.firstname, c.lastname,
    	IF(sc.is_muusa,'MUUSA Scholarship','YMCA Scholarship') name,
    	ROUND(sc.registration_pct * hr.amount, 2) registration_amount,
    	ROUND(IF(sc.is_muusa=0,sc.housing_pct * muusa_getymcafee(c.id, ya.year) * ya.days,
    			sc.housing_pct * hh.amount +
    			IFNULL(scp.housing_pct * 
    				(hh.amount - muusa_getymcafee(c.id, ya.year) * ya.days),0)), 2) housing_amount
    	FROM (muusa_camper c, muusa_yearattending ya, muusa_scholarship sc)
    	LEFT JOIN muusa_charge hr ON
    		c.id=hr.camperid AND hr.year=ya.year AND hr.chargetypeid=1003
    	LEFT JOIN muusa_charge hh ON
    		c.id=hh.camperid AND hh.year=ya.year AND hh.chargetypeid=1000
    	LEFT JOIN muusa_scholarship scp ON
    		sc.yearattendingid=scp.yearattendingid AND scp.is_muusa=0
    	WHERE c.id=ya.camperid AND ya.id=sc.yearattendingid&