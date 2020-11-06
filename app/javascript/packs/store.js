import Vuex from 'vuex';

export default {
  state: {
    songsList: [
      {id: 1, title: 'Chopin'},
      {id: 2, title: 'Beethoven'},
      {id: 3, title: 'Listz'},
    ],
    timer: 0,
  },
  mutations: {
    incrementTimer(state) {
      state.timer++;
    },
  },
  strict: true,
};
