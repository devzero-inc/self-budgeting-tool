<script lang="ts">
import { defineComponent } from "vue";
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import { RouterLink } from "vue-router";

export default defineComponent({});
</script>

<style>
.link-active2 {
  border-bottom: 5px solid white;
  font-weight: bold;
}
</style>

<template>
  <nav
    class="bg-custom-dark-blue text-white w-full h-full flex items-center justify-between shadow-lg -b border-custom-text px-8"
  >
    <div class="flex items-center">
      <img src="../assets/icons/devzero_logo.png" alt="Logo" class="w-12 h-12 mr-4" />
      <h1 class="text-xl font-bold">Dev<span class="font-light">Zero</span></h1>
    </div>
    <div class="flex items-center text-lg h-full">
      <RouterLink
      active-class="link-active2"
        to="/"
        class="flex items-center justify-center gap-4 py-6 px-6 h-full w-full text-center hover:bg-purple-700 transition duration-300 font-bold"
      >
        <img class="w-6 invert" src="../assets/icons/wallet.png" alt="" />
        <h1 class="text-lg">Budget</h1>
      </RouterLink>
      <RouterLink
      active-class="link-active2"
        to="/contact"
        class="flex items-center justify-center gap-4 py-2 px-6 h-full w-full text-center hover:bg-purple-700 transition duration-300 font-bold"
      >
        <img class="w-6 invert" src="../assets/icons/phone.png" alt="" />
        <h1 class="text-lg">Contact</h1>
      </RouterLink>
    </div>

    <div class="flex items-center">
      <div
        class="flex items-center justify-center bg-white text-custom-blue rounded-full w-10 h-10 overflow-hidden border-2 border-white"
      >
        <img
          src="../assets/icons/user.png"
          alt="User"
          class="w-full h-full object-cover"
        />
      </div>
    </div>
  </nav>
</template>