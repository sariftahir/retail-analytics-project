
/*----------------------------------------------------------
					BUSINESS RULE VALIDATION
----------------------------------------------------------*/


--GrossRevenue
SELECT *
FROM Orders
WHERE GrossRevenue <> Quantity * SellingPrice


--TotalCost
SELECT *
FROM Orders
WHERE TotalCost <> Quantity * UnitCost;


--NetRevenue ≤ GrossRevenue	
SELECT *
FROM Orders
WHERE NetRevenue > GrossRevenue;


--SellingPrice ≥ UnitCost
SELECT *
FROM Orders
WHERE SellingPrice < UnitCost;


--Quantity > 0
SELECT *
FROM Orders
WHERE Quantity <= 0;


--Discount non negative
SELECT *
FROM Orders
WHERE DiscountApplied < 0;


--NetRevenue non negative
SELECT *
FROM Orders
WHERE NetRevenue < 0;

--Total Cost non negative
SELECT *
FROM Orders
WHERE TotalCost < 0;

--Return Quantity must be valid
SELECT
    r.ReturnID,
    r.OrderID,
    o.Quantity AS OrderedQty,
    r.QuantityReturned
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID
WHERE r.QuantityReturned > o.Quantity;


--Return Date cannot be before Order Date
SELECT
    r.ReturnID,
    o.OrderID,
    d1.FullDate AS OrderDate,
    d2.FullDate AS ReturnDate
FROM Returns r
JOIN Orders o
    ON r.OrderID = o.OrderID
JOIN Dates d1
    ON o.DateKey = d1.DateKey
JOIN Dates d2
    ON r.DateKey = d2.DateKey
WHERE d2.FullDate < d1.FullDate;    

