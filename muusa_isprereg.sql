DROP FUNCTION IF EXISTS muusa_isprereg&
CREATE FUNCTION muusa_isprereg (id INT, year YEAR)
   RETURNS BOOL DETERMINISTIC
BEGIN
   RETURN (SELECT IF(IFNULL(SUM(h.amount),0) + muusa_getprogramfee(id, year) <= 0,1,0)
   	FROM muusa_year y LEFT JOIN muusa_charge h ON h.camperid=id AND h.year=y.year AND h.timestamp<y.prereg 
   	WHERE y.year=year GROUP by h.camperid);
   -- Only works for 2014 or later
END&