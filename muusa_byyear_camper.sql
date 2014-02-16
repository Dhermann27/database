DROP VIEW IF EXISTS muusa_byyear_camper&
CREATE VIEW muusa_byyear_camper AS 
	SELECT ya.year, f.id familyid, f.name familyname, 
    	f.address1, f.address2, f.city, f.statecd, f.zipcd, f.country, 
    	c.id, c.sexcd, c.firstname, c.lastname, c.email, 
    	c.birthdate, DATE_FORMAT(c.birthdate, '%m/%d/%Y') birthday, 
    	muusa_getage(c.birthdate, ya.year) age, 
    	c.gradeoffset, muusa_getage(c.birthdate, ya.year)+c.gradeoffset grade, 
    	p.id programid, p.name programname, c.sponsor, c.is_handicap, c.foodoptionid, 
    	u.id churchiid, u.name churchname, u.city churchcity, u.statecd churchstatecd, 
    	ya.id yearattendingid, ya.paydate, ya.days, ya.roomid, r.roomnbr, b.id buildingid, b.name buildingname
    FROM (muusa_family f, muusa_camper c, muusa_yearattending ya, muusa_program p) 
    LEFT JOIN (muusa_building b, muusa_room r) ON ya.roomid=r.id AND r.buildingid=b.id 
    LEFT JOIN muusa_church u ON c.churchid=u.id
    WHERE f.id=c.familyid AND c.id=ya.camperid AND p.id=muusa_getprogramid(c.id, ya.year)