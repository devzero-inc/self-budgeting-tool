<script lang="ts">
import { defineComponent } from "vue";

export default defineComponent({});
</script>

<template>
  <nav
    class="bg-custom-dark-blue text-white w-full h-full flex items-center justify-between shadow-lg -b border-custom-text px-8"
  >
    <div class="flex items-center">
      <img src="../assets/icons/devzero_logo.png" alt="Logo" class="w-12 h-12 mr-4" />
      <h1 class="text-xl font-bold">Dev<span class="font-light">Zero</span></h1>
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