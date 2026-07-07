/*Section A — Revenue KPI
BA-S01 — What is the company's total gross revenue?*/
SELECT
    SUM(CAST(o.GrossRevenue AS BIGINT)) AS TotalGrossRevenue
FROM Orders o;

/*BA-S02 — What is the company's total net revenue?*/
SELECT
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalNetRevenue
FROM Orders o;

/*BA-S03 — What is the company's total profit?*/
SELECT
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o;

/*BA-S04 — What is the company's overall profit margin?*/
SELECT
    ROUND(
        SUM(CAST(o.NetRevenue AS DECIMAL(18,2)) - CAST(o.TotalCost AS DECIMAL(18,2))) * 100.0
        / NULLIF(SUM(CAST(o.NetRevenue AS DECIMAL(18,2))), 0), -- Menggunakan NULLIF untuk menghindari error dibagi 0
        2
    ) AS ProfitMarginPercentage
FROM Orders o;

/*BA-S05 — How does revenue trend by month?*/
SELECT
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.MonthName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Dates d ON o.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.MonthName
ORDER BY
    d.CalendarYear,
    d.MonthNumberOfYear;

/*BA-S06 — How does revenue trend by quarter?*/
SELECT
    d.CalendarYear,
    d.CalendarQuarter,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Dates d ON o.DateKey=d.DateKey
GROUP BY
    d.CalendarYear,
    d.CalendarQuarter
ORDER BY
    d.CalendarYear,
    d.CalendarQuarter;

/*BA-S07 — Which month generated the highest revenue?*/
SELECT
    d.CalendarYear,
    d.MonthName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Dates d ON o.DateKey=d.DateKey
GROUP BY
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.MonthName
ORDER BY
    TotalRevenue DESC;

/*BA-S08 — What is the average monthly revenue?*/
SELECT
    AVG(CAST(MonthRevenue AS DECIMAL(18,2))) AS AverageMonthlyRevenue
FROM(
    SELECT
        d.CalendarYear,
        d.MonthNumberOfYear,
        SUM(CAST(o.NetRevenue AS BIGINT)) AS MonthRevenue
    FROM Orders o
    JOIN Dates d ON o.DateKey=d.DateKey
    GROUP BY
        d.CalendarYear,
        d.MonthNumberOfYear
) MonthlyRevenue;

/*BA-S09 — Which product category generates the highest revenue?*/
SELECT
    p.Category,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.Category
ORDER BY
    TotalRevenue DESC;

/*BA-S10 — Which subcategory generates the highest revenue?*/
SELECT
    p.SubCategory,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.SubCategory
ORDER BY
    TotalRevenue DESC;

/*BA-S11 — Which brand generates the highest revenue?*/
SELECT
    p.Brand,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.Brand
ORDER BY
    TotalRevenue DESC;

/*BA-S12 — Top 10 products by revenue*/
SELECT TOP 10
    p.ProductName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    TotalRevenue DESC;

/*BA-S13 — Bottom 10 products by revenue*/
SELECT TOP 10
    p.ProductName,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    TotalRevenue ASC;

/*BA-S14 — Which products generate the highest profit?*/
SELECT TOP 10
    p.ProductName,
    SUM(CAST(o.NetRevenue AS BIGINT) - CAST(o.TotalCost AS BIGINT)) AS TotalProfit
FROM Orders o
JOIN Products p ON o.ProductID=p.ProductID
GROUP BY
    p.ProductName
ORDER BY
    TotalProfit DESC;

/*BA-S15 — Which customer locations generate the highest revenue?*/
SELECT
    c.Location,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY
    c.Location
ORDER BY
    TotalRevenue DESC;

/*BA-S16 — Revenue by gender*/
SELECT
    c.Gender,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY
    c.Gender
ORDER BY
    TotalRevenue DESC;

/*BA-S17 — Revenue by age*/
SELECT
    c.Age,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID=c.CustomerID
GROUP BY
    c.Age
ORDER BY
    c.Age;

/*BA-S18 — Revenue by weekend vs weekday*/
SELECT
    CASE
        WHEN d.IsWeekend=1 THEN 'Weekend'
        ELSE 'Weekday'
    END AS DayType,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Dates d ON o.DateKey=d.DateKey
GROUP BY
    CASE
        WHEN d.IsWeekend=1 THEN 'Weekend'
        ELSE 'Weekday'
    END;

/*BA-S19 — Revenue by promotion status*/
SELECT
    pr.Status,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Promotions pr ON o.PromotionID=pr.PromotionID
GROUP BY
    pr.Status
ORDER BY
    TotalRevenue DESC;

/*BA-S20 — Revenue by promotion type*/
SELECT
    pr.PromoType,
    SUM(CAST(o.NetRevenue AS BIGINT)) AS TotalRevenue
FROM Orders o
JOIN Promotions pr ON o.PromotionID=pr.PromotionID
GROUP BY
    pr.PromoType
ORDER BY
    TotalRevenue DESC;