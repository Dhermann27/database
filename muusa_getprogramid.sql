DROP FUNCTION IF EXISTS muusa_getprogramid&
CREATE FUNCTION muusa_getprogramid (id INT, year YEAR)
	RETURNS INT DETERMINISTIC
BEGIN
	DECLARE age, grade INT DEFAULT 0;
	SELECT muusa_getage(c.birthdate, year), muusa_getage(c.birthdate, year)+c.gradeoffset INTO age, grade FROM muusa_camper c WHERE c.id=id;
	RETURN(SELECT p.id FROM muusa_program p WHERE p.agemin<=age AND p.agemax>=age AND 
		p.grademin<=grade AND p.grademax>=grade AND year>=p.start_year AND year<=p.end_year LIMIT 1);
END&