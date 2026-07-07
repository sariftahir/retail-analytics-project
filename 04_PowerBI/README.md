# Power BI Development

This folder contains the Power BI data model and DAX measures used to build the Retail Analytics dashboards.

The objective of this stage is to transform validated SQL data into a well-structured semantic model that supports interactive reporting and business analysis.

---

# Folder Contents

## DataModeling.png

Shows the Power BI data model and table relationships used throughout the project.

The model follows a star schema approach to ensure efficient filtering, aggregation, and report performance.

---

## DIM Calendar

Custom calendar table created using DAX.

The table includes:

- Calendar Year
- Quarter
- Month Number
- Month Name
- Month Short Name
- Year-Month
- Month-Year
- Day
- Weekday
- Weekday Number

This dimension enables accurate time intelligence calculations across all reports.

---

## KPI

Core business measures used throughout the dashboards, including:

- Total Revenue
- Gross Revenue
- Total Profit
- Total Cost
- Total Orders
- Total Customers
- Total Products
- Total Quantity
- Average Order Value
- Profit Margin %

---

## Executive KPI

Additional executive-level measures used for high-level business monitoring, including:

- Revenue per Customer
- Profit per Customer
- Revenue per Product
- Profit per Product
- Average Selling Price
- Average Cost
- Average Discount
- Average Quantity per Order
- Average Profit per Order
- Cost Ratio
- Discount to Revenue Ratio

---

## Return KPI

Measures created to analyze product returns, including:

- Returned Orders
- Returned Quantity
- Returned Revenue
- Lost Profit
- Return Order Rate
- Return Quantity Rate
- Return Revenue Rate

---

## YoY

Time intelligence measures used to compare current performance with the previous year.

Includes Year-over-Year calculations for:

- Revenue
- Profit
- Orders
- Quantity
- Average Order Value
- Profit Margin

Additional color measures are included to support conditional formatting in KPI cards.

---

## YoY Return

Year-over-Year comparison measures for return performance, including:

- Returned Orders
- Returned Quantity
- Returned Revenue
- Lost Profit

---

# Power BI Workflow

```
SQL Views
      │
      ▼
Import into Power BI
      │
      ▼
Create Data Model
      │
      ▼
Build Calendar Table
      │
      ▼
Create DAX Measures
      │
      ▼
Create KPI & Time Intelligence
      │
      ▼
Develop Interactive Dashboards
```

---

# DAX Concepts Applied

The Power BI model demonstrates the use of several DAX techniques, including:

- Aggregation Functions
- DIVIDE()
- CALCULATE()
- DISTINCTCOUNT()
- AVERAGE()
- SUM()
- Time Intelligence
- DATEADD()
- SAMEPERIODLASTYEAR()
- Conditional Formatting Measures
- SWITCH()
- SELECTEDVALUE()
- Custom Calendar Table

---

# Output

The Power BI model provides a centralized analytical layer that powers all dashboards in this project. By combining a structured data model with reusable DAX measures, the reports deliver consistent KPI calculations, year-over-year comparisons, and interactive business insights.
