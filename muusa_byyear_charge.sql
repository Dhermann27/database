DROP VIEW IF EXISTS muusa_byyear_charge&
CREATE VIEW muusa_byyear_charge AS
	SELECT h.id, h.year, c.familyid, h.camperid, h.amount, h.is_deposited, h.chargetypeid, 
	    g.name chargetypename, h.timestamp, h.memo
	FROM muusa_charge h, muusa_chargetype g, muusa_camper c
	WHERE h.chargetypeid=g.id AND h.camperid=c.id
	UNION ALL -- Housing Fees
		SELECT 0, ya.year, c.familyid, ya.camperid, muusa_getrate(ya.camperid, ya.year) amount, NULL, 
			1000, g.name, DATE(ya.created_at), d.name 
		FROM muusa_yearattending ya, muusa_camper c, muusa_room r, muusa_building d, muusa_chargetype g
		WHERE ya.roomid!=0 AND ya.camperid=c.id AND ya.roomid=r.id AND r.buildingid=d.id AND g.id=1000
	-- TODO: Workshop Fees
	UNION ALL -- Registration Fees
		SELECT 0, ya.year, c.familyid, ya.camperid, muusa_getprogramfee(ya.camperid, ya.year) amount, NULL, 
			1003, g.name, DATE(ya.created_at), CONCAT(c.firstname, ' ', c.lastname) 
		FROM muusa_yearattending ya, muusa_camper c, muusa_chargetype g
		WHERE ya.camperid=c.id AND g.id=1000
	UNION ALL -- Staff Credits
		SELECT 0, bsp.year, bsp.familyid, bsp.camperid, -(bsp.registration_amount+bsp.housing_amount) amount,
			NULL, 1021, g.name, DATE(bsp.created_at), bsp.positionname 
		FROM muusa_byyear_staff bsp, muusa_chargetype g
		WHERE g.id=1021&
	--UNION ALL -- Scholarships
		--SELECT 0, bsc.year, bsc.familyid, bsc.camperid, -(bsc.registration_amount+bsc.housing_amount) amount, 
			--NULL, bsc.chargetypeid, bsc.name, DATE(bsc.created_at), CONCAT(c.firstname, ' ', c.lastname) 
	--	FROM muusa_byyear_scholarship bsc, muusa_camper c
		--WHERE bsc.camperid=c.id&
