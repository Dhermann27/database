DROP VIEW IF EXISTS muusa_thisyear_charge&
CREATE VIEW muusa_thisyear_charge AS 
	SELECT c.familyid, c.id camperid, bh.id chargeid, bh.amount, bh.is_deposited, 
    	bh.chargetypeid, g.name chargetypename, bh.timestamp, bh.memo 
    FROM muusa_camper c, muusa_byyear_charge bh, muusa_chargetype g, muusa_year y
    WHERE c.id=bh.camperid AND bh.chargetypeid=g.id AND bh.year=y.year AND y.is_current=1&