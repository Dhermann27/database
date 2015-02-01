DROP PROCEDURE IF EXISTS `muusa_generate_charges`&
CREATE DEFINER=`muusa`@`localhost` PROCEDURE `muusa_generate_charges`()
BEGIN
	TRUNCATE muusa_chargegen;
	INSERT INTO muusa_chargegen (year, camperid, amount, chargetypeid, memo)
		SELECT ya.year, ya.camperid, muusa_getrate(ya.camperid, ya.year) amount, 1000, d.name
			FROM muusa_yearattending ya, muusa_camper c, muusa_room r, muusa_building d
			WHERE ya.roomid!=0 AND ya.camperid=c.id AND ya.roomid=r.id AND r.buildingid=d.id AND muusa_getrate(ya.camperid, ya.year)>0;
	INSERT INTO muusa_chargegen (year, camperid, amount, chargetypeid, memo)
		SELECT ya.year, ya.camperid, LEAST(muusa_getprogramfee(ya.camperid, ya.year), 30*ya.days) amount, 1003, CONCAT(c.firstname, " ", c.lastname) 
			FROM muusa_yearattending ya, muusa_camper c
			WHERE ya.camperid=c.id;
	INSERT INTO muusa_chargegen (year, camperid, amount, chargetypeid, memo)
		SELECT bsp.year, bsp.camperid, -(bsp.registration_amount+bsp.housing_amount) amount, 1021, bsp.staffpositionname
		FROM muusa_byyear_staff bsp;
END&