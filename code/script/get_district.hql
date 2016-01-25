SELECT district, COUNT(1) AS district_num FROM incidents GROUP BY district ORDER BY district_num;
