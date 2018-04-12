<template>
  <div class="goods">
    <div class="menu" ref="wrapper">
      <ul v-if="groups">
        <li  v-for="(group, index) in groups" :key="group.id" :class="{'current-menu': currentIndex === index, 'menu-item': currentIndex !== index}" @click="swapMenu(index, $event)">
          <span v-show="group.type > 0" class="menu-item-text">{{ group.name }}</span>
          <span v-show="group.type <= 0" class="menu-item-text">{{ group.name }}</span>
        </li>
      </ul>
    </div>
    <div class="foods" ref="foods">
      <ul v-if="groups">
        <li v-for="group in groups" class="groups-hook" :key="group.id">
          <h1 class="group-name">{{group.name}}</h1>
          <ul v-if="group.foods" class="foods">
            <li class="food" v-for="food in group.foods" :key="food.id">
              <div class="food-icon">
                <img :src="food.icon"/>
              </div>
              <div class="food-content">
                <h1 class="food-name">{{food.name}}</h1>
                <p class="food-desc">{{food.description}}</p>
                <div class="food-extra">
                  <span>月售{{food.sellCount}}份</span>
                  <span>好评率{{food.rating}}%</span>
                </div>
                <div class="food-price">
                  <span class="new-price"> ¥{{food.price}} </span>
                  <span v-if="food.oldPrice" class="old-price"> ¥{{food.oldPrice}}</span>
                </div>
                <div class="cart-control-wrapper">
                  <cart-control v-bind:food="food"></cart-control>
                </div>
              </div>
            </li>
          </ul>
        </li>
      </ul>
    </div>
    <shop-cart :delivery-price="seller.deliveryPrice" :min-price="seller.minPrice" :selected-foods="selectFoods"></shop-cart>
  </div>
</template>

<script>
import BScroll from 'better-scroll'
import ShopCart from '../shopcart/shopcart'
import CartControl from '../cartcontrol/cartcontrol'

export default {
  name: 'GoodsContent',

  data: function () {
    return {
      groups: [],
      listHeight: [],
      scorllY: 0,
      seller: ''
    }
  },
  components: {
    ShopCart,
    CartControl
  },
  props: {
  },
  created: function () {
    this.$http.get('http://localhost:8888/groups').then(function (response) {
      this.groups = response.data
      this.$nextTick(() => {
        this._initScroll()
        this._calculateHeight()
      })
    }, function (response) {
      this.msg = 'get data error'
    })
    this.$http.get('http://localhost:8888/shop').then(function (response) {
      this.seller = response.data
      console.log(this.seller)
    }, function (response) {
      this.msg = 'baidu error'
    })
  },
  computed: {
    currentIndex: {
      get: function () {
        if (this.listHeight.length <= 1) {
          return 0
        }
        for (let i = 1; i < this.listHeight.length; i++) {
          if (this.listHeight[i - 1] <= this.scorllY && this.listHeight[i] > this.scorllY) {
            return i - 1
          }
        }
      },
      set: function (newScrollY) {
        this.scorllY = newScrollY
      }
    },
    selectFoods () {
      let selectedFoods = []
      this.groups.forEach(group => {
        group.foods.forEach(food => {
          if (food.count) {
            selectedFoods.push(food)
          }
        })
      })
      console.log('selected_foods', selectedFoods)
      return selectedFoods
    }
  },
  methods: {
    _initScroll: function () {
      this.menuScroll = new BScroll(this.$refs.wrapper, {
        click: true
      })
      this.foodsScroll = new BScroll(this.$refs.foods, {
        probeType: 3,
        click: true
      })

      this.foodsScroll.on('scroll', (pos) => {
        this.currentIndex = Math.abs(Math.round(pos.y))
      })
    },
    _calculateHeight () {
      let groups = this.$refs.foods.getElementsByClassName('groups-hook')
      let height = 0
      this.listHeight.push(height)
      for (let i = 0; i < groups.length; i++) {
        let group = groups[i]
        height += group.clientHeight
        this.listHeight.push(height)
      }
      console.log(this.listHeight)
    },
    swapMenu (index, event) {
      if (!event._constructed) {
        return
      }
      let groups = this.$refs.foods.getElementsByClassName('groups-hook')
      let el = groups[index]
      this.foodsScroll.scrollToElement(el, 300)
    }
  }
}
</script>

<style>

::-webkit-scrollbar{
  display: none;
}

.goods{
  display: flex;
  position: absolute;
  width: 100%;
  top: 178px;
  bottom: 46px;
  overflow: hidden;
}

.goods .menu{
  flex: 0 0 80px;
  width: 80px;
  background-color: #f3f5f7;
  overflow: hidden;
}

.goods .menu .menu-item{
  display: table;
  width: 56px;
  height: 54px;
  margin-left: 12px;
  border-bottom: rgba(7, 17, 27, 0.1) solid 1px;
}

.goods .foods{
  flex: 1;
  overflow: hidden;
}

.menu ul :last-child{
  border-bottom: rgba(7, 17, 27, 0.1) solid 0px;
}

.menu-item-text{
  font-size: 12px;
  color: rgb(7, 17, 27);
  font-weight: 400;
  line-height: 14px;
  vertical-align: middle;
  display: table-cell;
}

.group-name{
  height: 30px;
  line-height: 30px;
  font-size: 12px;
  padding-left: 14px;
  border-left: #d9dde1 solid 2px;
  background-color: #f3f5f7;
  color: rgb(147, 153, 159);
}

.food {
  display: flex;
  margin: 18px 18px 0px 18px;
  padding-bottom: 18px;
  border-bottom: rgba(7, 17, 27, 0.1) solid 1px;
}

.foods li :last-child{
  border-bottom: rgba(7, 17, 27, 0.1) solid 0px;
}

.food-icon {
  flex: 0 1 57px;
}

.food-icon img {
  height: 57px;
  width: 57px;
}

.food-content{
  position: relative;
  margin-left: 10px;
  flex: 1
}

.food-content .food-name {
  margin-top: 2px;
  line-height: 14px;
  font-size: 14px;
  color: rgb(7, 17, 27)

}

.food-content .food-desc {
  margin-top: 8px;
  font-size: 10px;
  color: rgb(147, 153, 159)
}

.food-content .food-extra {
  margin-top: 8px;
  font-size: 10px;
  line-height: 10px;
  color: rgb(147, 153, 159)
}

.food-price .new-price {
  font-size: 14px;
  color: red;
  font-weight: 700;
  line-height: 24px;
}

.food-price .old-price {
  font-size: 10px;
  line-height: 10px;
  margin-left: 4px;
  color: rgb(147, 153, 159);
  text-decoration:line-through;
}

.current-menu {
  display: table;
  width: 56px;
  height: 54px;
  padding-left: 12px;
  padding-right: 12px;
  background-color: rgb(255, 255, 255);
}

.cart-control-wrapper {
  position: absolute;
  right: 0;
  bottom: 0;
}
</style>
