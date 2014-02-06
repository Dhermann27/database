DROP VIEW IF EXISTS muusa_thisyear_family&
CREATE VIEW muusa_thisyear_family AS 
	SELECT yf.id, yf.name, yf.address1, yf.address2, yf.city, yf.statecd, yf.zipcd, yf.country, yf.count, muusa_getpaydate(yf.id, y.year) paydate 
    FROM muusa_byyear_family yf, muusa_year y 
    WHERE yf.year=y.year AND y.is_current=1&