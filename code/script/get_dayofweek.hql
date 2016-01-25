SELECT dayofweek, COUNT(1) AS day_num FROM incidents GROUP BY dayofweek ORDER BY day_num;
