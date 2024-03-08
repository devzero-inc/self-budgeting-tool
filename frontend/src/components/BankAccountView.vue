<script lang="ts">
import { defineComponent, inject, ref, computed } from "vue";
import type { Ref } from "vue";
import type { Transaction } from "../domain/transaction";
import TransactionsTable from "../components/TransactionsTable.vue";

export default defineComponent({
  components: {
    TransactionsTable,
  },
  props: {
    bankName: String,
  },
  setup(props) {
    const transactions = inject<Ref<Array<Transaction>>>("transactions");

    const filteredTransactions = computed(() => {
      return transactions?.value?.filter(
        (transaction) => transaction.bank_name === props.bankName
      );
    });

    const totalPayments = computed(() => {
      return filteredTransactions?.value?.filter(t => parseFloat(t.amount.toString()) < 0).reduce((acc, curr) => acc + parseFloat(curr.amount.toString()), 0) ?? 0;
    });

    const totalDeposits = computed(() => {
      return filteredTransactions?.value?.filter(t => parseFloat(t.amount.toString()) > 0).reduce((acc, curr) => acc + parseFloat(curr.amount.toString()), 0) ?? 0;
    });

    return { transactions, totalPayments, totalDeposits};
  },
});
</script>

<template>
  <div class="flex flex-col flex-1 gap-4 p-4 h-full overflow-auto">
    <h2 class="text-3xl font-bold text-custom-blue">{{ bankName }}</h2>
    <div class="flex items-end justify-between">

      <div class="mt-4">
        <h3 class="text-xl font-semibold">Totals:</h3>
        <p>Total Payments: <span class="text-red-500">{{ totalPayments.toFixed(2) }}</span></p>
        <p>Total Deposits: <span class="text-green-500">{{ totalDeposits.toFixed(2) }}</span></p>
      </div>
      <!-- Add New Transaction Button -->
      <button
        class="w-fit h-fit flex items-center justify-center gap-2 bg-custom-blue text-white px-4 py-2 rounded-lg hover:bg-purple-700"
      >
        <span class=" text-2xl -mt-1">&#43; </span>
        <span>Add New Transaction</span>
      </button>
    </div>
    <div v-if="transactions && bankName">
      <TransactionsTable :bankName="bankName" :transactions="transactions" />
    </div>
  </div>
</template>
