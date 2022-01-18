import Vue from 'vue'
import App from './App.vue'
import router from './router.js'
import Chart from 'chart.js'
import Chartick from 'vue-chartkick'
import { VueSpinners } from '@saeris/vue-spinners'
Vue.config.productionTip = false

Vue.use(VueSpinners)
Vue.use(Chartick.use(Chart))

new Vue({
    router: router,
    render: h => h(App),
}).$mount('#app')
