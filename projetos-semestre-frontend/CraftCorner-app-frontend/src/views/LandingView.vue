<script setup>
import { ref, onMounted } from 'vue'
import { getApiStatus } from '../services/systemService'
import { search } from '../services/searchService'

const apiStatus = ref('verificando...')

onMounted(async () => {
  try {
    const response = await getApiStatus()
    apiStatus.value = response.data.status // "online"
  } catch (error) {
    apiStatus.value = 'offline'
    console.error('Erro ao consultar a API:', error.message)
  }
})
</script>

<template>
  <div class="landing">
    <h1>Bem-vindo à CraftCornerApp</h1>
    <p>Status da API: <strong>{{ apiStatus }}</strong></p>
  </div>
</template>