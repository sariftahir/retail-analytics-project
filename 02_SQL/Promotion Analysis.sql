-- Query 1 (Sudah aman karena hanya menggunakan COUNT)
SELECT
    p.PromotionName,
    p.PromoType,
    COUNT(o.OrderID) AS TotalTransactions
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName,
    p.PromoType
ORDER BY TotalTransactions DESC;

--Query 2 — Revenue per Promotion
SELECT
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY TotalRevenue DESC;

--Query 3 — Gross Revenue vs Net Revenue
SELECT
    p.PromotionName,
    SUM(CAST(o.GrossRevenue AS BIGINT)) AS GrossRevenue,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS NetRevenue,
    SUM(CAST(o.DiscountApplied AS BIGINT)) AS TotalDiscount
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY GrossRevenue DESC;

--Query 4 — Average Discount
SELECT
    p.PromotionName,
    AVG(CAST(o.DiscountApplied AS BIGINT)) AS AvgDiscount
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY AvgDiscount DESC;

--Query 5 — Cashback vs Percentage
SELECT
    p.PromoType,
    COUNT(*) AS Transactions,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromoType
ORDER BY Revenue DESC;

--Query 6 — Promotion berdasarkan Channel
SELECT
    p.Channel,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue,
    COUNT(*) AS Orders
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.Channel;

--Query 7 — Customer Segment yang paling banyak memakai promo
SELECT
    p.CustomerSegment,
    COUNT(*) AS Transactions,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.CustomerSegment
ORDER BY Transactions DESC;

--Query 8 — Promotion dengan Quantity terbesar (Ditambah CAST jika total Qty > 2 Miliar)
SELECT
    p.PromotionName,
    SUM(CAST(o.Quantity AS BIGINT)) AS QuantitySold
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY QuantitySold DESC;

--Query 9 — Average Order Value
SELECT
    p.PromotionName,
    AVG(CAST(o.NetRevenue AS BIGINT)) AS AverageOrderValue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY AverageOrderValue DESC;

--Query 10 — Revenue berdasarkan Category dan Promotion
SELECT
    pr.Category,
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Products pr
    ON o.ProductID = pr.ProductID
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    pr.Category,
    p.PromotionName
ORDER BY Revenue DESC;

--Query 11 — Revenue berdasarkan Brand dan Promotion
SELECT
    pr.Brand,
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Products pr
    ON o.ProductID = pr.ProductID
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    pr.Brand,
    p.PromotionName
ORDER BY Revenue DESC;

--Query 12 — Revenue berdasarkan Bulan
SELECT
    d.MonthName,
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Dates d
    ON o.DateKey = d.DateKey
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    d.MonthName,
    p.PromotionName
ORDER BY Revenue DESC;

--Query 13 — Top 10 Promotion
SELECT TOP 10
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY Revenue DESC;

--Query 14 — Efektivitas Promotion
SELECT
    p.PromotionName,
    SUM(CAST(o.DiscountApplied AS BIGINT)) AS TotalDiscount,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue,
    SUM(CAST(o.NetRevenue AS BIGINT)) - SUM(CAST(o.TotalCost AS BIGINT)) AS Profit
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY Profit DESC;

--Query 15 — Promotion Performance Summary
SELECT
    p.PromotionName,
    COUNT(*) AS Orders,
    SUM(CAST(o.Quantity AS BIGINT)) AS QuantitySold,
    SUM(CAST(o.GrossRevenue AS BIGINT)) AS GrossRevenue,
    SUM(CAST(o.DiscountApplied AS BIGINT)) AS Discount,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS NetRevenue,
    SUM(CAST(o.TotalCost AS BIGINT)) AS TotalCost,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS Profit
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY NetRevenue DESC;