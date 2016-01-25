SELECT time, COUNT(1)
FROM
(SELECT from_unixtime(cast(time/1000 as bigint),"HH") AS time
    FROM incidents) t
GROUP BY time
ORDER BY time;
