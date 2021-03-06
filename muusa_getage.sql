DROP FUNCTION IF EXISTS muusa_getage&
CREATE FUNCTION muusa_getage (birthdate DATE, year YEAR)
   RETURNS INT DETERMINISTIC
BEGIN
   RETURN DATE_FORMAT(FROM_DAYS(DATEDIFF((SELECT date FROM muusa_year y WHERE year=y.year), birthdate)), '%Y');
END&