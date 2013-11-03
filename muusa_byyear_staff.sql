DROP VIEW IF EXISTS muusa_byyear_staff&
CREATE VIEW muusa_byyear_staff AS
	SELECT ya.year, c.familyid, c.id camperid, ya.id yearattendingid, c.firstname, c.lastname,
    	IF(COUNT(sp.housing_amount)=1,sp.name,'Multiple Credits') positionname, sp.id positionid, 
    	LEAST(muusa_getprogramfee(c.id, ya.year), SUM(sp.registration_amount)) registration_amount,
    	LEAST(muusa_getrate(c.id, ya.year), SUM(sp.housing_amount)) housing_amount,
    	sp.programid, ysp.created_by, ysp.created_at
    FROM (muusa_camper c, muusa_yearattending ya, muusa_yearattending__staff ysp, muusa_staffposition sp)
    LEFT JOIN muusa_scholarship sc ON sc.yearattendingid=ya.id
    WHERE c.id=ya.camperid AND ya.id=ysp.yearattendingid AND ysp.staffpositionid=sp.id AND
    	ya.year>=sp.start_year AND ya.year<=sp.end_year
    GROUP BY ya.year, c.id&
    -- No staff position id because of multiple credits line, must be multiple credits due to amount limits