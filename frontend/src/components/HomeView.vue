<script lang="ts">
import { defineComponent, inject, ref, computed } from "vue";
import type { Ref } from "vue";
import type { Transaction } from "../domain/transaction";

interface BudgetedAmounts {
  [category: string]: number;
}

export default defineComponent({
  setup() {
    const injectedTransactions = inject<Ref<Transaction[]>>("transactions");
    const budgetedAmounts = ref<BudgetedAmounts>({});

    const getRandomBudgetedAmount = (): number => {
      return Math.floor(Math.random() * (1000 - 100 + 1)) + 100;
    };

    const initBudgetedAmounts = () => {
      injectedTransactions?.value?.forEach((transaction) => {
        if (!budgetedAmounts.value[transaction.category]) {
          budgetedAmounts.value[transaction.category] =
            getRandomBudgetedAmount();
        }
      });
    };

    if (injectedTransactions?.value) {
      initBudgetedAmounts();
    }

    const totalsByCategory = computed(() => {
      const totals: { [category: string]: { spent: number } } = {};
      injectedTransactions?.value?.forEach((transaction) => {
        if (!totals[transaction.category]) {
          totals[transaction.category] = { spent: 0 };
        }
        totals[transaction.category].spent += parseFloat(
          transaction.amount.toString()
        );
      });
      return totals;
    });

    const totalBudgeted = computed(() => {
      const sum = Object.values(budgetedAmounts.value).reduce((acc, amount) => {
        const num = Number(amount);
        return acc + (isNaN(num) ? 0 : num);
      }, 0);
      return isNaN(sum) ? 0 : sum;
    });

    const totalSpent = computed(() => {
      return Object.values(totalsByCategory.value).reduce(
        (acc, { spent }) => acc + spent,
        0
      );
    });

    const totalBalance = computed(() => {
      return totalBudgeted.value - totalSpent.value;
    });

    return {
      budgetedAmounts,
      totalsByCategory,
      totalBudgeted,
      totalSpent,
      totalBalance,
    };
  },
});
</script>

<template>
  <div class="flex justify-center flex-1 h-full overflow-auto">
    <div class="w-full h-full flex items-center justify-center">
      <table
        class="w-[60%] text-left bg-custom-text shadow-2xl rounded-lg overflow-hidden"
      >
        <thead class="bg-custom-blue text-white">
          <tr>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              Category
            </th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              Budgeted
            </th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">Spent</th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              Balance
            </th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(total, category) in totalsByCategory"
            :key="category"
            class="border-t"
          >
            <td class="px-6 py-2">{{ category }}</td>
            <td class="px-6 py-2">
              <input
                type="number"
                v-model.number="budgetedAmounts[category]"
                class="form-input rounded-md shadow-sm w-full border border-custom-text px-2"
              />
            </td>
            <td class="px-6 py-2">{{ total.spent.toFixed(2) }}</td>
            <td
              :class="{
                'text-red-500': budgetedAmounts[category] - total.spent < 0,
                'text-green-500': budgetedAmounts[category] - total.spent >= 0,
              }"
              class="px-6 py-2"
            >
              {{ (budgetedAmounts[category] - total.spent).toFixed(2) }}
            </td>
          </tr>
        </tbody>
        <tfoot class="bg-custom-blue text-white">
          <tr>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">Total</th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              {{ totalBudgeted.toFixed(2) }}
            </th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              {{ totalSpent.toFixed(2) }}
            </th>
            <th class="px-6 py-2 font-bold uppercase tracking-wider">
              {{ totalBalance.toFixed(2) }}
            </th>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>
</template>