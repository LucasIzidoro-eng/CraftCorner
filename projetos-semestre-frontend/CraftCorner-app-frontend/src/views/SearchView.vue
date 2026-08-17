import { search } from '../services/searchService'

// ... dentro do onMounted, após o bloco try/catch do getApiStatus:
search('a')
  .then((response) => {
    console.log('Busca OK:', response.data)
  })
  .catch((error) => {
    console.error('Erro na busca:', error.message)
  })