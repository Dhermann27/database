    DROP VIEW IF EXISTS muusa_thisyear_charge&
    CREATE VIEW muusa_thisyear_charge AS 
    	SELECT y.year, c.familyid, c.id camperid, h.id chargeid, h.amount, h.is_deposited, 
    		h.chargetypeid, g.name chargetypename, h.timestamp, h.memo 
    		FROM muusa_camper c, muusa_charge h, muusa_chargetype g, muusa_year y
    		WHERE c.id=h.camperid AND h.chargetypeid=g.id AND h.year=y.year AND y.is_current=1&