DROP FUNCTION IF EXISTS muusa_getprogramfee&
CREATE FUNCTION muusa_getprogramfee (id INT, year YEAR)
   RETURNS FLOAT DETERMINISTIC
BEGIN
	DECLARE age, grade INT DEFAULT 0;
	SELECT muusa_getage(c.birthdate, year), muusa_getage(c.birthdate, year)+c.gradeoffset INTO age, grade FROM muusa_camper c WHERE c.id=id;
	RETURN (SELECT registration_fee FROM muusa_program p WHERE p.agemin<=age AND p.agemax>=age AND p.grademin<=grade AND p.grademax>=grade LIMIT 1);
END&