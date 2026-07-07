--BA-C01 — Top 10 Customers by Total Spending
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.Quantity AS BIGINT)) AS TotalUnitsPurchased,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    TotalSpending DESC;

--BA-C02 — Customers with the Most Orders
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    TotalOrders DESC;

--BA-C03 — Average Order Value (AOV) by Customer
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    AVG(CAST(o.NetRevenue AS DECIMAL(18,2))) AS AverageOrderValue -- Menggunakan DECIMAL agar hasil rata-rata punya koma desimal dan tidak overflow
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    AverageOrderValue DESC;

--BA-C04 — Customer Lifetime Value (CLV)
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS CustomerLifetimeValue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS LifetimeProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    CustomerLifetimeValue DESC;

--BA-C05 — Customers Purchasing the Highest Quantity
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    SUM(CAST(o.Quantity AS BIGINT)) AS TotalUnitsPurchased,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    TotalUnitsPurchased DESC;

--BA-C06 — Customer Segment
SELECT
    CustomerID,
    CustomerName,
    TotalSpending,
    CASE
        WHEN TotalSpending >= 100000000 THEN 'VIP'
        WHEN TotalSpending >= 50000000 THEN 'Gold'
        WHEN TotalSpending >= 10000000 THEN 'Silver'
        ELSE 'Regular'
    END AS CustomerSegment
FROM(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending
    FROM Orders o
    JOIN Customers c
        ON o.CustomerID = c.CustomerID
    GROUP BY
        c.CustomerID,
        c.CustomerName) CustomerSummary
ORDER BY
    TotalSpending DESC;

--BA-C07 — Number of Customers by Segment
SELECT
    CustomerSegment,
    COUNT(*) AS TotalCustomers
FROM(
    SELECT
        CASE
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 100000000 THEN 'VIP'
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 50000000 THEN 'Gold'
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 10000000 THEN 'Silver'
            ELSE 'Regular'
        END AS CustomerSegment
    FROM Orders o
    GROUP BY
        o.CustomerID) Segmentation
GROUP BY
    CustomerSegment
ORDER BY
    TotalCustomers DESC;

--BA-C08 — Revenue by Customer Segment
SELECT
    CustomerSegment,
    COUNT(*) AS TotalCustomers,
    SUM(CAST(TotalSpending AS BIGINT)) AS TotalRevenue
FROM(
    SELECT
        SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending,
        CASE
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 100000000 THEN 'VIP'
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 50000000 THEN 'Gold'
            WHEN SUM(CAST(o.NetRevenue AS BIGINT)) >= 10000000 THEN 'Silver'
            ELSE 'Regular'
        END AS CustomerSegment
    FROM Orders o
    GROUP BY
        o.CustomerID) CustomerSegmentSummary
GROUP BY
    CustomerSegment
ORDER BY
    TotalRevenue DESC;

/*BA-C09 — Which customers have made repeat purchases?
Business Question: Which customers have placed more than one order?*/
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(o.OrderID) > 1
ORDER BY
    TotalOrders DESC;

/*BA-C10 — Which customers have made only one purchase?
Business Question: Which customers have placed only one order?*/
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalSpending
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(o.OrderID) = 1
ORDER BY
    TotalSpending DESC;

/*BA-C11 — Which customer locations generate the highest revenue?
Business Question: Which customer locations contribute the most revenue?*/
SELECT
    c.Location,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.Quantity AS BIGINT)) AS TotalUnits,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.Location
ORDER BY
    SUM(CAST(o.NetRevenue AS BIGINT)) DESC; -- Menggunakan fungsi SUM asli di ORDER BY untuk menghindari ambiguitas alias

/*BA-C12 — Revenue by Gender
Business Question: How does revenue differ by customer gender?*/
SELECT
    c.Gender,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.Quantity AS BIGINT)) AS TotalUnits,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.Gender
ORDER BY
    SUM(CAST(o.NetRevenue AS BIGINT)) DESC;

/*BA-C13 — Revenue by Age Group
Business Question: Which customer age groups generate the highest revenue?*/
SELECT
    CASE
        WHEN c.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN c.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END AS AgeGroup,
    COUNT(DISTINCT c.CustomerID) AS TotalCustomers,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    CASE
        WHEN c.Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN c.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55+'
    END
ORDER BY
    SUM(CAST(o.NetRevenue AS BIGINT)) DESC;

/*BA-C14 — Which customers generate the highest profit?
Business Question: Which customers contribute the highest profit?*/
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) DESC;

/*BA-C15 — Customer Purchase Summary
Business Question: What is the overall purchasing performance of each customer?*/
SELECT
    c.CustomerID,
    c.CustomerName,
    c.Gender,
    c.Age,
    c.Location,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(CAST(o.Quantity AS BIGINT)) AS TotalUnitsPurchased,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit,
    AVG(CAST(o.NetRevenue AS DECIMAL(18,2))) AS AverageOrderValue
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.Gender,
    c.Age,
    c.Location
ORDER BY
    SUM(CAST(o.NetRevenue AS BIGINT)) DESC;