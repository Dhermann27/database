DROP VIEW IF EXISTS muusa_byyear_family&
CREATE VIEW muusa_byyear_family AS 
	SELECT ya.year, f.id, f.name, f.address1, f.address2, f.city, f.statecd, f.zipcd, f.country 
    FROM muusa_family f, muusa_camper c, muusa_yearattending ya
    WHERE f.id=c.familyid AND c.id=ya.camperid 
    GROUP BY f.id, ya.year&
