DROP FUNCTION IF EXISTS muusa_getnowbalance&
CREATE FUNCTION muusa_getnowbalance (familyid INT, year YEAR)
   RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (SELECT SUM(s1.amount) FROM
	(SELECT h.amount FROM muusa_charge h, muusa_camper c
		WHERE h.camperid=c.id AND h.amount>0 AND c.familyid=familyid AND h.year=year
	UNION ALL
		SELECT muusa_getprogramfee(ya.camperid, ya.year) amount
		FROM muusa_yearattending ya, muusa_camper c
		WHERE ya.camperid=c.id AND c.familyid=familyid AND ya.year=year) s1);
END&