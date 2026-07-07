
/*----------------------------------------------------------
					DATA QUALITY CHECK
----------------------------------------------------------*/

SELECT COUNT(*) FROM Customers;
SELECT COUNT(*) FROM Products;
SELECT COUNT(*) FROM Orders;
SELECT COUNT(*) FROM Promotions;
SELECT COUNT(*) FROM Returns;
SELECT COUNT(*) FROM Dates;


SELECT TOP 5 * FROM Customers;
SELECT TOP 5 * FROM Products;
SELECT TOP 5 * FROM Orders;
SELECT TOP 5 * FROM Promotions;
SELECT TOP 5 * FROM Returns;
SELECT TOP 5 * FROM Dates;

/*--------------------------------------
				CEK NULL
---------------------------------------*/

SELECT * FROM Customers
WHERE CustomerID IS NULL;

SELECT * FROM Products
WHERE ProductID IS NULL;

SELECT * FROM Orders
WHERE OrderID IS NULL
	AND CustomerID IS NULL
	AND ProductID IS NULL
	AND PromotionID IS NULL 
	AND DateKey IS NULL;

SELECT * FROM Promotions
WHERE DiscountValue IS NULL;

SELECT * FROM Returns
WHERE ReturnID IS NULL;
	

/*--------------------------------------
		CEK DUPLICATE PRIMARY KEY
---------------------------------------*/

--CUSTOMERS
SELECT COUNT (*) AS TotalRows,		
	COUNT(DISTINCT CustomerID) AS UniqueCustomerID
FROM Customers	

--PRODUCTS
SELECT COUNT(*) AS TotalRows,
	COUNT(DISTINCT ProductID) AS UniqueProductID
FROM Products;

-- ORDERS
SELECT COUNT (*) AS TotalRows,
	COUNT(DISTINCT OrderID) AS UniqueOrderID
FROM Orders;

-- PrommotionID
SELECT COUNT (*) AS TotalRows,
	COUNT(DISTINCT PromotionID) AS UniquePromotionID
FROM Promotions;

-- RETURNS
SELECT COUNT (*) AS TotalRows,
	COUNT(DISTINCT ReturnID) AS UniqueReturnID
FROM Returns;


/*--------------------------------------
			CEK FOREIGN KEY
---------------------------------------*/

--CustomerID
SELECT DISTINCT CustomerID
FROM Orders

EXCEPT

SELECT CustomerID
FROM Customers;


--ProductID
SELECT DISTINCT ProductID
FROM Orders

EXCEPT

SELECT ProductID
FROM Products;


--PromotionID
SELECT DISTINCT PromotionID
FROM Orders

EXCEPT

SELECT PromotionID
FROM Promotions;


--DateKey
SELECT DISTINCT DateKey
FROM Orders

EXCEPT

SELECT DateKey
FROM Dates;


--OrderID --> Returns
SELECT DISTINCT OrderID
FROM Returns

EXCEPT

SELECT OrderID
FROM Orders;


--ProductID --> Returns
SELECT DISTINCT ProductID
FROM Returns

EXCEPT

SELECT ProductID
FROM Products;


--DateKey Returns
SELECT DISTINCT DateKey
FROM Returns

EXCEPT

SELECT DateKey
FROM Dates;