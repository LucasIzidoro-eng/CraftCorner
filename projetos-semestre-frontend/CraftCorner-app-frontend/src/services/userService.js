import api from './api'

export function getMyProfile() {
  return api.get('/profile/me')
}