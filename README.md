# E-Commerce Revenue Analysis (SQL + Tableau)

## Project Overview

This project analyzes transactional e-commerce data to understand revenue performance, product performance, customer behaviour, and geographic sales distribution.

The goal of this analysis is to demonstrate how SQL can transform raw transactional data into meaningful business insights.

The analysis includes:

- Data validation and cleaning
- Core KPI analysis
- Monthly revenue trend analysis
- Month-over-month revenue growth
- Product performance analysis
- Geographic revenue analysis
- Customer behaviour analysis

A Tableau dashboard was also created to visualize key findings.

---

## Dataset

**UK Online Retail Dataset**

Time period: **December 2010 – December 2011**

Total rows: **541,909**

Each row represents a **product purchased within an invoice**.

Columns include:

- InvoiceNo
- StockCode
- Description
- Quantity
- InvoiceDate
- UnitPrice
- CustomerID
- Country

---

## Tools Used

- SQL Server (SSMS)
- SQL
- Tableau Public

---

## Data Cleaning

Before analysis, the dataset was validated and cleaned.

The following issues were identified:

| Issue | Count | Handling |
|------|------|------|
Cancelled invoices | 9,288 | Removed from revenue calculations |
Negative quantities | 10,624 | Treated as product returns |
Missing CustomerID | 135,080 | Excluded from customer-level analysis |
Duplicate rows | 10,147 | Removed using `SELECT DISTINCT` |

Revenue calculations used the following rules:
InvoiceNo NOT LIKE 'C%'
Quantity > 0
UnitPrice > 0

For **product performance analysis**, non-product entries were excluded:

- DOTCOM POSTAGE
- POSTAGE
- Manual

These represent shipping charges or manual adjustments rather than actual merchandise.

---

## Key Performance Indicators

Total Revenue: **£10.67M**

Total Orders: **19,960**

Total Customers: **4,338**

Average Order Value: **£534**

---

## Dashboard

The Tableau dashboard visualizes:

- Monthly revenue trends
- Top 10 revenue-generating products
- Top 10 revenue by country

Interactive Dashboard:  
*(https://public.tableau.com/app/profile/stephanie.korad/viz/ecommerce-revenue-analysis/BusinessKPI#1)*

---

## Key Insights

### Seasonal Revenue Patterns

Revenue shows strong seasonal growth toward the end of the year, peaking in **November (£1.51M)**.  
This indicates strong holiday-driven demand.

Businesses should prioritize inventory planning and marketing campaigns ahead of this peak period.

---

### Geographic Market Dependence

The **United Kingdom generates over 80% of total revenue**, indicating strong domestic demand but also highlighting potential opportunities for international expansion.

Top international markets include:

- Netherlands
- Ireland
- Germany
- France

---

### Product Performance

The **Regency Cake Stand 3 Tier** generated the highest merchandise revenue.

Meanwhile **Paper Craft Little Birdie** achieved the highest sales volume.

This highlights a combination of high-margin and high-volume products contributing to overall revenue.

---

### Customer Purchasing Behaviour

Customer analysis shows a strong presence of repeat buyers, suggesting a loyal customer base and consistent purchasing behaviour.

---

## Repository Structure


ecommerce-revenue-analysis
│
├── README.md
├── dataset_description.md
├── queries.sql
├── insights.md
└── visuals
└── dashboard_preview.png


---

## Author

Stephanie Korad
