DROP VIEW IF EXISTS muusa_byyear_scholarship&
CREATE VIEW muusa_byyear_scholarship AS
	SELECT sc.id, ya.year, c.familyid, c.id camperid, ya.id yearattendingid, c.firstname, c.lastname,
    	IF(sc.is_muusa, 1013, 1019) chargetypeid,
    	IF(sc.is_muusa,'MUUSA Scholarship','YMCA Scholarship') name,
    	ROUND(sc.registration_pct * muusa_getprogramfee(c.id, ya.year), 2) registration_amount,
    	ROUND(IF(sc.is_muusa=0,sc.housing_pct * muusa_getymcafee(c.id, ya.year) * ya.days,
    			sc.housing_pct * muusa_getrate(c.id, ya.year) +
    			IFNULL(scp.housing_pct * 
    				(muusa_getrate(c.id, ya.year) - muusa_getymcafee(c.id, ya.year) * ya.days),0)), 2) 
    				housing_amount,
    	sc.created_at, sc.created_by
    FROM (muusa_camper c, muusa_yearattending ya, muusa_scholarship sc)
    LEFT JOIN muusa_scholarship scp ON
    	sc.yearattendingid=scp.yearattendingid AND scp.is_muusa=0
    WHERE c.id=ya.camperid AND ya.id=sc.yearattendingid&