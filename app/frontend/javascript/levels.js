import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'
import LevelsForm from './components/LevelsForm.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  const levels = document.getElementById('levels-form')
  if (levels) {
    const dungeonId = levels.getAttribute('data-dungeon-id')
    new Vue({
      render: h => h(LevelsForm, { props: { dungeonId: dungeonId } }),
    }).$mount('#levels-form')
  }
})
