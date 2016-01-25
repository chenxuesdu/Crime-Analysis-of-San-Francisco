SELECT category, COUNT(1) AS category_num 
FROM incidents 
GROUP BY category 
ORDER BY category_num;
