<template>
  <div>{{ msg }}</div>
</template>

<script>
export default {
  name: 'SellerContent',
  data: function () {
    return {
      msg: '我是 SELLER CONTENT'
    }
  },
  created: function () {
    this.$http.get('http://localhost:8888/shop').then(function (response) {
      this.msg = response.data
    }, function (response) {
      this.msg = 'baidu error'
    })
  }
}
</script>

<style>

</style>
