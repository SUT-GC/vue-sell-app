<template>
  <div>{{ msg }}</div>
</template>

<script>
export default {
  name: 'RattingContent',
  data: function () {
    return {
      msg: '我是 RATTING CONTENT'
    }
  },
  created: function () {
    this.$http.get('http://localhost:8888/ratings').then(function (response) {
      this.msg = response.data
    }, function (response) {
      this.msg = 'baidu error'
    })
  }
}
</script>

<style>

</style>
