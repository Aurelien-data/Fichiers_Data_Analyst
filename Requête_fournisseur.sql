
# productVendor


SELECT
    productVendor,
    SUM(quantityOrdered) as Total_volume,
    SUM(quantityOrdered * priceEach) as CA,
    orderdate,
    MONTH(orderdate) as Mois_commande,
    YEAR(orderDate) as Annee_commande,
    priceEach,
    buyPrice
FROM
    products
JOIN
    orderdetails
    ON
        products.productCode = orderdetails.productCode
JOIN
    orders
    ON
        orders.orderNumber = orderdetails.orderNumber
JOIN
    customers
    ON
        customers.customerNumber = orders.customerNumber
GROUP BY
    productVendor,
    quantityOrdered,
    orderDate,
    priceEach,
    buyPrice,
    country
ORDER BY
    (priceEach - buyPrice) DESC





SELECT
    productVendor,
    SUM(quantityOrdered) as Total_volume_revendeur,
    SUM(quantityOrdered * priceEach) as CA
FROM
    products
JOIN
    orderdetails
    ON
        products.productCode = orderdetails.productCode
JOIN
    orders
    ON
        orders.orderNumber = orderdetails.orderNumber
JOIN
    customers
    ON
        customers.customerNumber = orders.customerNumber
GROUP BY
    productVendor
ORDER BY
    CA DESC ;
   