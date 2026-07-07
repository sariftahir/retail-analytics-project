/*
Business Analysis : BA-E01
Phase             : Exploratory SQL

Business Question:
How many orders are recorded in the dataset?
*/


SELECT
    COUNT(OrderID) AS TotalOrders
FROM Orders;


/*
Business Analysis : BA-E02

Business Question

How many unique customers are recorded in the dataset?
*/

SELECT
    COUNT(CustomerID) AS TotalCustomersx
FROM Customers;





/*
Business Analysis BA-E03

Business Question

How many products are available in the dataset?
*/


SELECT
    COUNT(ProductID) AS TotalProducts
FROM Products;


/*BA-E04
Business Question

How many returned orders are recorded?*/

SELECT
    COUNT(ReturnID) AS TotalReturns
FROM Returns;


/*BA-E05
Business Question

How many promotions are available?*/

SELECT
    COUNT(PromotionID) AS TotalPromotions
FROM Promotions;


/*BA-E06 — Orders by Month

Business Question

How are orders distributed by month?*/
SELECT
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.MonthName,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Dates d
    ON o.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.MonthName
ORDER BY
    d.CalendarYear,
    d.MonthNumberOfYear;

/*
BA-E07 — Orders by Quarter

Business Question

How are orders distributed by quarter?
*/

SELECT
    d.CalendarYear,
    d.CalendarQuarter,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Dates d
    ON o.DateKey = d.DateKey
GROUP BY
    d.CalendarYear,
    d.CalendarQuarter
ORDER BY
    d.CalendarYear,
    d.CalendarQuarter;
    

/*BA-E08 — Orders by Day of Week

Business Question

Which day of the week receives the highest number of orders?*/


SELECT
    d.DayOfWeek,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Dates d
    ON o.DateKey = d.DateKey
GROUP BY
    d.DayOfWeek
ORDER BY
    TotalOrders DESC;


/*BA-E09 — Orders by Category

Business Question

Which product categories receive the most orders?*/

SELECT
    p.Category,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Products p
    ON o.ProductID = p.ProductID
GROUP BY
    p.Category
ORDER BY
    TotalOrders DESC;

/*BA-E10 — Orders by Brand

Business Question

Which brands receive the most orders?*/

SELECT
    p.Brand,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Products p
    ON o.ProductID = p.ProductID
GROUP BY
    p.Brand
ORDER BY
    TotalOrders DESC;


/*BA-E11 — Orders by Promotion Channel

Business Question

Which promotion channel is associated with the highest number of orders?*/

SELECT
    pr.Channel,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Promotions pr
    ON o.PromotionID = pr.PromotionID
GROUP BY
    pr.Channel
ORDER BY
    TotalOrders DESC;


/*BA-E12 — Orders by Customer City

Business Question

Which customer cities generate the highest number of orders?*/

SELECT
    c.Location AS City,
    COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Customers c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.Location
ORDER BY
    TotalOrders DESC;

/*BA-E13 — Highest Selling Price

Business Question

Which products have the highest selling price?*/

SELECT
    ProductID,
    ProductName,
    Category,
    Brand,
    SellingPrice
FROM Products
ORDER BY
    SellingPrice DESC;


/*BA-E14 — Highest Discount Applied

Business Question

Which orders received the highest discount?*/

SELECT TOP 10
    OrderID,
    CustomerID,
    ProductID,
    GrossRevenue,
    DiscountApplied,
    NetRevenue
FROM Orders
ORDER BY
    DiscountApplied DESC;


/*BA-E15 — Highest Revenue Order

Business Question

Which orders generated the highest net revenue?*/

SELECT TOP 10
    OrderID,
    CustomerID,
    ProductID,
    NetRevenue
FROM Orders
ORDER BY
    NetRevenue DESC;