# Retail Dataset

This folder contains the synthetic retail dataset used throughout the Retail Business Performance Analytics project.

The dataset was generated entirely in Python to simulate realistic retail business operations, providing a reliable foundation for SQL analysis and Power BI reporting.

---

# Dataset Overview

The dataset consists of six relational tables that represent the core entities of a retail business.

| Table | Description |
|--------|-------------|
| Orders | Sales transactions including products, customers, revenue, profit, quantity, discounts, promotions, and locations. |
| Customers | Customer demographic information and purchasing attributes. |
| Products | Product catalog containing categories, subcategories, brands, prices, and costs. |
| Promotions | Promotional campaign information applied to customer orders. |
| Returns | Product return records used for return performance analysis. |
| Dates | Calendar table supporting time-based reporting and trend analysis. |

---

# Dataset Relationships

The six tables were designed to work together as a relational retail dataset.

```text
Customers
      │
      ▼
Orders
▲    ▲     ▲
│    │     │
│    │     └── Promotions
│    │
│    └──────── Products
│
└──────────── Returns

Dates
│
└── Order Date
```

---

# Dataset Characteristics

- Synthetic data generated using Python.
- Designed to simulate realistic retail business operations.
- Includes seasonal sales patterns.
- Includes promotional campaigns.
- Includes customer purchasing variations.
- Includes product return transactions.
- Supports sales, customer, promotion, and return analytics.

---

# Purpose

The dataset was created to support the complete Business Intelligence workflow demonstrated in this project.

It serves as the primary data source for:

- SQL database design
- SQL business logic development
- Analytical SQL view creation
- Power BI data modeling
- DAX calculations
- Interactive dashboard development

---

# Folder Contents

```text
01_Dataset/
│
├── Customers.csv
├── Dates.csv
├── Orders.csv
├── Products.csv
├── Promotions.csv
├── Returns.csv
└── README.md
```
