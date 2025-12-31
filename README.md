# Revenue-metrics## 📊 Project Overview
This project demonstrates the analysis of revenue metrics for a digital product using SQL and Tableau.

The goal was to analyze revenue dynamics, user behavior, and key business KPIs such as MRR, churn, and customer lifetime value.

The dashboard is built in **Tableau Public**, while data preparation and metric calculations are performed using **PostgreSQL**.

---

## 🔗 Live Dashboard
https://public.tableau.com/app/profile/.76612946/viz/FinalproJect/Dashboard1

---

## 🧠 Key Metrics Implemented

- Monthly Recurring Revenue (MRR)
- Paid Users
- Average Revenue Per Paid User (ARPPU)
- New Paid Users
- New MRR
- Churned Users
- Churn Rate
- Churned Revenue
- Revenue Churn Rate
- Expansion MRR
- Contraction MRR
- Customer Lifetime (LT)
- Customer Lifetime Value (LTV)

---

## 🧩 Data Source

Data is extracted from a PostgreSQL database (`project` schema).

Main tables used:
- `project.games_payments`
- `project.games_paid_users`

---

## ⚙️ Data Processing

- SQL is used to prepare monthly-level metrics.
- Advanced calculations (e.g. churn rate, LTV) are completed in Tableau to allow flexible filtering.
- Data is aggregated by:
  - month  
  - user  
  - language  
  - age  

---

## 📊 Dashboard Features

- 5+ interactive visualizations
- Filters by:
  - date
  - user language
  - user age
- Separate visual blocks showing:
  - revenue growth drivers
  - paid user dynamics

---

## 🛠 Tools Used

- **PostgreSQL** — data processing
- **Tableau Public** — visualization
- **SQL (CTEs, window functions)**

---

## 📌 Notes

This project was completed as part of an analytics training program and reflects real-world analytical workflows used in product analytics and BI.

---
