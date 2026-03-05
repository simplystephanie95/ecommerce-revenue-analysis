# Dataset Description

The dataset contains **541,909 transactional records** from a UK-based online retailer between December 2010 and December 2011.

Each row represents a **single product within a transaction (invoice)**.

---

## Key Columns

| Column | Description |
|------|------|
InvoiceNo | Unique order identifier |
StockCode | Product identifier |
Description | Product name |
Quantity | Number of items purchased |
InvoiceDate | Transaction timestamp |
UnitPrice | Price per item |
CustomerID | Customer identifier |
Country | Customer location |

---

## Data Quality Assessment

The dataset contains several issues common in transactional retail systems.

### Cancelled Orders

Invoices beginning with **"C"** represent cancelled transactions or refunds.

These rows were excluded from revenue analysis.

---

### Product Returns

Negative quantities indicate returned items.

These rows were removed to ensure revenue calculations reflect completed purchases.

---

### Missing Customer IDs

Some transactions lack customer identifiers, likely representing guest purchases.

These rows were included in revenue analysis but excluded from customer-level analysis.

---

### Duplicate Transactions

10147 duplicate rows were identified and removed using `SELECT DISTINCT`.

---

### Non-Product Entries

Certain rows represent shipping or manual adjustments rather than merchandise.

Examples include:

- DOTCOM POSTAGE
- POSTAGE
- Manual

These were excluded from **product performance analysis**.