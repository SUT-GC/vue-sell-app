// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'

// import './common/stylus/index.styl'
import './common/stylus/index.styl'

import GoodsItem from './components/content/goods_content'
import SellterItem from './components/content/seller_content'
import RattingItem from './components/content/ratting_content'

Vue.use(VueRouter)
Vue.use(VueResource)

Vue.config.productionTip = false

const router = new VueRouter({
  routes: [
    { path: '/', component: GoodsItem },
    { path: '/goods', component: GoodsItem },
    { path: '/seller', component: SellterItem },
    { path: '/ratting', component: RattingItem }
  ]
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  components: { App },
  template: '<App/>',
  router
})
