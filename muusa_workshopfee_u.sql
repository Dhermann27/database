DROP TRIGGER IF EXISTS muusa_attendees_ins_t&&
CREATE TRIGGER muusa_attendees_ins_t AFTER INSERT ON muusa_attendees
FOR EACH ROW
BEGIN
   SET @fee = (SELECT fee FROM muusa_events WHERE eventid=NEW.eventid);
   IF @fee > 0 AND (NEW.choicenbr = 1 OR NEW.timeid = 1020) THEN
       SET @camperid = (SELECT camperid FROM muusa_fiscalyear WHERE fiscalyearid=NEW.fiscalyearid);
       INSERT INTO muusa_charges (camperid, amount, memo, chargetypeid, timestamp, fiscalyear, created_by, created_at)
       VALUES (@camperid, @fee, (SELECT name FROM muusa_events WHERE eventid=NEW.eventid), 1002, CURRENT_TIMESTAMP, (SELECT year FROM muusa_currentyear), 'muusa_attendees_ins_t', CURRENT_TIMESTAMP);
   END IF;
END&&
