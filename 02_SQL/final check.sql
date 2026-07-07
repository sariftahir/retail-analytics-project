SELECT TOP 3 * FROM vw_CustomerAnalysis
SELECT TOP 3 * FROM vw_ExecutiveOverview
SELECT TOP 3 * FROM vw_FactReturns
SELECT TOP 3 * FROM vw_FactSales
SELECT TOP 3 * FROM vw_PromotionPerformance 
SELECT TOP 3 * FROM vw_ReturnAnalysis
SELECT TOP 3 * FROM vw_SalesPerformance



--VALIDASI JUMLAH BARIS
SELECT 
	COUNT(*) AS Orders 
FROM Orders;

SELECT 
	COUNT(*) AS FactSales 
FROM vw_FactSales;

SELECT 
	COUNT(*) AS SalesPerformance 
FROM vw_SalesPerformance;

SELECT 
	COUNT(*) AS CustomerAnalysis 
FROM vw_CustomerAnalysis;

SELECT 
	COUNT(*) AS PromotionPerformance 
FROM vw_PromotionPerformance;

SELECT 
	COUNT(*) AS ExecutiveOverview 
FROM vw_ExecutiveOverview;


--VALIDASI RETURN 

SELECT 
	COUNT(*) AS Retur
FROM Returns;

SELECT 
	COUNT(*) AS FactReturns 
FROM vw_FactReturns;

SELECT 
	COUNT(*) AS ReturnAnalysis 
FROM vw_ReturnAnalysis;	

--CEK NULL PROFIT
SELECT *
FROM vw_FactSales
WHERE Profit IS NULL;

--CEK NULL NETREVENUE
SELECT *
FROM vw_FactSales
WHERE NetRevenue IS NULL;

--CEK ORDER DUPLICATE	
SELECT
OrderID,
COUNT(*) AS Total
FROM vw_FactSales
GROUP BY OrderID
HAVING COUNT(*) > 1;
