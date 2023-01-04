/* How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer? */

SELECT COUNT(*)
FROM
	(SELECT a.name
	FROM orders o
	JOIN accounts a
	ON a.id = o.account_id
	GROUP BY 1
	HAVING SUM(o.total) > (SELECT sum_std_qty
						FROM (SELECT a.name AS account, SUM(standard_qty) AS sum_std_qty
								FROM accounts a
								JOIN orders o
								ON a.id = o.account_id
								GROUP BY 1
								ORDER BY 2 DESC
								LIMIT 1) sub)) t2
							