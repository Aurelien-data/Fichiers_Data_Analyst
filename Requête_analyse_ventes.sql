/* Analyser le nombre de produits vendues par catégories et par mois*/
SELECT
    productLine AS Categories,
    MONTH(orderDate) AS Mois_de_commande,
    SUM(quantityOrdered * priceEach) as CA_Categories,
    ((priceEach-buyPrice)* quantityOrdered) as Marge,
    quantityOrdered,
    YEAR(orderDate) AS Année_de_commande,
    orderDate
FROM
    orderdetails
LEFT JOIN
    orders
ON
    orderdetails.orderNumber=orders.orderNumber
RIGHT JOIN
    products
ON
    products.productCode=orderdetails.productCode
WHERE
    productLine
        IN ('Classic Cars', 'Motorcycles', 'Planes', 'Trucks and Buses', 'Vintage Cars', 'Trains', 'Ships')
AND
    MONTH(orderDate)
AND
    YEAR(orderDate)
GROUP BY
    productLine,
    quantityOrdered,
    orderdate,
    Marge
ORDER BY
    productLine,
    orderDate ASC ;