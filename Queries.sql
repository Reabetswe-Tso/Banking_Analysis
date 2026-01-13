CREATE DATABASE banking_analysis;
USE banking_analysis;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50),
    account_type VARCHAR(20),
    account_opened_date DATE,
    credit_score INT
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_number VARCHAR(20),
    account_type VARCHAR(20),
    balance DECIMAL(15,2),
    currency VARCHAR(3),
    status VARCHAR(20),
    opened_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATETIME,
    transaction_type VARCHAR(20),
    amount DECIMAL(15,2),
    currency VARCHAR(3),
    merchant_name VARCHAR(100),
    transaction_status VARCHAR(20),
    channel VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    loan_type VARCHAR(30),
    loan_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    loan_term_months INT,
    disbursement_date DATE,
    loan_status VARCHAR(20),
    monthly_payment DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

USE banking_analysis;

SELECT 
    channel,
    COUNT(*) as transaction_count,
    SUM(amount) as total_volume,
    ROUND(AVG(amount), 2) as avg_transaction_amount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM transactions), 2) as percentage_of_total
FROM transactions
WHERE transaction_status = 'Completed'
GROUP BY channel
ORDER BY total_volume DESC;

------------------------------------------------------------------------------------------------

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.account_type,
    COUNT(t.transaction_id) as transaction_count,
    ROUND(SUM(t.amount), 2) as total_transaction_value,
    ROUND(AVG(t.amount), 2) as avg_transaction_value,
    a.balance as current_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
LEFT JOIN transactions t ON a.account_id = t.account_id
WHERE t.transaction_status = 'Completed'
GROUP BY c.customer_id, c.first_name, c.last_name, c.account_type, a.balance
ORDER BY total_transaction_value DESC
LIMIT 10;

---------------------------------------------------------------------------------------------------

SELECT 
    t.transaction_id,
    t.account_id,
    c.first_name,
    c.last_name,
    t.transaction_date,
    t.amount,
    t.channel,
    t.merchant_name,
    CASE 
        WHEN t.amount > 10000 THEN 'High Value Transaction'
        WHEN HOUR(t.transaction_date) BETWEEN 0 AND 5 THEN 'Unusual Time Transaction'
        ELSE 'Standard'
    END as risk_flag
FROM transactions t
JOIN accounts a ON t.account_id = a.account_id
JOIN customers c ON a.customer_id = c.customer_id
WHERE 
    t.amount > 10000 
    OR HOUR(t.transaction_date) BETWEEN 0 AND 5
ORDER BY t.amount DESC
LIMIT 20;

-----------------------------------------------------------------------------------------------

SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') as month,
    COUNT(*) as total_transactions,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN 1 ELSE 0 END) as deposits,
    SUM(CASE WHEN transaction_type = 'Withdrawal' THEN 1 ELSE 0 END) as withdrawals,
    SUM(CASE WHEN transaction_type = 'Transfer' THEN 1 ELSE 0 END) as transfers,
    ROUND(SUM(amount), 2) as total_volume,
    ROUND(AVG(amount), 2) as avg_transaction_amount
FROM transactions
GROUP BY DATE_FORMAT(transaction_date, '%Y-%m')
ORDER BY month DESC;

-------------------------------------------------------------------------------------------------

SELECT 
    CASE 
        WHEN balance < 1000 THEN '< R1,000'
        WHEN balance BETWEEN 1000 AND 5000 THEN 'R1,000 - R5,000'
        WHEN balance BETWEEN 5001 AND 20000 THEN 'R5,001 - R20,000'
        WHEN balance BETWEEN 20001 AND 50000 THEN 'R20,001 - R50,000'
        WHEN balance > 50000 THEN '> R50,000'
    END as balance_segment,
    COUNT(*) as customer_count,
    ROUND(AVG(balance), 2) as avg_balance,
    ROUND(MIN(balance), 2) as min_balance,
    ROUND(MAX(balance), 2) as max_balance,
    ROUND(SUM(balance), 2) as total_deposits
FROM accounts
WHERE status = 'Active'
GROUP BY balance_segment
ORDER BY avg_balance;

----------------------------------------------------------------------------------------------------

SELECT 
    loan_type,
    COUNT(*) as total_loans,
    ROUND(SUM(loan_amount), 2) as total_loan_value,
    ROUND(AVG(loan_amount), 2) as avg_loan_amount,
    ROUND(AVG(interest_rate), 2) as avg_interest_rate,
    ROUND(AVG(loan_term_months), 0) as avg_term_months,
    COUNT(CASE WHEN loan_status = 'Active' THEN 1 END) as active_loans,
    COUNT(CASE WHEN loan_status = 'Defaulted' THEN 1 END) as defaulted_loans,
    ROUND(COUNT(CASE WHEN loan_status = 'Defaulted' THEN 1 END) * 100.0 / COUNT(*), 2) as default_rate_percent
FROM loans
GROUP BY loan_type
ORDER BY total_loan_value DESC;

------------------------------------------------------------------------------------------------------------

SELECT 
    DATE(transaction_date) as transaction_day,
    SUM(CASE WHEN channel = 'ATM' THEN 1 ELSE 0 END) as atm_count,
    SUM(CASE WHEN channel = 'Online' THEN 1 ELSE 0 END) as online_count,
    SUM(CASE WHEN channel = 'Mobile' THEN 1 ELSE 0 END) as mobile_count,
    ROUND(SUM(CASE WHEN channel IN ('Online', 'Mobile') THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as digital_adoption_rate
FROM transactions
WHERE transaction_status = 'Completed'
    AND transaction_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(transaction_date)
ORDER BY transaction_day DESC
LIMIT 30;

-----------------------------------------------------------------------------------------------------------------

