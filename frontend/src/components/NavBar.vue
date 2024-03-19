<script lang="ts">
import { defineComponent, inject, computed, ref } from "vue";
import type { Ref } from "vue";
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { RouterLink } from "vue-router";
import type { Account } from "../domain/account";
import type { Transaction } from "../domain/transaction";

export default defineComponent({
  setup() {
    const banks = inject<Ref<Account[]>>("banks");
    const transactions = inject<Ref<Transaction[]>>("transactions");

    const totalBalance = computed(() => {
      return (
        banks?.value?.reduce(
          (acc, bank) => acc + parseFloat(String(bank.balance)),
          0
        ) ?? 0
      );
    });

    const totalBudgeted = computed(() => {
      return (
        transactions?.value
          ?.filter((t) => ["debit", "credit"].includes(t.type))
          .reduce((acc, curr) => acc + parseFloat(String(curr.amount)), 0) ?? 0
      );
    });

    const totalOffBudget = computed(() => {
      const offBudgetCategories = [
        "Mortgage",
        "Investment Return",
        "Salary",
        "House Asset",
      ];
      return (
        transactions?.value
          ?.filter((t) => offBudgetCategories.includes(t.payee))
          .reduce((acc, curr) => acc + parseFloat(String(curr.amount)), 0) ?? 0
      );
    });

    type AssetTotals = {
      [key: string]: number;
    };

    const assetTotals = computed(() => {
      const totals: AssetTotals = {};
      offBudget.value.forEach(asset => {
        totals[asset] = transactions?.value?.filter(t => t.payee === asset).reduce((acc, curr) => acc + parseFloat(String(curr.amount)), 0) ?? 0;
      });
      return totals;
    });

    const offBudget = ref([
      "Mortgage",
      "Investment Return",
      "Salary",
      "House Asset",
    ]);

    return {
      banks: banks?.value,
      offBudget,
      totalBalance,
      totalBudgeted,
      totalOffBudget,
      assetTotals,
    };
  },
});
</script>

<style>
.link-active {
  border-left: 5px solid white;
  font-weight: bold;
}
</style>


<template>
  <nav class="bg-custom-blue text-white h-full w-[16%] pt-4">
    <div class="max-w-6xl mx-auto">
      <div class="flex flex-col justify-between">
        <div class="flex flex-col">
          <RouterLink
            active-class="link-active"
            to="/all-accounts"
            class="hover:bg-purple-700 transition duration-300 text-center py-2 px-7 flex items-center justify-between font-bold text-base"
          >
            <h1>All accounts</h1>
            <p>${{ totalBalance }}</p>
          </RouterLink>
          <div class="hidden w-full md:flex flex-col items-center mt-6">
            <RouterLink
              active-class="link-active"
              to="/budgeted-accounts"
              class="py-2 px-7 hover:bg-purple-700 transition duration-300 w-full font-semibold flex items-center justify-between"
            >
              <h1>Budgeted</h1>
              <span>$ {{ totalBudgeted.toLocaleString("en-US") }}</span>
            </RouterLink>
            <div
              v-for="bank in banks"
              :key="bank.bank_name"
              class="text-sm flex flex-col w-full"
            >
              <RouterLink
                active-class="link-active"
                :to="`/account/${bank.bank_name}`"
                class="py-2 px-7 hover:bg-purple-700 transition duration-300 w-full flex items-center justify-between"
              >
                <span>{{ bank.bank_name }}: </span
                ><span class=""
                  >$
                  {{
                    bank.balance.toLocaleString("en-US", {
                      style: "currency",
                      currency: "USD",
                    })
                  }}</span
                >
              </RouterLink>
            </div>
          </div>
          <div class="hidden w-full md:flex flex-col items-center mt-6">
            <RouterLink
              active-class="link-active"
              to="/off-budget-accounts"
              class="py-2 px-7 hover:bg-purple-700 transition duration-300 font-semibold w-full flex items-center justify-between"
              >Off-Budget<span
                >$ {{ totalOffBudget.toLocaleString("en-US") }}</span
              >
            </RouterLink>
            <div
              v-for="asset in offBudget"
              :key="asset"
              class="text-sm flex flex-col w-full"
            >
              <RouterLink
                active-class="link-active"
                :to="`/asset/${asset}`"
                class="py-2 px-7 hover:bg-purple-700 transition duration-300 w-full flex items-center justify-between"
              >
                {{ asset }}
                <span>$ {{ assetTotals[asset].toLocaleString("en-US") }}</span>
              </RouterLink>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>
