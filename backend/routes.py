from flask import Blueprint, jsonify, request
from databaseService import fetch_all_accounts, fetch_all_transactions, insert_transaction

api = Blueprint('api', __name__)

@api.route('/health', methods=['GET'])
def health_check():
    return jsonify({"message": "Server is running"})

@api.route('/accounts', methods=['GET'])
def get_accounts():
    accounts, error = fetch_all_accounts()
    if error:
        return jsonify({"error": error}), 500
    else:
        return jsonify({"data": accounts})

@api.route('/transactions', methods=['GET'])
def get_transactions():
    transactions, error = fetch_all_transactions()
    if error:
        return jsonify({"error": error}), 500
    else:
        return jsonify({"data": transactions})

@api.route('/transactions', methods=['POST'])
def add_transaction():
    transaction_data = request.json
    message, error = insert_transaction(transaction_data)
    if error:
        return jsonify({"error": error}), 500
    else:
        return jsonify({"message": message}), 201
