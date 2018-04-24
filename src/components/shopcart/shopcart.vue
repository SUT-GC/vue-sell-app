<template>
  <div class="shopcart">
      <div class="shopcart-left" @click="switchListShowSwap">
          <div class="logo-wrapper">
              <div class="logo" :class="{'logo-hight': foodCount > 0}">
                  <i class="icon-shopping_cart"></i>
              </div>
              <div v-if="foodCount > 0" class="food-number">
                  {{foodCount}}
              </div>
          </div>
          <div class="price">
            ¥{{payPrice}}
          </div>
          <div class="delivery_fee">
            另需配送费¥{{deliveryPrice}}元
          </div>
      </div>
      <div class="shopcart-right" :class="{'shotcart-right-pay': minPrice <= payPrice}">
          <div v-if="payPrice < minPrice" class="minPrice">
              还差¥{{minPrice - payPrice}}元起送
          </div>
          <div v-else class="toPay">
              去支付
          </div>
      </div>
      <transition name="fold">
        <div class="showcart-list" v-show="listShow">
            <div class="list-hearder">
                <h1 class="header-title">购物车</h1>
                <span class="empty" @click="emptyBuy">清空</span>
            </div>
            <div class="list-border">
                <div class="list-content">
                    <ul>
                        <li v-for="selectedFood in selectedFoods" :key="selectedFood.id">
                            <div class="selected-food-name">{{selectedFood.name}}</div>
                            <div class="selected-food-price">¥{{selectedFood.price * selectedFood.count}}</div>
                            <div class="selected-food-num">
                                <cart-control :food="selectedFood"></cart-control>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
      </transition>
  </div>
</template>

<script>
import CartControl from '../cartcontrol/cartcontrol'

export default {
  data: function () {
    return {
      listShowSwap: true
    }
  },
  props: {
    deliveryPrice: {
      type: Number
    },
    minPrice: {
      type: Number
    },
    selectedFoods: {
      type: Array,
      default () {
        return [{price: 1, count: 10}]
      }
    }
  },
  components: {
    CartControl
  },
  computed: {
    payPrice () {
      let totle = 0
      this.selectedFoods.forEach((food) => {
        totle += food.price * food.count
      })

      return totle
    },

    foodCount () {
      let totle = 0
      console.log(this.selectedFoods)
      this.selectedFoods.forEach((food) => {
        totle = totle + food.count
      })

      return totle
    },

    listShow () {
      if (!this.listShowSwap && this.foodCount > 0) {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    switchListShowSwap () {
      console.log(this.listShowSwap)
      if (!this.listShowSwap && this.foodCount > 0) {
        this.listShowSwap = true
      } else {
        this.listShowSwap = false
      }
    },
    emptyBuy () {
      this.selectedFoods.forEach((food) => {
        food.count = 0
      })
    }
  }
}
</script>

<style>

.shopcart {
  position: fixed;
  display: flex;
  left: 0;
  bottom: 0;
  z-index: 30;
  height: 48px;
  width: 100%;
  background-color: #141d27;
}

.shopcart-left {
    position: relative;
    z-index: 50;
    flex: auto;
}

.shopcart-right {
    position: relative;
    z-index: 50;
    flex: 0 0 105px;
    width: 105px;
    background: aqua
}

.showcart-list {
    position: absolute;
    z-index: -1;
    left: 0px;
    bottom: 48px;
    width: 100%;
}

.logo-wrapper {
    display: inline-block;
    position: relative;
    top: -10px;
    margin-left: 12px;
    padding: 6px;
    width: 56px;
    height: 56px;
    box-sizing: border-box;
    border-radius: 50%;
    background-color: #141d27;
}

.logo {
    z-index: 60;
    background-color: #2b343c;
    height: 100%;
    width: 100%;
    border-radius: 50%;
    text-align: center;
}

.logo-hight {
    background-color:rgb(0, 160, 220);
    height: 100%;
    width: 100%;
    border-radius: 50%;
    text-align: center
}

.food-number {
    position: absolute;
    top: 0;
    right: 0;
    width: 24px;
    height: 16x;
    line-height: 16px;
    text-align: center;
    border-radius: 16px;
    background-color: rgb(240, 20, 20);
    box-shadow:  0 4px 8px 0 rgba(0, 0, 0, 0.4);
    color: white;
    font-size: 9px;
    font-weight: 700;

}

.icon-shopping_cart{
    font-size: 24px;
    color: rgba(255, 255, 255, 0.4);
    line-height: 44px;
}

.price {
    display: inline-block;
    font-size: 16px;
    font-weight: 700;
    color: rgba(255, 255, 255, 0.4);
    line-height: 24px;
    margin-top: 12px;
    border-right: 1px solid rgba(255, 255, 255, 0.1);
    padding-right: 12px;
    box-sizing: border-box;
    vertical-align: top;
}

.delivery_fee {
    display: inline-block;
    vertical-align: top;
    margin-left: 12px;
    line-height: 24px;
    margin-top: 12px;
    font-size: 10px;
    color: rgba(255, 255, 255, 0.4);
    font-weight: 300;
}

.shopcart-right {
    background-color: #2b333b;
}

.minPrice {
    font-size: 13px;
    height: 48px;
    line-height: 48px;
    font-weight: 700;
    text-align: center;
    color: rgba(255, 255, 255, 0.4);
}

.toPay {
    font-size: 14px;
    height: 48px;
    line-height: 48px;
    font-weight: 700;
    text-align: center;
    color: white;
}

.shotcart-right-pay {
    background-color: #00b43c;
}

.list-hearder {
    height: 40px;
    line-height: 40px;
    padding: 0px 18px 0 18px;
    background-color: #f3f5f7;
    border: 1px solid rgba(7, 17, 27, 0.1);
}

.header-title {
    font-size: 14px;
    float: left;
    color: rgb(7, 17, 27)
}

.empty {
    font-size: 12px;
    float:right;
    color: rgb(0, 160, 220);
}

.fold-enter-to{
    transition: all 0.5s;
    transform: translate(0, 0);
}

.fold-leave {
    transform: translate(0, 0);
}

.fold-leave-to {
    transition: all 0.5s;
    transform: translate(0, 100%);
}

.fold-enter {
    transform: translate(0, 100%);
}

.list-content {
    padding: 0 18px;
    max-height: 217px;
    overflow: auto;
    background: #fff;
}

.list-content li {
    line-height: 40px;
    font-size: 14px;
    display: flex;
    border-bottom: 1px solid rgba(7, 17, 27, 0.1);
}

.selected-food-num{
    display: inline-block;
    flex: 0 0 90px;
    padding-top: 7px;
}

.selected-food-price {
    display: inline-block;
    flex: 0 0 60px;
    color:red;
    font-weight: 700
}

.selected-food-name {
    display: inline-block;
    flex: auto;
}

</style>
