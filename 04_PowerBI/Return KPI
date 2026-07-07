Lost Profit = 
SUM(vw_ExecutiveOverview[LostProfit])

Return Order % = 
DIVIDE(
    [Returned Orders],
    [Total Orders],
    0
)

Return Rate % = 
DIVIDE(
    [Returned Quantity],
    [Total Quantity],
    0
)

Return Revenue % = 
DIVIDE(
    [Returned Revenue],
    [Total Revenue],
    0
)

Returned Orders = 
CALCULATE(
    DISTINCTCOUNT(vw_ExecutiveOverview[OrderID]),
    vw_ExecutiveOverview[IsReturned] = "Yes"
)

Returned Quantity = 
SUM(vw_ExecutiveOverview[QuantityReturned])

Returned Revenue = 
SUM(vw_ExecutiveOverview[ReturnedRevenue])
