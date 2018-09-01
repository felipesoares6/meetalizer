import Vue from 'vue'
import VueRouter from 'vue-router' 

import router from './router'

import App from './src/App.vue'

Vue.config.productionTip = false

Vue.use(VueRouter)

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
