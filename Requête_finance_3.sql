/* Analyser les commandes n'ayant pas encore été payées */

WITH debit AS (
    -- requête pour le montant payé des commandes
                SELECT
                    c.customerNumber,
                    od.orderNumber,
                    o.orderDate,
                    SUM(od.quantityOrdered * od.priceEach) AS debt
                FROM
                    customers AS c
                JOIN
                    orders AS o
                        ON c.customerNumber = o.customerNumber
                JOIN
                    orderdetails AS od
                        ON o.orderNumber = od.orderNumber
                WHERE
                    od.orderNumber NOT IN (
                                            SELECT
                                                orderNumber
                                            FROM
                                                orders
                                            WHERE
                                                STATUS = 'On Hold' OR STATUS = 'Cancelled'
                                            )
                GROUP BY
                    c.customerNumber,
                    od.orderNumber,
                    o.orderDate
                ORDER BY
                    c.customerNumber,
                    od.orderNumber,
                    o.orderDate),
    -- requête pour le montant cumulé des commandes
    cumulativedebit AS (
                SELECT
                    db.customerNumber,
                    db.orderNumber,
                    db.orderDate,
                    db.debt,
                    SUM(db.debt) OVER (PARTITION BY customerNumber ORDER BY orderNumber) AS cumulative_debt
                FROM
                    debit AS db)
SELECT
    db.customerNumber,
    db.orderNumber,
    db.orderDate,
    db.debt,
    SUM(amount),
    cumulative_debt - SUM(p.amount) AS you_need_to_pay
FROM
    cumulativedebit AS db
INNER JOIN
    payments AS p
        ON p.customerNumber = db.customerNumber
GROUP BY
    db.customerNumber,
    db.orderNumber,
    db.orderDate
HAVING
    you_need_to_pay > 0
ORDER BY
    customerNumber,
    orderNumber