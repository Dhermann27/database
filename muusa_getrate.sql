DROP FUNCTION IF EXISTS muusa_getrate&
CREATE FUNCTION muusa_getrate (camperid INT, year YEAR)
   RETURNS FLOAT DETERMINISTIC
BEGIN
   DECLARE age, adults, children, days, staff, programid INT DEFAULT 0;
   SELECT muusa_getage(c.birthdate, year), SUM(IF(muusa_getage(cp.birthdate, year)>17,1,0)), 
   		SUM(IF(muusa_getage(cp.birthdate, year)<=17,1,0)), ya.days, IF(ysp.staffpositionid>0,1,0), 
   		muusa_getprogramid(camperid, year)
   		INTO age, adults, children, days, staff, programid 
   		FROM (muusa_camper c, muusa_yearattending ya, muusa_yearattending yap, muusa_camper cp) 
   		LEFT JOIN muusa_yearattending__staff ysp
   			ON ysp.yearattendingid=ya.id AND ysp.staffpositionid IN (1023,1025)
   		WHERE c.id=camperid AND c.id=ya.camperid AND ya.year=year AND ya.roomid=yap.roomid
   			AND ya.year=yap.year AND yap.camperid=cp.id;
   IF staff=1 THEN
      RETURN days * 58;
      -- DAH Meyer/Burt Staff Housing Rate $58.00/night
	ELSE
		RETURN (SELECT FORMAT(IF(age>5, IFNULL(hr.amount*days,0), 0),2) 
              FROM muusa_yearattending ya, muusa_room r, muusa_housingrate hr 
              WHERE ya.camperid=camperid AND ya.year=year AND r.id=ya.roomid AND 
              	r.buildingid=hr.buildingid AND hr.programid=programid AND 
              	(hr.occupancy_adult=adults OR (hr.occupancy_adult=999 AND adults>0)) AND 
              	(hr.occupancy_children=children OR (hr.occupancy_children=999 AND children>0)) AND
              	year>=hr.start_year AND year<=hr.end_year);
   END IF;
END&