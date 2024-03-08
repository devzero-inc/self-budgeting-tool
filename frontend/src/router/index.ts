import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {
      path: '/all-accounts',
      name: 'all-accounts',
      component: () => import('../components/AllAccountsView.vue')
    },
    {
      path: '/budgeted-accounts',
      name: 'budgeted-accounts',
      component: () => import('../components/BudgetedView.vue')
    },
    {
      path: '/account/:bankName',
      name: 'bank-account',
      component: () => import('../components/BankAccountView.vue'),
      props: true
    },
    {
      path: '/off-budget-accounts',
      name: 'off-budget-accounts',
      component: () => import('../components/OffBudgetView.vue')
    },
    {
      path: '/asset/:assetName',
      name: 'asset-name',
      component: () => import('../components/AssetView.vue'),
      props: true
    },
    {
      path: '/contact',
      name: 'contact',
      component: () => import('../components/ContactView.vue')
    }
  ]
})

export default router
