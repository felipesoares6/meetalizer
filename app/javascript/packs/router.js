import VueRouter from 'vue-router'

import Home from './src/views/Home.vue'

export default new VueRouter({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    }
  ]
})
