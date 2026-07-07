--Revenue by Promotion
SELECT
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY TotalRevenue DESC;

--Gross Revenue vs Net Revenue
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

--Average Discount by Promotion
SELECT
    p.PromotionName,
    AVG(CAST(o.DiscountApplied AS BIGINT)) AS AvgDiscount
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY AvgDiscount DESC;

--Cashback vs Percentage Discount Performance
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

--Promotion Performance by Channel
SELECT
    p.Channel,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue,
    COUNT(*) AS Orders
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.Channel;

--Customer Segment with the Highest Promotion Usage
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

--Promotion with the Highest Quantity Sold (Use CAST if Total Quantity > 2 Billion)
SELECT
    p.PromotionName,
    SUM(CAST(o.Quantity AS BIGINT)) AS QuantitySold
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY QuantitySold DESC;

--Average Order Value by Promotion
SELECT
    p.PromotionName,
    AVG(CAST(o.NetRevenue AS BIGINT)) AS AverageOrderValue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY AverageOrderValue DESC;

--Revenue by Category and Promotion
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

--Revenue by Brand and Promotion
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

--Monthly Revenue by Promotion
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

--Top 10 Promotions by Revenue
SELECT TOP 10
    p.PromotionName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS Revenue
FROM Orders o
JOIN Promotions p
    ON o.PromotionID = p.PromotionID
GROUP BY
    p.PromotionName
ORDER BY Revenue DESC;

--Promotion Effectiveness Analysis
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

--Promotion Performance Summary
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
