    DROP VIEW IF EXISTS muusa_thisyear__camper&
    CREATE VIEW muusa_thisyear__camper AS 
    	SELECT yc.year, familyid, familyname, address1, address2, city, statecd, zipcd, country, 
    		camperid, sexcd, firstname, lastname, email, birthdate, birthday, age, 
    		gradeoffset, grade, programid, programname, sponsor, is_handicap, foodoptionid, 
    		churchiid, churchname, churchcity, churchstatecd, yearattendingid, days, 
    		roomid, roomnbr, buildingid, buildingname
    		FROM muusa_yearattending__camper yc, muusa_year y 
    		WHERE yc.year=y.year AND y.is_current=1&