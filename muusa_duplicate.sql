DROP PROCEDURE IF EXISTS muusa_duplicate_p&
DROP PROCEDURE IF EXISTS muusa_duplicate&
CREATE PROCEDURE muusa_duplicate (beforeid INT, afterid INT)
BEGIN
  IF beforeid != 0 AND afterid != 0 THEN
     UPDATE muusa_fiscalyear SET camperid=999 WHERE camperid=beforeid;
     UPDATE muusa_charges SET camperid=999 WHERE camperid=beforeid;
     UPDATE muusa_fiscalyear SET camperid=afterid WHERE camperid=999;
     UPDATE muusa_charges SET camperid=afterid WHERE camperid=999;
     DELETE FROM muusa_phonenumbers WHERE camperid=beforeid;
     DELETE FROM muusa_campers WHERE camperid=beforeid;
  END IF;
END&