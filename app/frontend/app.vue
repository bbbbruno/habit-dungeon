<template>
  <div id="app">
    <p>{{ message }}</p>
    <button @click="showAlert">Hello world</button>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      message: 'Hello Vue!',
    }
  },
  methods: {
    showAlert() {
      this.$swal('Hello Vue world!!!')
    },
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
