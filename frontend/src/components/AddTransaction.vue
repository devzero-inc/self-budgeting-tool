<script lang="ts">
import { defineComponent, inject, ref, computed, watch } from "vue";
import type { Ref } from "vue";
import type { Transaction } from "../domain/transaction";
import type { Account } from "../domain/account";
import { addTransaction } from "@/http/api";

export default defineComponent({
  props: {
    showModal: Boolean,
  },
  emits: ["update:showModal", "add-transaction"],
  setup(props, { emit }) {
    const banks = inject<Ref<Account[]>>("banks");

    const newTransaction = ref<Transaction>({
      id: "",
      account_id: "",
      date: new Date(),
      bank_name: "",
      payee: "",
      category: "",
      amount: 0,
      type: "",
    });

    const displayAmount = computed({
      get: () =>
        newTransaction.value.amount === 0
          ? ""
          : newTransaction.value.amount.toString(),
      set: (val) => {
        newTransaction.value.amount = val === "" ? 0 : parseFloat(val);
      },
    });

    watch(
      () => newTransaction.value.bank_name,
      (newBankName) => {
        const selectedBank = banks?.value?.find(
          (bank) => bank.bank_name === newBankName
        );
        if (selectedBank) {
          newTransaction.value.account_id = selectedBank.id;
        }
      }
    );

    const submitForm = async () => {
      if (newTransaction.value.type === "credit") {
        newTransaction.value.amount = Math.abs(newTransaction.value.amount);
      } else {
        newTransaction.value.amount = -Math.abs(newTransaction.value.amount);
      }

      try {
        const response = await addTransaction(newTransaction.value);
        emit("add-transaction", response);
        closeModal();
      } catch (error) {
        console.error("Error submitting transaction:", error);
      }
    };

    const closeModal = () => emit("update:showModal", false);

    return { newTransaction, submitForm, closeModal, displayAmount };
  },
});
</script>

<template>
  <div
    v-if="showModal"
    class="fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-10"
    @click.self="closeModal"
  >
    <div
      class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-white"
    >
    <div class="flex items-center justify-between">
      <h3 class="text-xl leading-6 font-bold text-gray-900 text-center mb-6">
        Add New Transaction
      </h3>
      <button @click="closeModal" class=" -mt-6">&#10006;</button>
    </div>
      <form @submit.prevent="submitForm" class="space-y-4">
        <div class="space-y-2">
          <label for="payee" class="block text-sm font-medium text-gray-700"
            >Payee</label
          >
          <select
            id="payee"
            v-model="newTransaction.payee"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none px-1 py-1"
            required
          >
            <option disabled value="">Select Payee</option>
            <option>Netflix</option>
            <option>Amazon</option>
            <option>Apple</option>
            <option>Spotify</option>
            <option>Adobe</option>
            <option>Local Cafe</option>
            <option>Gym</option>
            <option>Electric Company</option>
            <option>Water Supply</option>
            <option>Internet Provider</option>
            <option>Mortgage</option>
            <option>House Asset</option>
            <option>Salary</option>
            <option>Investment Return</option>
          </select>
        </div>

        <div class="space-y-2">
          <label for="category" class="block text-sm font-medium text-gray-700"
            >Category</label
          >
          <select
            id="category"
            v-model="newTransaction.category"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none px-1 py-1"
            required
          >
            <option disabled value="">Select Category</option>
            <option>Entertainment</option>
            <option>Shopping</option>
            <option>Electronics</option>
            <option>Dining</option>
            <option>Health</option>
            <option>Utilities</option>
            <option>Deposit</option>
          </select>
        </div>

        <div class="space-y-2">
          <label for="type" class="block text-sm font-medium text-gray-700"
            >Type</label
          >
          <select
            id="type"
            v-model="newTransaction.type"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none px-1 py-1"
            required
          >
            <option disabled value="">Select Type</option>
            <option value="debit">Debit</option>
            <option value="credit">Credit</option>
          </select>
        </div>

        <div class="space-y-2">
          <label for="amount" class="block text-sm font-medium text-gray-700"
            >Amount</label
          >
          <input
            id="amount"
            v-model="displayAmount"
            type="number"
            placeholder="Enter an amount"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none px-1 py-[2px]"
            required
          />
        </div>

        <div class="space-y-2">
          <label for="date" class="block text-sm font-medium text-gray-700"
            >Date</label
          >
          <input
            id="date"
            v-model="newTransaction.date"
            type="date"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none px-1 py-[2px]"
            required
          />
        </div>

        <div class="space-y-2">
          <label for="bank" class="block text-sm font-medium text-gray-700"
            >Bank</label
          >
          <select
            id="bank"
            v-model="newTransaction.bank_name"
            class="mt-1 block w-full border-2 border-gray-300 rounded focus:ring-purple-500 focus:border-purple-500 outline-none p-1"
            required
          >
            <option disabled value="">Select Bank</option>
            <option>HSBC Bank</option>
            <option>Chase Bank</option>
            <option>Wells Fargo</option>
            <option>Bank of America</option>
          </select>
        </div>

        <div class="flex">
          <button
            type="submit"
            class=" w-full  items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-purple-600 hover:bg-purple-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-purple-500"
          >
            <p>Add Transaction</p>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
