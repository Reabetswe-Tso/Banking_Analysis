# Banking Transaction Analysis
SQL-based analysis of banking transactions, customer behavior, and fraud detection for financial services

## Project Overview
A comprehensive SQL-based analysis of banking transactions, customer behavior, fraud detection, and loan portfolio management. This project analyzes 500+ customers, 5,000+ transactions, and 200+ loans using advanced SQL queries to extract actionable business insights relevant to financial services software.

---

## Business Objectives
- Analyze customer transaction patterns across multiple channels (ATM, Online, Mobile, Branch)
- Identify high-value customers for premium banking services
- Detect suspicious transactions for fraud prevention
- Evaluate loan portfolio performance and assess default risk
- Calculate customer lifetime value for targeted marketing campaigns
- Monitor digital banking adoption rates and channel preferences
- Support data-driven decision making for financial services operations

---

## Database Schema

### Tables & Relationships

**Customers Table**
- Stores customer demographic information, account types, and credit scores
- Primary Key: customer_id

**Accounts Table**
- Contains account details, balances, currency, and status
- Foreign Key: customer_id references Customers

**Transactions Table**
- Records all banking transactions with amounts, channels, merchants, and status
- Foreign Key: account_id references Accounts

**Loans Table**
- Manages loan portfolio with amounts, interest rates, terms, and repayment status
- Foreign Key: customer_id references Customers

---

## Key Findings & Business Insights

### 1. Transaction Channel Analysis
**Finding:** Digital channels (Mobile + Online) account for approximately 65-70% of total transaction volume, with Mobile banking showing the highest growth.

**Business Impact:** Strong digital adoption supports continued investment in mobile banking infrastructure and potential reduction in physical branch locations.

### 2. High-Value Customer Identification
**Finding:** Top 10% of customers generate approximately 60-65% of total transaction volume.

**Business Impact:** These customers are prime candidates for premium banking services, wealth management products, and personalized retention strategies.

### 3. Fraud Detection & Risk Management
**Finding:** Identified 50+ suspicious transactions based on high values (>R10,000) and unusual timing (midnight to 5 AM transactions).

**Business Impact:** Enhanced monitoring and automated fraud detection systems can prevent potential losses and improve customer security.

### 4. Customer Balance Segmentation
**Finding:** 40% of customers maintain balances below R5,000, while only 6% maintain balances above R50,000.

**Business Impact:** Opportunity for targeted savings promotions for lower-balance customers and wealth management services for high-balance segments.

### 5. Loan Portfolio Performance
**Finding:** Auto loans show higher default rates (6-8%) compared to home loans (2-3%), with business loans falling in between.

**Business Impact:** Risk-based pricing adjustments and stricter approval criteria for higher-risk loan categories can improve portfolio health.

### 6. Digital Banking Adoption
**Finding:** Digital transaction percentage has grown to 65-70% of total transactions, with Mobile showing 35% share.

**Business Impact:** Validates digital transformation strategy and justifies infrastructure optimization and branch network rationalization.

---

## SQL Techniques Demonstrated

### Core SQL Skills
- **Multi-table Joins:** INNER JOIN, LEFT JOIN across 3-4 tables
- **Aggregate Functions:** SUM, COUNT, AVG, MIN, MAX with GROUP BY
- **Conditional Logic:** Complex CASE statements for segmentation
- **Date Functions:** DATE_FORMAT, CURDATE, DATE_SUB for time-based analysis
- **Subqueries:** Nested queries for percentage calculations
- **Filtering:** WHERE clauses with multiple conditions
- **Sorting & Limiting:** ORDER BY with LIMIT for top-N analysis

### Advanced Techniques
- **Window Functions:** Ranking and percentile calculations
- **Common Table Expressions (CTEs):** Multi-step analytical queries
- **Data Aggregation:** Grouping with HAVING clauses
- **Business Logic:** Complex CASE statements for risk flagging
- **Performance Optimization:** Indexed queries and efficient joins

---

## Key Business Queries

### 1. Transaction Volume by Channel
Analyzes transaction distribution across ATM, Online, Mobile, and Branch channels to understand customer preferences and optimize infrastructure investment.

### 2. High-Value Customer Identification
Identifies top customers by transaction volume to target for premium services and retention programs.

### 3. Fraud Detection Analysis
Flags suspicious transactions based on amount thresholds, unusual timing, and transaction patterns for enhanced security monitoring.

### 4. Monthly Transaction Trends
Tracks transaction volumes over time to identify growth patterns, seasonal trends, and business performance indicators.

### 5. Customer Balance Distribution
Segments customers by account balance ranges to enable targeted product offerings and personalized marketing.

### 6. Loan Portfolio Analysis
Evaluates loan performance by type, including default rates, average amounts, and interest rates for risk management.

### 7. Digital Adoption Metrics
Calculates digital banking usage rates to measure digital transformation success and guide strategic planning.

### 8. Customer Lifetime Value
Estimates total customer value based on balances, transaction history, and loan relationships for retention prioritization.

### 9. Cross-Selling Opportunities
Identifies customers with strong banking relationships but no loans, representing sales opportunities.

### 10. Transaction Failure Analysis
Analyzes failed transactions by channel and type to improve system reliability and customer experience.

---

## Technologies Used

**Database:** MySQL 8.0

**Data Generation:** Python 3.x (Pandas, NumPy, CSV)

**Data Analysis:** SQL (Advanced queries with joins, CTEs, window functions)

**Version Control:** Git, GitHub

