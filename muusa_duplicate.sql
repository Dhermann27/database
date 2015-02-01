DROP PROCEDURE IF EXISTS `muusa_duplicate`&
CREATE DEFINER=`muusa`@`localhost` PROCEDURE `muusa_duplicate`(beforeid INT, afterid INT)
BEGIN
  IF beforeid != 0 AND afterid != 0 THEN
     UPDATE muusa_yearattending SET camperid=999 WHERE camperid=beforeid;
     UPDATE muusa_charge SET camperid=999 WHERE camperid=beforeid;
     UPDATE muusa_yearattending SET camperid=afterid WHERE camperid=999;
     UPDATE muusa_charge SET camperid=afterid WHERE camperid=999;
     DELETE FROM muusa_phonenumber WHERE camperid=beforeid;
     DELETE FROM muusa_camper WHERE id=beforeid;
  END IF;
END&