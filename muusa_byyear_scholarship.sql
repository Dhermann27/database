DROP VIEW IF EXISTS muusa_byyear_scholarship&
CREATE VIEW muusa_byyear_scholarship AS
	SELECT h.id, h.year, c.familyid, c.id camperid, IFNULL(ya.id,0) yearattendingid, c.firstname, c.lastname,
    	h.chargetypeid, g.name, h.amount, h.created_at, h.created_by
    FROM (muusa_camper c, muusa_charge h, muusa_chargetype g)
    LEFT JOIN muusa_yearattending ya ON c.id=ya.camperid AND h.year=ya.year
    WHERE c.id=h.camperid AND h.chargetypeid=g.id AND h.chargetypeid IN (1013,1019)&