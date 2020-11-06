<template>
  <div>
    <div>
      <router-link to="/">Home</router-link>
      <AllSongsList />
      <router-view />
      <a href="/users/edit">ユーザー設定</a>
      <h5>State Timer: {{ timer }}</h5>
    </div>
  </div>
</template>

<script>
import AllSongsList from "./packs/components/all_songs_list";
export default {
  components: {
    AllSongsList,
  },
  computed: {
    timer() {
      return this.$store.state.timer;
    },
  },
};
</script>

<style scoped>
</style>
