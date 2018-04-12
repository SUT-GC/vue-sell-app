<template>
    <div class="cartcontrol">
        <div class="cart-decrease" v-show="food.count > 0" @click="decrFoodCount($event)">
            <i class="icon-remove_circle_outline"></i>
        </div>
        <div class="cart-count" v-show="food.count > 0">
            {{food.count}}
        </div>
        <div class="cart-increase">
            <i class="icon-add_circle" @click="addFoodCount($event)"></i>
        </div>
    </div>
</template>

<script>
import Vue from 'vue'

export default {
  data: function () {
    return {
      foodCount: 1
    }
  },
  props: {
    food: {
      type: Object
    }
  },
  created () {
    if (!this.food.count) {
      Vue.set(this.food, 'count', 0)
    }
  },
  methods: {
    addFoodCount (event) {
      if (!event._constructed) {
        return
      }
      Vue.set(this.food, 'count', this.food.count + 1)
    },
    decrFoodCount () {
      if (this.food.count < 0) {
        Vue.set(this.food, 'count', 0)
      } else {
        Vue.set(this.food, 'count', this.food.count - 1)
      }
    }
  }
}
</script>

<style>
.cartcontrol {
}

.cart-decrease {
    display: inline-block;
    font-size: 24px;
    line-height: 24px;
    color: rgb(0, 160, 220);
}
.cart-count {
    display: inline-block;
    padding: 0px 6px 0px 6px;
    font-size: 10px;
    color: rgb(147, 153, 159);
    line-height: 26px;
    vertical-align: top;
}
.cart-increase {
    display: inline-block;
    font-size: 24px;
    line-height: 24px;
    color: rgb(0, 160, 220);
}

</style>
