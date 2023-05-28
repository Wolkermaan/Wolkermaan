
/* my solution */

SELECT t2.region, COUNT(t1.total_amount)
FROM
	(SELECT region, SUM(total_amount)
	FROM
		(SELECT r.name AS region, o.total_amt_usd as total_amount
		FROM region r
		JOIN sales_reps s
		ON r.id = s.region_id
		JOIN accounts a
		ON s.id = a.sales_rep_id
		JOIN orders o
		ON a.id = o.account_id
		ORDER BY 2 DESC) t1
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1) t2
JOIN 
		(SELECT r.name AS region, o.total_amt_usd as total_amount
		FROM region r
		JOIN sales_reps s
		ON r.id = s.region_id
		JOIN accounts a
		ON s.id = a.sales_rep_id
		JOIN orders o
		ON a.id = o.account_id
		ORDER BY 2 DESC) t1
ON t1.region = t2.region
GROUP BY 1

/* Udacity solution */

SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (
      SELECT MAX(total_amt)
      FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
              FROM sales_reps s
              JOIN accounts a
              ON a.sales_rep_id = s.id
              JOIN orders o
              ON o.account_id = a.id
              JOIN region r
              ON r.id = s.region_id
              GROUP BY r.name) sub);
