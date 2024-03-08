export interface Transaction {
  id: string; 
  date: Date;  
  account_id: string; 
  bank_name: string;
  payee: string; 
  category: string;
  amount: number;
  type: string;
}
