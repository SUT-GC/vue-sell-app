<template>
  <div>
      <div class="tab">
        <div class="tab-item">
          <router-link to="/goods">商品</router-link>
        </div>
        <div class="tab-item">
          <router-link to="/ratting">评论</router-link>
        </div>
        <div class="tab-item">
          <router-link to="/seller">商家</router-link>
        </div>
      </div>
      <router-view></router-view>
  </div>
</template>

<script>

export default {
  name: 'sellTab',
  data: function () {
    return {
      msg: '我是TAB'
    }
  }
}
</script>

<style>
.tab {
    display: flex;
    width: 100%;
    height: 40px;
    line-height: 40px;
    border-bottom: 1px solid rgba(7, 17, 27, 0.1);
}
.tab .tab-item {
    flex: 1;
    text-align: center;
}
.tab .tab-item a{
  display: block;
}
.router-link-active{
  color: brown;
}
</style>
