import VueRouter from 'vue-router';
import Home from './components/home.vue';
import SongsShow from './components/songs_show.vue';

const routes = [
  {path: '/', component: Home},
  {path: '/songs/:id', component: SongsShow},
];
const router = new VueRouter({routes, mode: 'history'});
export default router;
