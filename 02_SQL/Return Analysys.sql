-- Total Return per Product
SELECT
    p.ProductName,
    SUM(r.QuantityReturned) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.ProductName
ORDER BY TotalReturned DESC;


-- Return by Category
SELECT
    p.Category,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.Category
ORDER BY TotalReturned DESC;

-- Return by Brand
SELECT
    p.Brand,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Products p
    ON r.ProductID = p.ProductID
GROUP BY
    p.Brand
ORDER BY TotalReturned DESC;

-- Most Return Reasons (Using COUNT, already safe by default)
SELECT
    ReturnReason,
    COUNT(*) AS TotalCases
FROM Returns
GROUP BY
    ReturnReason
ORDER BY TotalCases DESC;

-- Return per Month
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

-- Return per Year
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

-- Return Rate per Product
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

-- Returned Revenue
SELECT
    SUM(CAST(o.SellingPrice AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedRevenue
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;

-- Cost of Returned Goods
SELECT
    SUM(CAST(o.UnitCost AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedCost
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;

-- Products with the Highest Return Rate
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

-- Return by Promotion
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

-- Return by Sales Channel
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

-- Return by Customer Segment
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

-- Return by Weekend vs Weekday
SELECT
    d.IsWeekend,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalReturned
FROM Returns r
JOIN Dates d
    ON r.DateKey = d.DateKey
GROUP BY
    d.IsWeekend;

-- Return Performance Summary
SELECT
    COUNT(DISTINCT r.ReturnID) AS TotalReturnTransactions,
    SUM(CAST(r.QuantityReturned AS BIGINT)) AS TotalQuantityReturned,
    SUM(CAST(o.SellingPrice AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedRevenue,
    SUM(CAST(o.UnitCost AS BIGINT) * CAST(r.QuantityReturned AS BIGINT)) AS ReturnedCost,
    SUM((CAST(o.SellingPrice AS BIGINT) - CAST(o.UnitCost AS BIGINT)) * CAST(r.QuantityReturned AS BIGINT)) AS LostProfit
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID;
