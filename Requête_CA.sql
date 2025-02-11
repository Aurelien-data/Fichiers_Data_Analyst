SELECT  sum(quantityOrdered * priceeach)
FROM orderdetails
JOIN orders
    ON orderdetails.orderNumber = orders.orderNumber
JOIN customers
    ON orders.customerNumber = customers.customerNumber
ORDER BY sum(quantityOrdered * priceeach) DESC;