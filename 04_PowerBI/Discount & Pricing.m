Average Cost = 
DIVIDE(
    [Total Cost],
    [Total Quantity]
)

---

Average Discount % = 
AVERAGE(vw_ExecutiveOverview[DiscountPercent])

---

Average Selling Price = 
DIVIDE(
    [Total Revenue],
    [Total Quantity]
)

---

Profit per Customer = 
DIVIDE(
    [Total Profit],
    [Total Customers]
)

---

Revenue per Customer = 
DIVIDE(
    [Total Revenue],
    [Total Customers]
)

---

Total Discount = 
SUM(vw_ExecutiveOverview[DiscountApplied])
