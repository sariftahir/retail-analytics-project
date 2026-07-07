Lost Profit YoY % = 
VAR PrevLostProfit =
    CALCULATE(
        [Lost Profit],
        DATEADD('Dim_Calendar'[FullDate], -1, YEAR)
    )

RETURN
DIVIDE(
    [Lost Profit] - PrevLostProfit,
    PrevLostProfit
)

---

Return Order YoY % = 
VAR PrevOrders =
    CALCULATE(
        [Returned Orders],
        DATEADD('Dim_Calendar'[FullDate], -1, YEAR)
    )

RETURN
DIVIDE(
    [Returned Orders] - PrevOrders,
    PrevOrders
)

---

Return Revenue YoY % = 
VAR PrevReturnRevenue  =
    CALCULATE(
        [Returned Revenue],
        DATEADD('Dim_Calendar'[FullDate], -1, YEAR)
    )

RETURN
DIVIDE(
    [Returned Revenue] - PrevReturnRevenue,
    PrevReturnRevenue
)

---

Returned Quantity YoY % = 
VAR PrevQty =
    CALCULATE(
        [Returned Quantity],
        DATEADD('Dim_Calendar'[FullDate], -1, YEAR)
    )

RETURN
DIVIDE(
    [Returned Quantity] - PrevQty,
    PrevQty
)
