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
      path: '/account/:bankName',
      name: 'bank-account',
      component: () => import('../components/BankAccountView.vue'),
      props: true
    },
  ]
})

export default router
