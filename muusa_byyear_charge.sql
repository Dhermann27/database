DROP VIEW IF EXISTS muusa_byyear_charge&
CREATE VIEW muusa_byyear_charge AS
	SELECT h.id, h.year, c.familyid, h.camperid, h.amount, h.is_deposited, h.chargetypeid, 
	    g.name chargetypename, h.timestamp, h.memo
	FROM muusa_charge h, muusa_chargetype g, muusa_camper c
	WHERE h.chargetypeid=g.id AND h.camperid=c.id
	UNION ALL 
		SELECT 0, hg.year, c.familyid, hg.camperid, hg.amount, NULL, g.id, g.name, NULL, hg.memo 
		FROM muusa_camper c, muusa_chargegen hg, muusa_chargetype g
		WHERE c.id=hg.camperid AND g.id=hg.chargetypeid&