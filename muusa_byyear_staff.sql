DROP VIEW IF EXISTS muusa_byyear_staff&
CREATE VIEW muusa_byyear_staff AS
	SELECT ya.year, c.familyid, c.id camperid, ya.id yearattendingid, c.firstname, c.lastname,
    	IF(COUNT(sp.housing_amount)=1,sp.name,'Multiple Credits') staffpositionname, sp.id staffpositionid, 
    	LEAST(muusa_getprogramfee(c.id, ya.year), SUM(sp.registration_amount)) registration_amount,
    	LEAST(IFNULL(muusa_getrate(c.id, ya.year), 0), SUM(sp.housing_amount)) housing_amount,
    	sp.programid, ysp.created_by, ysp.created_at
    FROM muusa_camper c, muusa_yearattending ya, muusa_yearattending__staff ysp, muusa_staffposition sp
    WHERE c.id=ya.camperid AND ya.id=ysp.yearattendingid AND ysp.staffpositionid=sp.id AND
    	ya.year>=sp.start_year AND ya.year<=sp.end_year
    GROUP BY ya.year, c.id
	UNION ALL  
		SELECT y.year, c.familyid, c.id, 0, c.firstname, c.lastname,
    		IF(COUNT(sp.housing_amount)=1,sp.name,'Multiple Credits'), sp.id, 
    		LEAST(muusa_getprogramfee(c.id, y.year), SUM(sp.registration_amount)), 0,
    		sp.programid, cs.created_by, cs.created_at
    	FROM muusa_camperid__staff cs, muusa_camper c, muusa_staffposition sp, muusa_year y
    	WHERE cs.camperid=c.id AND cs.staffpositionid=sp.id AND y.is_current=1 AND sp.registration_amount>0
    	GROUP BY c.id&
    -- No staff position id because of multiple credits line, must be multiple credits due to amount limits