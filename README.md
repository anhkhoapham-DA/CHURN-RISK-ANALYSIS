# 🏦 Bank Customer Churn Risk Analysis

![SQL](https://img.shields.io/badge/Language-SQL-orange) ![Analysis](https://img.shields.io/badge/Type-Risk%20Analysis-blue) ![Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 Project Overview
The bank is facing an increasing customer churn rate (~20%). This project aims to identify the **root causes** of churn, build an **Automated Risk Scoring System** using SQL, and estimate the **Total Value at Risk (VaR)** to prioritize retention strategies.

**Key Achievement:** Identified a "Critical Risk" segment holding **$110 Million** in deposits, primarily driven by demographic factors in the German market.

---

## 📂 Repository Structure
* `Churn_Risk_Analysis.sql`: The core SQL script containing Data Exploration, Risk Scoring Model, and Final Reporting.
* `Churn_Modelling.csv`: The dataset used for analysis (10,000 records).

---

## 🔍 Key Business Insights

### 1. The "Germany-Senior" Crisis 🚩
While the overall churn rate is ~20%, the data revealed a critical anomaly in the German market.
* **German Seniors (>50 years old)** have an alarming churn rate of **59.9%**.
* This is the highest churn segment across all geographies and age groups.

| Geography | Age Group | Churn Rate | Status |
| :--- | :--- | :--- | :--- |
| **Germany** | **Senior (>50)** | **59.9%** | 🔴 **CRITICAL** |
| France | Senior (>50) | 40.8% | 🟠 High |
| Spain | Senior (>50) | 35.4% | 🟡 Moderate |

### 2. The "Multi-Product" Paradox
Customers owning **3 or 4 products** show a churn rate of nearly **100%**.
* *Hypothesis:* The 3rd/4th product in the bundle (likely a credit card or investment account) may have technical issues or poor user experience, causing customers to leave the bank entirely.

### 3. Financial Impact (Value at Risk)
Using the SQL Risk Scoring Model, we identified the financial exposure:
* **Critical Risk Group:** Holds **$110,792,236** (Total Value at Risk).
* *Impact:* Losing this segment would significantly affect the bank's liquidity.

---

## ⚙️ SQL Solution: Risk Scoring Model

I implemented a **Rule-Based Scoring System** using SQL (CTEs & Case When statements) to automatically classify customers based on their risk profile.

### The Scoring Logic:
| Risk Factor | Condition | Score Weight |
| :--- | :--- | :--- |
| **Demographics** | Customer is in **Germany** AND **>50 years old** | **+30** |
| **Product Depth** | Customer has **>= 3 products** | **+50** |
| **Engagement** | Customer is **Inactive** | **+20** |

### Risk Segmentation:
* **Critical Risk (Score ≥ 60):** Immediate action required (Call/Visit).
* **High Risk (Score 30-59):** Targeted marketing campaigns.
* **Low Risk (Score < 30):** Regular maintenance.

---

## 🚀 Strategic Recommendations

Based on the data analysis, the following actions are recommended:

1.  **Launch "Senior Retention Program" in Germany:**
    * **Action:** Offer a dedicated "Pension Booster" savings rate (+0.5%) for customers >50 in Germany.
    * **Goal:** Reduce churn rate from 60% to 35%.

2.  **Audit the Product Bundle:**
    * **Action:** Temporarily suspend the 4-product combo and investigate the user journey for customers adding the 3rd product.

3.  **Prioritize the $67M Value at Risk:**
    * **Action:** Feed the list of "Critical Risk" customers into the CRM for the VIP Relationship Manager team to contact personally.

---

## 🛠️ Tools & Skills Used
* **SQL:** CTEs, Window Functions (RANK), Aggregation, Conditional Logic (CASE WHEN).
* **Data Analysis:** Segmentation, Root Cause Analysis, Hypothesis Testing.
* **Business Intelligence:** Value at Risk Calculation, Actionable Insights.

---
*Author: Pham Anh Khoa*
*Dataset Source: Kaggle / Synthetic Banking Data*
