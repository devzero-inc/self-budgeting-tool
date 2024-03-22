import mysql.connector
from mysql.connector import Error
from config import DATABASE_CONFIG

def get_db_connection():
    try:
        conn = mysql.connector.connect(**DATABASE_CONFIG)
        if conn.is_connected():
            print("Connected to MySQL database")
            return conn
    except Error as e:
        print(f"Error connecting to MySQL Database: {e}")
    return None