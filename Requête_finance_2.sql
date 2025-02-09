/* Analyser le CA des commandes des deux derniers mois par pays, année 2023*/
SELECT
    Pays,
    priceEach,
    buyPrice,
    Marge,
    quantityOrdered,
    CA,
    productDescription,
    Date_Commande,
    Mois_commande,
    Categories,
    productVendor,
    MSRP
FROM
    (   
        SELECT
            country AS Pays,
            sum(quantityOrdered * priceeach) as CA,
            ((priceEach - buyPrice)* quantityOrdered) as Marge, 
            orderDate as Date_Commande,
            MONTH(orderDate) as Mois_commande,
            orderDate,
            productLine as Categories,
            productName as Nom_produit,
            priceEach,
            productVendor,
            buyPrice,
            MSRP,
            quantityOrdered,
            productDescription,
            RANK () OVER (PARTITION BY country ORDER BY orderDate DESC) as Ranking
        FROM
            customers
        JOIN
            orders
        ON
            customers.customerNumber = orders.customerNumber
        JOIN
            orderdetails
        ON
            orders.orderNumber = orderdetails.orderNumber
        JOIN
            products
        ON
            products.productCode=orderdetails.productCode
        GROUP BY
            country,
            date_commande,
            productLine,
            productName,
            productVendor,
            priceeach,
            buyPrice,
            MSRP,
            quantityOrdered,
            productDescription
        ORDER BY
            orderDate DESC
    ) as subquery
WHERE
    orderDate BETWEEN "2023-01-01" AND "2023-02-28"
ORDER BY
    pays DESC
