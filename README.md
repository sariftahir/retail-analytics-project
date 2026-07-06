# Retail Business Performance Analytics

### End-to-End Business Intelligence Solution using Python, SQL Server & Power BI

> An end-to-end Business Intelligence project that demonstrates the complete analytics lifecycle—from generating a realistic retail dataset in Python to building a centralized SQL analytical view and delivering interactive Power BI dashboards for executive decision-making.

---

# Business Questions Answered

This project was designed to answer key business questions that decision-makers commonly face in a retail environment:

- How is sales performance changing over time?
- Which products and categories generate the highest revenue and profit?
- Who are the most valuable customers?
- Which promotions drive the highest sales impact?
- How do return rates affect overall business performance?
- Which locations contribute the most to revenue and profitability?

---

# Dashboard Preview

### Executive Overview (Dark Mode)

<img width="1106" height="725" alt="Executive Overview Dashboard" src="https://github.com/user-attachments/assets/ed7d1c6e-120b-4845-9536-85ae6a399988" />

---

### Executive Overview (Light Mode)

<img width="1090" height="711" alt="Executive Overview Dashboard" src="https://github.com/user-attachments/assets/6ca8838e-1d8e-4dfc-b2d9-b22c90eb1c39" />

---

### Sales & Customer Behavior Analytics

<img width="1067" height="715" alt="Sales & Customer Behavior Analytics Dashboard" src="https://github.com/user-attachments/assets/b8de99aa-32f3-407c-98eb-f0881650b627" />

---

### Return Performance Analytics

<img width="1092" height="721" alt="Return Performance Analytics Dashboard" src="https://github.com/user-attachments/assets/1d165a0b-7d32-42d4-bf38-c4b2c7732a7a" />

---

# Project Summary

| Metric | Value |
|---------|------:|
| Orders | 250,000 |
| Customers | 250 |
| Products | 100 |
| Promotions | 15 |
| Dashboard Views | 4 (Executive Overview in Dark & Light Mode, Sales & Customer Behavior Analytics, Return Performance Analytics) |
| Analytics Areas | Sales, Customers, Products, Promotions, Returns, Locations |

---

# Technology Stack

| Category | Technology |
|-----------|------------|
| Programming | Python |
| Database | SQL Server |
| Data Generation | Python |
| Data Preparation | SQL Views |
| Data Model | Analytical SQL View + DAX Calendar Dimension |
| Business Intelligence | Power BI |
| Visualization | Power BI |
| Language | DAX |

---

# Project Overview

This project demonstrates a complete end-to-end Business Intelligence workflow, beginning with synthetic retail dataset generation in Python, followed by data preparation and business logic development in SQL Server, and culminating in interactive Power BI dashboards that support data-driven decision-making.

Instead of relying on publicly available datasets, this project creates a realistic retail business environment with simulated customer transactions, promotional campaigns, product returns, and geographic sales activity. The processed data is consolidated into a centralized SQL analytical view before being visualized in Power BI.

The dashboards provide comprehensive insights into business performance, customer behavior, promotional effectiveness, return analysis, and regional sales trends, demonstrating the complete analytics lifecycle from raw data generation to actionable business insights.

---

# Business Problem

Retail businesses generate thousands of transactions every day. Without an integrated analytics solution, decision-makers often struggle to monitor sales performance, customer purchasing behavior, product trends, promotion effectiveness, return rates, and regional performance.

Disconnected reporting makes it difficult to identify growth opportunities, evaluate marketing initiatives, understand customer behavior, and respond quickly to changing business conditions.

This project addresses these challenges by building a complete Business Intelligence solution that transforms raw operational data into interactive dashboards and actionable insights for better business decisions.

---

## Project Objectives

This project demonstrates an end-to-end retail analytics solution by transforming raw transactional data into interactive Power BI dashboards using SQL and DAX.

The primary objectives are to:

