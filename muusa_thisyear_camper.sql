DROP VIEW IF EXISTS muusa_thisyear_camper&
CREATE VIEW muusa_thisyear_camper AS 
	SELECT familyid, familyname, address1, address2, city, statecd, zipcd, country, 
    	id, sexcd, firstname, lastname, email, birthdate, birthday, age, 
    	gradeoffset, grade, programid, programname, sponsor, is_handicap, foodoptionid, 
    	churchid, churchname, churchcity, churchstatecd, yearattendingid, paydate, days, 
    	roomid, roomnbr, buildingid, buildingname
    FROM muusa_byyear_camper bc, muusa_year y 
    WHERE bc.year=y.year AND y.is_current=1&