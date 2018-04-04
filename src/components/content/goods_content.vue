<template>
  <div class="goods">
    <div class="menu">
      <ul v-if="groups">
        <li  v-for="group in groups" :key="group.id" class="menu-item">
          <span v-show="group.type > 0" class="menu-item-text">{{ group.name }}</span>
          <span v-show="group.type <= 0" class="menu-item-text">{{ group.name }}</span>
        </li>
      </ul>
    </div>
    <div class="foods"></div>
  </div>
</template>

<script>
export default {
  name: 'GoodsContent',
  data: function () {
    return {
      groups: []
    }
  },
  props: {
    seller: {
      type: Object
    }
  },
  created: function () {
    this.$http.get('http://localhost:8888/groups').then(function (response) {
      this.groups = response.data
    }, function (response) {
      this.msg = 'get data error'
    })
  }
}
</script>

<style>

.goods{
  display: flex;
  overflow: hidden;
  position: absolute;
  width: 100%;
  top: 178px;
  bottom: 46px;
}

.goods .menu{
  flex: 0 0 80px;
  width: 80px;
  overflow: auto;
  background-color: #f3f5f7;
}

.goods .foods{
  flex: 1;
}

.menu-item{
  display: table;
  width: 56px;
  height: 54px;
  margin-left: 12px;
  border-bottom: rgba(7, 17, 27, 0.1) solid 1px;
}

.menu-item-text{
  font-size: 12px;
  color: rgb(94, 88, 88);
  font-weight: 300;
  line-height: 14px;
  vertical-align: middle;
  display: table-cell;
}
</style>
