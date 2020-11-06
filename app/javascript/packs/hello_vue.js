/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

// import Vue from 'vue'
// import App from '../app.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     render: h => h(App)
//   }).$mount()
//   document.body.appendChild(app.$el)

//   console.log(app)
// })

// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>

// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
import Vue from 'vue/dist/vue.esm';
import Vuex from 'vuex';
import VueRouter from 'vue-router';
import TurbolinksAdapter from 'vue-turbolinks';
import App from '../app.vue';
import router from './router';
import storeConfig from './store';
import Turbolinks from 'turbolinks';
Turbolinks.start();
Vue.use(TurbolinksAdapter);
Vue.use(VueRouter);
Vue.use(Vuex);

var store;
var interval;
if (!store) store = new Vuex.Store(storeConfig);
document.addEventListener('turbolinks:load', () => {
  var element = document.getElementById('hello');
  if (element != null) {
    var vueapp = new Vue({
      router,
      store: store,
      el: element,
      components: {App},
    });

    clearInterval(interval);
    interval = setInterval(() => {
      vueapp.$store.commit('incrementTimer');
    }, 1000);

    document.addEventListener(
      'turbolinks:before-visit',
      function saveSPALastLocationToTurbolinks() {
        clearInterval(interval);
        document.removeEventListener(
          'turbolinks:before-visit',
          saveSPALastLocationToTurbolinks,
        );
        // SPAからTurbolinksに切り替わる直前のページを、
        // Turbolinksで復元できるようにする
        Turbolinks.controller.replaceHistoryWithLocationAndRestorationIdentifier(
          location,
          Turbolinks.uuid(),
        );
        Turbolinks.controller.cache.put(
          location,
          Turbolinks.Snapshot.fromHTMLElement(document.querySelector('html')),
        );
      },
    );
  }
});