**Documentation:** Markdown

---

## Project Structure
```
banking-transaction-analysis/
│
├── data/
│   ├── customers.csv           (500 customer records)
│   ├── accounts.csv            (500 account records)
│   ├── transactions.csv        (5,000 transaction records)
│   └── loans.csv               (200 loan records)
│
├── sql/
│   ├── schema.sql              (Database table definitions)
│   ├── queries.sql             (All analysis queries)
│   ├── insert_customers.sql    (Customer data insertion)
│   ├── insert_accounts.sql     (Account data insertion)
│   ├── insert_transactions.sql (Transaction data insertion)
│   └── insert_loans.sql        (Loan data insertion)
│
├── scripts/
│   └── data_generator.py       (Python data generation script)
│
├── screenshots/                (Query result visualizations)
│
└── README.md                   (This file)
```

---

## How to Run This Project

### Prerequisites
- MySQL 8.0 or higher installed
- Python 3.x (for data generation)
- MySQL Workbench (recommended) or command line access

### Step 1: Generate Sample Data
```bash
python scripts/data_generator.py
```
This creates 4 CSV files with realistic banking data.

### Step 2: Set Up Database
```sql
CREATE DATABASE banking_analysis;
USE banking_analysis;
```

### Step 3: Create Tables
Run the SQL schema file to create all tables with proper relationships and constraints.

### Step 4: Import Data
Use MySQL Workbench's Table Data Import Wizard or LOAD DATA INFILE commands to import the CSV files.

### Step 5: Run Analysis Queries
Execute the queries from the queries.sql file to generate insights and analysis results.

### Step 6: Review Results
Examine query outputs, take screenshots of key findings, and document business insights.

---

## Sample Results

### Transaction Channel Distribution
| Channel | Transactions | Total Volume | Percentage |
|---------|--------------|--------------|------------|
| Mobile  | 1,750        | R 2,625,000  | 35%        |
| Online  | 1,600        | R 2,400,000  | 32%        |
| ATM     | 1,200        | R 1,800,000  | 24%        |
| Branch  | 450          | R 675,000    | 9%         |

### Customer Balance Segments
| Balance Range      | Customers | Avg Balance | Total Deposits |
|--------------------|-----------|-------------|----------------|
| < R1,000           | 125       | R 650       | R 81,250       |
| R1,000 - R5,000    | 175       | R 3,200     | R 560,000      |
| R5,001 - R20,000   | 120       | R 12,500    | R 1,500,000    |
| R20,001 - R50,000  | 50        | R 32,000    | R 1,600,000    |
| > R50,000          | 30        | R 85,000    | R 2,550,000    |

### Loan Portfolio Summary
| Loan Type | Count | Total Value  | Avg Amount  | Default Rate |
|-----------|-------|--------------|-------------|--------------|
| Home      | 65    | R 78,000,000 | R 1,200,000 | 2.5%         |
| Auto      | 70    | R 14,000,000 | R 200,000   | 7.1%         |
| Personal  | 45    | R 1,125,000  | R 25,000    | 4.4%         |
| Business  | 20    | R 6,000,000  | R 300,000   | 5.0%         |

---

## Skills Demonstrated

✅ **Database Design:** Normalized schema with proper relationships and constraints

✅ **SQL Proficiency:** Complex multi-table joins, aggregations, and analytical queries

✅ **Business Analysis:** Translating data into actionable business insights

✅ **Financial Services Knowledge:** Understanding banking operations, risk management, and customer analytics

✅ **Data Quality:** Data validation, cleaning, and integrity maintenance

✅ **Problem Solving:** Addressing real-world business questions with data-driven solutions

✅ **Documentation:** Clear technical documentation and professional presentation

✅ **Tools & Technologies:** MySQL, Python, Git, data visualization concepts

---

## Future Enhancements

- [ ] Implement stored procedures for automated monthly reporting
- [ ] Add database triggers for real-time fraud alerts
- [ ] Create indexed views for frequently accessed queries
- [ ] Build Power BI dashboards for interactive visualization
- [ ] Develop predictive models for loan default risk
- [ ] Add customer churn prediction analysis
- [ ] Integrate transaction fee revenue calculations
- [ ] Implement customer segmentation using RFM analysis

---

## Business Value

This project demonstrates the ability to:

1. **Design and implement** relational databases for financial services
2. **Extract meaningful insights** from large transaction datasets
3. **Support strategic decisions** with data-driven analysis
4. **Identify risks and opportunities** through analytical queries
5. **Communicate findings** effectively to business stakeholders
6. **Apply SQL expertise** to real-world banking scenarios

The analyses performed mirror real consulting projects in financial services, including customer segmentation, fraud detection, portfolio risk assessment, and digital transformation metrics.

---

## Contact

**Reabetswe Tsotetsi**

Email: rtsotetsi21@gmail.com

LinkedIn: [linkedin.com/in/reabetswe-tsotetsi-112662349](https://www.linkedin.com/in/reabetswe-tsotetsi-112662349/)

GitHub: [github.com/Reabetswe-Tso](https://github.com/Reabetswe-Tso)

Location: Johannesburg, South Africa

---

## License

This project was created for educational and portfolio purposes. All data is synthetically generated and does not represent real customer information.

---

## Acknowledgments

This project was developed to demonstrate SQL analytical capabilities and business intelligence skills relevant to financial services consulting and enterprise software implementation roles.

**Note:** All customer data, transactions, and financial information in this project are entirely fictional and generated for demonstration purposes only.
