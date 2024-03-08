import axios from "axios";

const getAllTransactions = async () => {
  const response = await axios.get('http://localhost:5000/transactions');
  return response.data;
};

const getAllAccounts = async () => {
  const response = await axios.get('http://localhost:5000/accounts');
  return response.data;
};

export { getAllTransactions, getAllAccounts };
