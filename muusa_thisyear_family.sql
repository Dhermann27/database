DROP VIEW IF EXISTS muusa_thisyear_family&
CREATE VIEW muusa_thisyear_family AS 
	SELECT yf.year, id, name, address1, address2, city, statecd, zipcd, country
    FROM muusa_byyear_family yf, muusa_year y 
    WHERE yf.year=y.year AND y.is_current=1&