- Build a centralized analytical dataset using SQL.
- Monitor overall business performance through executive-level KPIs.
- Analyze sales performance, customer behavior, and promotional effectiveness.
- Evaluate product return patterns and their financial impact.
- Deliver interactive dashboards that support data-driven business decisions.

---

## Dataset Overview

This project uses a custom-built retail dataset designed to simulate realistic business operations and customer purchasing behavior.

The dataset consists of six relational tables:

| Table | Description |
|--------|-------------|
| Orders | Sales transactions including revenue, quantity, profit, and discounts. |
| Customers | Customer demographics and purchasing information. |
| Products | Product hierarchy, categories, brands, and pricing details. |
| Promotions | Promotional campaign information applied to customer orders. |
| Returns | Product return transactions used for return analysis. |
| Dates | Calendar data supporting time-based reporting and trend analysis. |

The data was intentionally generated with realistic business patterns, including seasonal demand, promotional campaigns, customer purchasing variations, and product returns to simulate real-world retail scenarios.

---

## Project Workflow

```text
Business Requirements
        │
        ▼
Python Dataset Generation
        │
        ▼
Data Cleaning
        │
        ▼
SQL Database Design
        │
        ▼
Business Logic
        │
        ▼
Analytical SQL View
(vw_ExecutiveOverview)
        │
        ▼
Power BI
        │
        ▼
DAX Measures
        │
        ▼
Interactive Dashboards
        │
        ▼
Business Insights
```

---

## Data Model

The Power BI data model is intentionally designed to remain simple and efficient.

A centralized SQL analytical view (`vw_ExecutiveOverview`) serves as the primary data source, while a dedicated `Dim_Calendar` table is created using DAX to enable time intelligence calculations.

This lightweight model simplifies report development by keeping business logic in SQL while leveraging DAX for Year-over-Year (YoY) analysis, trend reporting, and other time-based calculations.

---

## Dashboard Pages Explained

| Dashboard | Description |
|-----------|-------------|
| Executive Overview | Provides an executive summary of business performance through KPIs, revenue trends, profit trends, product performance, customer profitability, and category profit margins. |
| Sales & Customer Behavior Analytics | Analyzes sales performance across brands, promotions, customer demographics, geographic distribution, average order value, profitability, and customer purchasing behavior. |
| Return Performance Analytics | Evaluates return rates, revenue returned, lost profit, return trends, customer return behavior, and product return performance to identify opportunities for reducing business losses. |

---

## Key Business Insights

The dashboards help answer important business questions, including:

- How is sales performance changing over time?
- Which products and categories generate the highest revenue and profit?
- Who are the most valuable customers?
- Which promotions drive the highest sales impact?
- How do return rates affect overall business performance?
- Which locations contribute the most to revenue and profitability?

---

## Repository Structure

```text
Retail-Business-Performance-Analytics/
│
├── 01_Dataset/
├── 02_SQL/
├── 03_Python/
├── 04_PowerBI/
├── 05_Dashboard/
├── 06_Documentation/
└── README.md
```

---

## Skills Demonstrated

- SQL
- Python
- Power BI
- DAX
- SQL View Development
- Data Modeling
- KPI Development
- Data Visualization
- Business Intelligence
- Sales Analytics
- Customer Analytics
- Return Analytics
- Business Storytelling

---

## Future Improvements

Potential enhancements for future versions include:

- Drill-through reports for detailed transaction analysis.
- Dynamic KPI benchmarking.
- Forecasting using Power BI time series models.
- Customer segmentation using RFM analysis.
- Row-Level Security (RLS) implementation.
- Mobile dashboard optimization.

---

## About This Project

This project was developed as part of my Data Analytics portfolio to demonstrate practical skills in Python, SQL Server, Power BI, DAX, and Business Intelligence.

Rather than focusing solely on dashboard development, the project showcases the complete analytics lifecycle—from realistic dataset generation and SQL-based data transformation to interactive reporting and business storytelling for data-driven decision-making.
