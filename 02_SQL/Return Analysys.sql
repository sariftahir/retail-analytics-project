--Query 1 — Total Return per Product
SELECT
    p.ProductName,
    SUM(r.QuantityReturned) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.ProductName
ORDER BY TotalReturned DESC;


-- Query 2 — Return berdasarkan Category
SELECT
    p.Category,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.Category
ORDER BY TotalReturned DESC;

-- Query 3 — Return berdasarkan Brand
SELECT
    p.Brand,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.Brand
ORDER BY TotalReturned DESC;

-- Query 4 — Return Reason paling banyak (Menggunakan COUNT, sudah aman bawaan)
SELECT
    ReturnReason,
    COUNT(*) AS TotalCases
FROM Returns
GROUP BY
    ReturnReason
ORDER BY TotalCases DESC;

-- Query 5 — Return per Bulan
SELECT
    d.MonthName,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Dates d
    ON r.DateKey = d.DateKey
GROUP BY
    d.MonthName
ORDER BY
    MIN(d.MonthNumberOfYear);

-- Query 6 — Return per Tahun
SELECT
    d.CalendarYear,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Dates d
    ON r.DateKey = d.DateKey
GROUP BY
    d.CalendarYear
ORDER BY
    d.CalendarYear;

-- Query 7 — Return Rate per Product
SELECT
    p.ProductName,
    SUM(CAST(o.Quantity AS BIGINT)) AS QuantitySold,
    ISNULL(SUM(CAST(r.QuantityReturned AS BIGINT)), 0) AS QuantityReturned,
    ROUND(
        ISNULL(SUM(CAST(r.QuantityReturned AS BIGINT)), 0) * 100.0 /
        NULLIF(SUM(CAST(o.Quantity AS BIGINT)), 0), 2
    ) AS ReturnRate
FROM Orders o
LEFT JOIN Returns r
    ON o.OrderID = r.OrderID
JOIN Products p
    ON o.ProductID = p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    ReturnRate DESC;

-- Query 8 — Revenue yang Direturn
SELECT
    SUM(CAST(o.SellingPrice AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedRevenue
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;

-- Query 9 — Cost dari Barang Return
SELECT
    SUM(CAST(o.UnitCost AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedCost
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;

-- Query 10 — Produk dengan Return Rate tertinggi
SELECT TOP 10
    p.ProductName,
    ROUND(
        ISNULL(SUM(CAST(r.QuantityReturned AS BIGINT)), 0) * 100.0 /
        NULLIF(SUM(CAST(o.Quantity AS BIGINT)), 0), 2
    ) AS ReturnRate
FROM Orders o
LEFT JOIN Returns r
    ON o.OrderID = r.OrderID
JOIN Products p
    ON o.ProductID = p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    ReturnRate DESC;

-- Query 11 — Return berdasarkan Promotion
SELECT
    pr.PromotionName,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID
JOIN Promotions pr
    ON o.PromotionID = pr.PromotionID
GROUP BY
    pr.PromotionName
ORDER BY
    TotalReturned DESC;

-- Query 12 — Return berdasarkan Sales Channel
SELECT
    pr.Channel,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID
JOIN Promotions pr
    ON o.PromotionID = pr.PromotionID
GROUP BY
    pr.Channel;

-- Query 13 — Return berdasarkan Customer Segment
SELECT
    pr.CustomerSegment,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID
JOIN Promotions pr
    ON o.PromotionID = pr.PromotionID
GROUP BY
    pr.CustomerSegment
ORDER BY
    TotalReturned DESC;

-- Query 14 — Return berdasarkan Weekend vs Weekday
SELECT
    d.IsWeekend,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Dates d
    ON r.DateKey = d.DateKey
GROUP BY
    d.IsWeekend;

-- Query 15 — Return Performance Summary
SELECT
    COUNT(DISTINCT r.ReturnID) AS TotalReturnTransactions,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalQuantityReturned,
    SUM(CAST(o.SellingPrice AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedRevenue,
    SUM(CAST(o.UnitCost AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedCost,
    SUM((CAST(o.SellingPrice AS BIGINT) - CAST(o.UnitCost AS BIGINT)) * CAST(r.QuantityReturned AS BIGINT)) AS LostProfit
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;
