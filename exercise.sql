SELECT t3.salesRep, t2.region, t2.max_sales
FROM
	(SELECT region, MAX(total_sales) as max_sales
	FROM 
		(SELECT s.name AS salesRep, r.name AS region, SUM(o.total_amt_usd) AS total_sales
		FROM region r
		JOIN sales_reps s
		ON r.id = s.region_id
		JOIN accounts a
		ON s.id = a.sales_rep_id
		JOIN orders o
		ON a.id = o.account_id
		GROUP BY 1, 2) t1
	GROUP BY 1
	ORDER BY 2 DESC) t2
JOIN
	(SELECT s.name AS salesRep, r.name AS region, SUM(o.total_amt_usd) AS total_sales
	FROM region r
	JOIN sales_reps s
	ON r.id = s.region_id
	JOIN accounts a
	ON s.id = a.sales_rep_id
	JOIN orders o
	ON a.id = o.account_id
	GROUP BY 1, 2) t3
ON t2.region = t3.region AND t2.max_sales = t3.total_sales
ORDER BY 3 DESC