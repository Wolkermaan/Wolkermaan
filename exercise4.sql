/* For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel? */

/* My solution */
SELECT t1.customer, t2.channel, SUM(t2.num_times)
FROM
	(SELECT a.id, a.name customer, SUM(o.total_amt_usd) total
	FROM accounts a
	JOIN orders o 
	ON a.id = o.account_id
	GROUP BY 1, 2
	ORDER BY 3 DESC
	LIMIT 1) t1
JOIN
	(SELECT a.id, a.name customer, w.channel, COUNT(occurred_at) num_times
	FROM web_events w
	JOIN accounts a
	ON a.id = w.account_id
	GROUP BY 1, 2, 3
	ORDER BY 1) t2
ON t1.customer = t2.customer
GROUP BY 1, 2
ORDER BY 3

/* the solution suggested by Udacity */

SELECT a.name, w.channel, COUNT(*)
FROM accounts a
JOIN web_events w
ON a.id = w.account_id AND a.id =  (SELECT id
                     FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                           FROM orders o
                           JOIN accounts a
                           ON a.id = o.account_id
                           GROUP BY a.id, a.name
                           ORDER BY 3 DESC
                           LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;