    DROP FUNCTION IF EXISTS muusa_getymcafee&
    CREATE FUNCTION muusa_getymcafee (camperid INT, year YEAR)
       RETURNS FLOAT DETERMINISTIC
    BEGIN
    	DECLARE age INT DEFAULT 0;
    	DECLARE amount FLOAT DEFAULT 0.0;
    	SELECT muusa_getage(c.birthdate, year) INTO age FROM muusa_camper c WHERE c.id=camperid;
    	SELECT ry.amount INTO amount FROM muusa_yearattending ya, muusa_room r, muusa_ymcarate ry  
          WHERE ya.camperid=camperid AND ya.year=year AND ya.roomid=r.id AND r.buildingid=ry.buildingid AND
          	ry.agemin<=age AND ry.agemax>=age;
        RETURN amount;
    END&