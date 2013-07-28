    DROP VIEW IF EXISTS muusa_byyear_staff&
    CREATE VIEW muusa_byyear_staff AS
    	SELECT ya.year, c.familyid, c.id camperid, sp.id staffpositionid, c.firstname, c.lastname,
    		IF(COUNT(sp.housing_amount)=1,sp.name,'Multiple Credits') positionname,
    		sp.programid, LEAST(hr.amount, SUM(sp.registration_amount)) registration_amount,
    		IF(hh.amount>0, 
    			LEAST(hh.amount,SUM(sp.housing_amount)), LEAST(50,SUM(sp.housing_amount))) housing_amount
    	FROM (muusa_camper c, muusa_yearattending ya, muusa_yearattending__staff ysp, muusa_staffposition sp)
    	LEFT JOIN muusa_charge hr ON c.id=hr.camperid AND ya.year=hr.year AND hr.chargetypeid=1003
    	LEFT JOIN muusa_charge hh ON c.id=hh.camperid AND ya.year=hh.year AND hh.chargetypeid=1000
    	LEFT JOIN muusa_scholarship sc ON sc.yearattendingid=ya.id
    	WHERE c.id=ya.camperid AND ya.id=ysp.yearattendingid AND ysp.staffpositionid=sp.id AND
    		ya.year>=sp.start_year AND ya.year<=sp.end_year
    	GROUP BY ya.year, c.id&