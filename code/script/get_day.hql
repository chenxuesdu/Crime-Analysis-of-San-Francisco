SELECT
  date, COUNT(1)
FROM
(
  SELECT
    from_unixtime(CAST(time/1000 AS bigint),"yyyy-MM-dd") AS date
  FROM incidents
) t
GROUP BY date
ORDER BY date;

