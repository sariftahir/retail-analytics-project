-- Bagian A — CTE (3 Query)
-- Query 1 — Total Revenue per Customer (CTE)
WITH CustomerRevenue AS
(
    SELECT
        CustomerID,
        SUM(CAST(NetRevenue AS BIGINT)) AS TotalRevenue
    FROM Orders
    GROUP BY CustomerID
)
SELECT *
FROM CustomerRevenue
ORDER BY TotalRevenue DESC;

-- Belajar membuat Common Table Expression.
-- Query 2 — Revenue per Category (CTE)
WITH CategoryRevenue AS
(
    SELECT
        p.Category,
        SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Products p
        ON o.ProductID = p.ProductID
    GROUP BY
        p.Category
)
SELECT *
FROM CategoryRevenue
ORDER BY Revenue DESC;

-- Query 3 — Monthly Sales (CTE)
WITH MonthlySales AS
(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        d.MonthName,
        SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Dates d
        ON o.DateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear,
        d.MonthName
)
SELECT *
FROM MonthlySales
ORDER BY
    CalendarYear,
    MonthNumberOfYear;

-- Bagian B — ROW_NUMBER()
-- Query 4 — Ranking transaksi terbesar
SELECT
    OrderID,
    NetRevenue,
    ROW_NUMBER() OVER(ORDER BY NetRevenue DESC) AS RowNum
FROM Orders;

-- Query 5 — Ranking produk dalam setiap kategori
SELECT
    Category,
    ProductName,
    SellingPrice,
    ROW_NUMBER() OVER
    (
        PARTITION BY Category
        ORDER BY SellingPrice DESC
    ) AS Ranking
FROM Products;

-- Bagian C — RANK()
-- Query 6
SELECT
    CustomerID,
    SUM(CAST(NetRevenue AS BIGINT)) AS Revenue,
    RANK() OVER
    (
        ORDER BY SUM(CAST(NetRevenue AS BIGINT)) DESC
    ) AS CustomerRank
FROM Orders
GROUP BY CustomerID;

-- Bagian D — DENSE_RANK()
-- Query 7
SELECT
    ProductID,
    SUM(CAST(Quantity AS BIGINT)) AS Qty,
    DENSE_RANK() OVER
    (
        ORDER BY SUM(CAST(Quantity AS BIGINT)) DESC
    ) AS DenseRank
FROM Orders
GROUP BY ProductID;

-- Bagian E — NTILE()
-- Query 8
SELECT
    CustomerID,
    SUM(CAST(NetRevenue AS BIGINT)) AS Revenue,
    NTILE(4) OVER
    (
        ORDER BY SUM(CAST(NetRevenue AS BIGINT)) DESC
    ) AS Quartile
FROM Orders
GROUP BY CustomerID;

-- Bagian F — LAG()
-- Query 9
WITH MonthlyRevenue AS
(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Dates d
        ON o.DateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT *,
    LAG(Revenue) OVER
    (
        ORDER BY CalendarYear, MonthNumberOfYear
    ) AS PreviousRevenue
FROM MonthlyRevenue;

-- Bagian G — LEAD()
-- Query 10
WITH MonthlyRevenue AS
(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Dates d
        ON o.DateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT *,
    LEAD(Revenue) OVER
    (
        ORDER BY CalendarYear, MonthNumberOfYear
    ) AS NextRevenue
FROM MonthlyRevenue;

-- Bagian H — Running Total
-- Query 11
WITH MonthlyRevenue AS
(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Dates d
        ON o.DateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT *,
    SUM(CAST(Revenue AS BIGINT)) OVER
    (
        ORDER BY CalendarYear, MonthNumberOfYear
    ) AS RunningRevenue
FROM MonthlyRevenue;

-- Bagian I — Moving Average
-- Query 12
WITH MonthlyRevenue AS
(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Dates d
        ON o.DateKey = d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
)
SELECT *,
    AVG(CAST(Revenue AS BIGINT)) OVER
    (
        ORDER BY CalendarYear, MonthNumberOfYear
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAverage
FROM MonthlyRevenue;

-- Bagian J — Multi CTE
-- Query 13
WITH Revenue AS
(
    SELECT CustomerID, SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders
    GROUP BY CustomerID
),
OrdersCount AS
(
    SELECT CustomerID, COUNT(*) AS TotalOrders
    FROM Orders
    GROUP BY CustomerID
)
SELECT
    r.CustomerID,
    Revenue,
    TotalOrders
FROM Revenue r
JOIN OrdersCount o
    ON r.CustomerID = o.CustomerID;

-- Bagian K — CASE + Window
-- Query 14
SELECT
    CustomerID,
    SUM(CAST(NetRevenue AS BIGINT)) AS Revenue,
    CASE
        WHEN SUM(CAST(NetRevenue AS BIGINT)) >= 6200000000 THEN 'VIP'
        WHEN SUM(CAST(NetRevenue AS BIGINT)) >= 5500000000THEN 'Gold'
        ELSE 'Regular'
    END AS CustomerLevel
FROM Orders
GROUP BY CustomerID
ORDER BY Revenue DESC;

-- Bagian L — Top N Analysis
-- Query 15
WITH ProductSales AS
(
    SELECT
        ProductID,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders
    GROUP BY ProductID
)
SELECT TOP 10 *
FROM ProductSales
ORDER BY Revenue DESC;

-- Bagian M — Bottom N Analysis
-- Query 16
WITH ProductSales AS
(
    SELECT
        ProductID,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders
    GROUP BY ProductID
)
SELECT TOP 10 *
FROM ProductSales
ORDER BY Revenue;

-- Bagian N — Revenue Contribution
-- Query 17
WITH CategoryRevenue AS
(
    SELECT
        p.Category,
        SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
    FROM Orders o
    JOIN Products p
        ON o.ProductID = p.ProductID
    GROUP BY p.Category
)
SELECT
    Category,
    Revenue,
    ROUND(
        Revenue * 100.0 /
        NULLIF(SUM(CAST(Revenue AS BIGINT)) OVER(), 0), 2
    ) AS ContributionPercent
FROM CategoryRevenue;

-- Bagian O — Customer Lifetime Value (CLV)
-- Query 18
SELECT
    CustomerID,
    COUNT(OrderID) AS TotalOrders,
    SUM(CAST(NetRevenue AS BIGINT)) AS LifetimeRevenue,
    AVG(CAST(NetRevenue AS BIGINT)) AS AvgOrderValue
FROM Orders
GROUP BY CustomerID
ORDER BY LifetimeRevenue DESC;

-- Bagian P — Pareto Analysis (80/20)
-- Query 19
WITH ProductRevenue AS
(
    SELECT
        ProductID,
        SUM(CAST(NetRevenue AS BIGINT)) AS Revenue
    FROM Orders
    GROUP BY ProductID
)
SELECT
    ProductID,
    Revenue,
    SUM(CAST(Revenue AS BIGINT)) OVER (ORDER BY Revenue DESC) AS CumulativeRevenue
FROM ProductRevenue
ORDER BY Revenue DESC;

-- Bagian Q — Customer Recency
-- Query 20
SELECT
    CustomerID,
    MAX(DateKey) AS LastPurchaseDate
FROM Orders
GROUP BY CustomerID
ORDER BY LastPurchaseDate DESC;