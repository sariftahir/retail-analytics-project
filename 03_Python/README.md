# Python Data Generation

This folder contains the Python scripts used to generate the synthetic retail dataset for this project.

The dataset was created programmatically to simulate real-world retail transactions and serves as the foundation for the SQL analysis and Power BI dashboards.

---

# Folder Structure

## Python Scripts

These scripts generate each dataset individually:

- `generate_customer.py`
- `generate_products.py`
- `generate_promotion.py`
- `generate_date.py`
- `generate_order.py`
- `generate_return.py`

---

## Generated CSV Files

The Python scripts produce the following datasets:

- `Customers.csv`
- `Products.csv`
- `Promotions.csv`
- `Dates.csv`
- `Orders.csv`
- `Returns.csv`

---

# Workflow

```
Python Scripts
      │
      ▼
Generate Synthetic Data
      │
      ▼
Export CSV Files
      │
      ▼
Import into SQL Server
      │
      ▼
SQL Analysis
      │
      ▼
Power BI Dashboard
```

---

# Purpose

The Python scripts automate dataset generation to create a consistent retail database for analytics practice. The generated CSV files are then imported into SQL Server for data validation, business analysis, and dashboard development.
