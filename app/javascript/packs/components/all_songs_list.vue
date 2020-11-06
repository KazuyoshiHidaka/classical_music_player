<template>
  <div>
    allSongsList
    <router-link
      v-for="(song, i) in songs"
      :to="'/songs/' + song.id"
      :key="song.id"
    >
      {{ i }}. {{ song.title }}
    </router-link>
  </div>
</template>

<script>
export default {
  computed: {
    songs() {
      return this.$store.state.songsList;
    },
  },
};
</script>

<style scoped>
</style>