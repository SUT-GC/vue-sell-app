<template>
  <div class="shopcart">
      <div class="shopcart-left">
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
      <div class="showcart-list" v-show="listShow">
          <div class="list-hearder">
              <h1 class="header-title">购物车</h1>
              <span class="empty">清空</span>
          </div>
          <div class="list-border">
              <div class="list-content">
                  <ul>
                      <li v-for="selectedFood in selectedFoods" :key="selectedFood.id">
                          <div class="selected-food-name">{{selectedFood.name}}</div>
                          <div class="selected-food-price">{{selectedFood.price}}</div>
                          <div class="selected-food-num">
                              <cart-control :food="selectedFood"></cart-control>
                          </div>
                      </li>
                  </ul>
              </div>
          </div>
      </div>
  </div>
</template>

<script>
import CartControl from '../cartcontrol/cartcontrol'

export default {
  data: function () {
    return {
      listShow: false
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
  z-index: 50;
  height: 48px;
  width: 100%;
  background-color: #141d27;
}

.shopcart-left {
    flex: auto;
}

.shopcart-right {
    flex: 0 0 105px;
    width: 105px;
    background: aqua;
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
    z-index: 60;
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

</style>
