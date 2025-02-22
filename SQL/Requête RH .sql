


/*
==> RESSOURCES HUMAINES
-- Analyser pour chaque mois les deux vendeurs ayant réalisé le plus de chiffre d’affaires 
-- je dois afficher pour chaque année, mois par mois, les deux meilleurs vendeurs
-- JOINTURE ORDERDETAILS x ORDERS x CUSTOMERS x EMPLOYEES
*/
SELECT
    seller_id,
    CONCAT (firstName, ' ', lastName)as Employee,
    month,
    ca,
    revenue_rank
FROM (
    SELECT
        e.employeeNumber AS seller_id,
        e.firstName,
        e.lastName,
        DATE_FORMAT(o.orderDate, '%Y-%m') AS month,
        SUM(od.quantityOrdered * od.priceEach) AS ca,
        RANK() OVER (PARTITION BY DATE_FORMAT(o.orderDate, '%Y-%m') ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS revenue_rank
    FROM
        employees AS e
    JOIN
        customers AS c
                ON e.employeeNumber = c.salesRepEmployeeNumber
    JOIN
         orders AS o
                 ON c.customerNumber = o.customerNumber
    JOIN
         orderdetails AS od
                    ON o.orderNumber = od.orderNumber
    GROUP BY
        e.employeeNumber,
        month
) AS subquery
WHERE
    revenue_rank <= 2
ORDER BY
    month,
    revenue_rank,
    ca DESC;