<script setup>
import { useAuthStore } from '../../stores/auth'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()
const router = useRouter()

async function handleLogout() {
  await authStore.logout()
  router.push({ name: 'login' })
}
</script>

<template>
  <header class="navbar">
    <strong>Shortz-App</strong>
    <nav>
      <router-link to="/">Início</router-link>

      <template v-if="!authStore.isAuthenticated">
        <router-link to="/login">Entrar</router-link>
        <router-link to="/register">Criar Conta</router-link>
      </template>

      <template v-else>
        <router-link to="/feed">Feed</router-link>
        <span>Olá, {{ authStore.user?.username }}</span>
        <button @click="handleLogout">Sair</button>
      </template>
    </nav>
  </header>
</template>