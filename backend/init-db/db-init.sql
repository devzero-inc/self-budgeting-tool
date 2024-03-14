CREATE TABLE accounts (
    id char(36) NOT NULL DEFAULT (UUID()),
    account_number varchar(20) NOT NULL,
    account_holder varchar(255) NOT NULL,
    account_type enum('savings','checking','loan','credit_card') NOT NULL,
    balance decimal(15,2) NOT NULL,
    bank_name varchar(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CREATE TABLE transactions (
    id char(36) NOT NULL DEFAULT (UUID()),
    date date NOT NULL,
    account_id char(36) NOT NULL,
    bank_name varchar(255) NOT NULL,
    payee varchar(255) DEFAULT NULL,
    category varchar(255) DEFAULT NULL,
    amount decimal(10,2) NOT NULL,
    type enum('debit','credit') NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (account_id) REFERENCES accounts(id)
);

INSERT INTO accounts (account_number, account_holder, account_type, balance, bank_name) VALUES
('1234567890', 'John Doe', 'savings', 1000, 'HSBC Bank'),
('2345678901', 'John Doe', 'checking', 2000, 'Chase Bank'),
('3456789012', 'John Doe', 'loan', 3000, 'Wells Fargo'),
('4567890123', 'John Doe', 'savings', 4000, 'Bank of America');

INSERT INTO transactions (date, account_id, bank_name, payee, category, amount, type) VALUES
('2024-03-01', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Netflix', 'Entertainment', -50.00, 'debit'),
('2024-03-02', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'Amazon', 'Shopping', -120.00, 'debit'),
('2024-03-03', (SELECT id FROM accounts WHERE bank_name = 'Wells Fargo'), 'Wells Fargo', 'Apple', 'Electronics', -200.00, 'debit'),
('2024-03-04', (SELECT id FROM accounts WHERE bank_name = 'Bank of America'), 'Bank of America', 'Spotify', 'Entertainment', -10.00, 'debit'),
('2024-03-05', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Adobe', 'Software', -50.00, 'debit'),
('2024-03-06', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'Local Cafe', 'Dining', -30.00, 'debit'),
('2024-03-07', (SELECT id FROM accounts WHERE bank_name = 'Wells Fargo'), 'Wells Fargo', 'Gym', 'Health', -60.00, 'debit'),
('2024-03-08', (SELECT id FROM accounts WHERE bank_name = 'Bank of America'), 'Bank of America', 'Electric Company', 'Utilities', -150.00, 'debit'),
('2024-03-09', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Water Supply', 'Utilities', -80.00, 'debit'),
('2024-03-10', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'Internet Provider', 'Utilities', -60.00, 'debit'),
('2024-03-11', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Mortgage', 'Deposit', 2000.00, 'credit'),
('2024-03-12', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'House Asset', 'Deposit', 1500.00, 'credit'),
('2024-03-13', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Salary', 'Deposit', 3000.00, 'credit'),
('2024-03-14', (SELECT id FROM accounts WHERE bank_name = 'Bank of America'), 'Bank of America', 'Investment Return', 'Deposit', 1200.00, 'credit'),
('2024-03-15', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Mortgage', 'Deposit', 2200.00, 'credit'),
('2024-03-16', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'House Asset', 'Deposit', 1800.00, 'credit'),
('2024-03-17', (SELECT id FROM accounts WHERE bank_name = 'Wells Fargo'), 'Wells Fargo', 'Salary', 'Deposit', 2500.00, 'credit'),
('2024-03-18', (SELECT id FROM accounts WHERE bank_name = 'Bank of America'), 'Bank of America', 'Investment Return', 'Deposit', 1300.00, 'credit'),
('2024-03-19', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Mortgage', 'Deposit', 2100.00, 'credit'),
('2024-03-20', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'House Asset', 'Deposit', 1600.00, 'credit'),
('2024-03-21', (SELECT id FROM accounts WHERE bank_name = 'Wells Fargo'), 'Wells Fargo', 'Salary', 'Deposit', 2800.00, 'credit'),
('2024-03-22', (SELECT id FROM accounts WHERE bank_name = 'Bank of America'), 'Bank of America', 'Investment Return', 'Deposit', 1500.00, 'credit'),
('2024-03-23', (SELECT id FROM accounts WHERE bank_name = 'HSBC Bank'), 'HSBC Bank', 'Mortgage', 'Deposit', 2300.00, 'credit'),
('2024-03-24', (SELECT id FROM accounts WHERE bank_name = 'Chase Bank'), 'Chase Bank', 'House Asset', 'Deposit', 1700.00, 'credit');