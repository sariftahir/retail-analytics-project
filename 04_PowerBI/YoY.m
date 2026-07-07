AOV YoY % = 
VAR PrevAOV =
    CALCULATE(
        [Average Order Value],
        DATEADD('Dim_Calendar'[FullDate], -1, YEAR)
    )

RETURN
DIVIDE(
    [Average Order Value] - PrevAOV,
    PrevAOV
)

---

AOV YoY Color1 = 
SWITCH(
    TRUE(),
    [AOV YoY %] < 0, "#792B14",      -- Merah
    [AOV YoY %] < 0.01, "#717070",   -- Abu-abu gelap (0% - 0.99%)
    "#01892C"                            -- Hijau (≥ 1%)
)

---

AOV YoY Color2 = 
SWITCH(
    TRUE(),
    [AOV YoY %] < 0, "#F33F3F",      -- Merah
    [AOV YoY %] < 0.01, "#E3E1E1",   -- Abu-abu gelap (0% - 0.99%)
    "#4ECB77"                            -- Hijau (≥ 1%)
)

---

Orders YoY % = 
VAR PreviousOrders =
    CALCULATE(
        [Total Orders],
        SAMEPERIODLASTYEAR(Dim_Calendar[FullDate])
    )

RETURN
DIVIDE(
    [Total Orders] - PreviousOrders,
    PreviousOrders
)

---

PM YoY Color1 = 
SWITCH(
    TRUE(),
    [Profit Margin YoY (pp)] < 0, "#792B14",      -- Merah
    [Profit Margin YoY (pp)] < 0.01, "#717070",   -- Abu-abu gelap (0% - 0.99%)
    "#01892C"                            -- Hijau (≥ 1%)
)

PM YoY Color2 = 
SWITCH(
    TRUE(),
    [Profit Margin YoY (pp)] < 0, "#F33F3F",      -- Merah
    [Profit Margin YoY (pp)] < 0.01, "#E3E1E1",   -- Abu-abu gelap (0% - 0.99%)
    "#4ECB77"                            -- Hijau (≥ 1%)
)

---

Profit Margin YoY (pp) = 
    VAR PreviousMargin =
        CALCULATE(
            [Profit Margin %],
            SAMEPERIODLASTYEAR(Dim_Calendar[FullDate])
        )

    RETURN
    [Profit Margin %] - PreviousMargin

---

Profit YoY % = 
VAR PreviousProfit =
    CALCULATE(
        [Total Profit],
        SAMEPERIODLASTYEAR(Dim_Calendar[FullDate])
    )

RETURN
DIVIDE(
    [Total Profit] - PreviousProfit,
    PreviousProfit
)

---

QTY YoY Color1 = 
SWITCH(
    TRUE(),
    [Total Quantity] < 0, "#792B14",      -- Merah
    [Total Quantity] < 0.01, "#717070",   -- Abu-abu gelap (0% - 0.99%)
    "#01892C"                            -- Hijau (≥ 1%)
)

---

QTY YoY Color2 = 
SWITCH(
    TRUE(),
    [Total Quantity] < 0, "#F33F3F",      -- Merah
    [Total Quantity] < 0.01, "#E3E1E1",   -- Abu-abu gelap (0% - 0.99%)
    "#4ECB77"                            -- Hijau (≥ 1%)
)

---

Quantity YoY % = 
VAR PreviousQty =
    CALCULATE(
        [Total Quantity],
        SAMEPERIODLASTYEAR(Dim_Calendar[FullDate])
    )

RETURN
DIVIDE(
    [Total Quantity] - PreviousQty,
    PreviousQty
)

---

Revenue YoY % = 
VAR PreviousRevenue =
    CALCULATE(
        [Total Revenue],
        SAMEPERIODLASTYEAR(Dim_Calendar[FullDate])
    )

RETURN
DIVIDE(
    [Total Revenue] - PreviousRevenue,
    PreviousRevenue
)

---

Revenue YoY Color1 = 
SWITCH(
    TRUE(),
    [Revenue YoY %] < 0, "##792B14",      -- Merah
    [Revenue YoY %] < 0.01, "#717070",   -- Abu-abu gelap (0% - 0.99%)
    "#01892C"                            -- Hijau (≥ 1%)
)

---

Revenue YoY Color2 = 
SWITCH(
    TRUE(),
    [Revenue YoY %] < 0, "#F33F3F",      -- Merah
    [Revenue YoY %] < 0.01, "#E3E1E1",   -- Abu-abu gelap (0% - 0.99%)
    "#4ECB77"                            -- Hijau (≥ 1%)
)

---

Selected Period = 
VAR SelectedYear =
    SELECTEDVALUE(Dim_Calendar[CalendarYear])

VAR SelectedQuarter =
    SELECTEDVALUE(Dim_Calendar[Quarter])

RETURN
IF(
    NOT ISBLANK(SelectedQuarter),
    "Period: " & SelectedQuarter & " | " & SelectedYear,
    "Period: " & SelectedYear
)

---

TP YoY Color1 = 
SWITCH(
    TRUE(),
    [Total Profit] < 0, "#792B14",      -- Merah
    [Total Profit] < 0.01, "#717070",   -- Abu-abu gelap (0% - 0.99%)
    "#01892C"                            -- Hijau (≥ 1%)
)

---

TP YoY Color2 = 
SWITCH(
    TRUE(),
    [Total Profit] < 0, "#F33F3F",      -- Merah
    [Total Profit] < 0.01, "#E3E1E1",   -- Abu-abu gelap (0% - 0.99%)
    "#4ECB77"                            -- Hijau (≥ 1%)
)



