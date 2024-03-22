from db import get_db_connection

def fetch_all_accounts():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor(dictionary=True)
        cursor.execute('SELECT * FROM accounts')
        accounts = cursor.fetchall()
        cursor.close()
        conn.close()
        return accounts, None
    else:
        return None, "Database connection failed"

def fetch_all_transactions():
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor(dictionary=True)
        cursor.execute('SELECT * FROM transactions')
        transactions = cursor.fetchall()
        cursor.close()
        conn.close()
        return transactions, None
    else:
        return None, "Database connection failed"

def insert_transaction(transaction_data):
    conn = get_db_connection()
    if conn:
        cursor = conn.cursor()
        cursor.execute(
            'INSERT INTO transactions (account_id, bank_name, date, type, payee, amount, category) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s)',
            (
                transaction_data['account_id'],
                transaction_data['bank_name'],
                transaction_data['date'],
                transaction_data['type'],
                transaction_data['payee'],
                transaction_data['amount'],
                transaction_data['category']
            )
        )
        conn.commit()
        cursor.close()
        conn.close()
        return "Transaction added successfully", None
    else:
        return None, "Database connection failed"
