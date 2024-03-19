import axios from "axios";
import type { Transaction } from "../domain/transaction";

const getAllTransactions = async () => {
  const response = await axios.get('http://localhost:5000/transactions');
  return response.data;
};

const getAllAccounts = async () => {
  const response = await axios.get('http://localhost:5000/accounts');
  return response.data;
};
const addTransaction = async (transaction: Transaction) => {
  const response = await axios.post('http://localhost:5000/transactions', transaction);
  return response.data;
}

export { getAllTransactions, getAllAccounts, addTransaction };
