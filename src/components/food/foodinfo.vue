<template>
  <div class="food-info-wrapper" ref="foodInfo">
    <transition name="move-transition">
      <div v-if="food" v-show="foodInfoShow" class="foodInfo">
        <div class="img-title">
          <img :src="food.image"/>
          <div class="back" @click="hide">
            <i class="icon-arrow_lift"></i>
          </div>
        </div>
        <div class="food-info-content">
          <h1 class="food-info-title">{{food.name}}</h1>
          <div class="food-info-detail">
            <span>月售{{food.sellCount}}份</span>
            <span>好评率{{food.rating}}%</span>
          </div>
          <div class="food-info-price">
            <span class="food-info-new-price"> ¥{{food.price}} </span>
            <span v-if="food.oldPrice" class="food-info-old-price"> ¥{{food.oldPrice}}</span>
          </div>
          <div v-if="!food.count" class="food-info-add-buy" @click="buy">
            加入购物车
          </div>
          <div v-else class="food-info-cart-control">
            <cart-control :food="food"/>
          </div>
        </div>
        <split/>
        <div v-if="food.info" class="food-info-description">
          <h1 class="description-title">
            商品介绍
          </h1>
          <p>{{food.info}}</p>
        </div>
        <split v-if="food.info"/>
        <div class="food-info-rating">
          <h1>商品评价</h1>
          <rating-select :select-type="selectType" :only-content="onlyContent" :desc="selectDesc" :ratings="food.ratings" v-on:switchOnlyContent="switchOnlyContent" v-on:switchSelectType="switchSelectType"/>
        </div>
        <div class="food-info-rating-content">
          <ul v-show="food.ratings && food.ratings.length">
            <li class="rating-item" v-for="rating in getShowRatings(food.ratings, selectType, onlyContent)" :key="rating.id">
              <div class="rating-time">
                {{(new Date(rating.rateTime)).Format("yyyy-MM-dd hh:mm")}}
              </div>
              <div class="user-info">
                <div class="user-name">{{rating.username}}</div>
                <img class="user-img" width="12px" height="12px" :src="rating.avatar"/>
              </div>
              <p class="rating-content">
                <span :class="{'icon-thumb_up': rating.rateType === 0, 'icon-thumb_down': rating.rateType === 1}"></span>
                {{rating.text}}
              </p>
            </li>
          </ul>
          <div class="no-ratings" v-show="!food.ratings || food.ratings.length <= 0">暂无评价</div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
import CartControl from '../cartcontrol/cartcontrol'
import Split from '../split/split'
import RatingSelect from '../rattingselect/rattingselect'
import Vue from 'vue'

// const POSITIVE = 0
// const NGEATIVE = 1
const ALL = 2

Date.prototype.Format = function (fmt) {
  var o = {
    'M+': this.getMonth() + 1,
    'd+': this.getDate(),
    'h+': this.getHours(),
    'm+': this.getMinutes(),
    's+': this.getSeconds(),
    'q+': Math.floor((this.getMonth() + 3) / 3),
    'S': this.getMilliseconds()
  }
  if (/(y+)/.test(fmt)) {
    fmt = fmt.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length))
  }
  for (var k in o) {
    if (new RegExp('(' + k + ')').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)))
  }
  return fmt
}

export default {
  props: {
    food: {
      type: Object
    }
  },
  data: function () {
    return {
      showFlat: false,
      selectDesc: {
        all: '全部',
        positive: '推荐',
        negative: '吐槽'
      },
      onlyContent: false,
      selectType: ALL
    }
  },
  computed: {
    foodInfoShow () {
      if (this.showFlat && this.food) {
        return true
      }

      return false
    }
  },
  components: {
    CartControl,
    Split,
    RatingSelect
  },
  methods: {
    show () {
      this.selectType = ALL
      this.onlyContent = false
      this.showFlat = true
    },
    hide () {
      this.showFlat = false
    },
    buy () {
      Vue.set(this.food, 'count', 1)
    },
    switchOnlyContent (value) {
      this.onlyContent = value
    },
    switchSelectType (value) {
      this.selectType = value
    },
    getShowRatings (ratings, type, onlyContent) {
      var result = []
      if (ratings) {
        ratings.forEach(p => {
          if (onlyContent) {
            if (type === ALL && p.text.length > 0) {
              result.push(p)
            } else if (p.rateType === type && p.text.length > 0) {
              result.push(p)
            }
          } else {
            if (type === ALL) {
              result.push(p)
            } else if (p.rateType === type) {
              result.push(p)
            }
          }
        })
      }
      return result
    }
  }
}
</script>

<style>
.foodInfo {
  position: fixed;
  left: 0;
  top: 0;
  bottom: 48px;
  z-index: 10;
  width: 100%;
  overflow: auto;
  background: #fff;
}

.move-transition-enter-to, .move-transition-leave {
  transition: all 0.2s linear;
  transform: translate3d(0,0,0);
}

.move-transition-enter, .move-transition-leave-to {
  transform: translate3d(100%,0,0);
}

.img-title {
  position: relative;
  width: 100%;
  height: 0;
  padding-top: 100%;

}

.img-title img{
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  widows: 100%;
}

.back{
  position: absolute;
  top: 10px;
  left: 10px;
  padding: 10px;
}

.back i{
  font-size: 20px;
  color: rgb(7, 17, 27);
}

.food-info-content{
  padding:18px;
}

.food-info-title{
  line-height: 14px;
  margin-bottom: 8px;
  font-size: 14px;
  font-weight: 700;
  color: rgb(7, 17, 27);
}

.food-info-detail{
  margin-bottom: 8px;
  line-height: 10px;
  font-size: 10px;
}

.food-info-detail span {
  color: rgb(147, 153, 159)
}

.food-info-price .food-info-new-price {
  font-size: 14px;
  color: red;
  font-weight: 700;
  line-height: 24px;
}

.food-info-price .food-info-old-price {
  font-size: 10px;
  line-height: 10px;
  margin-left: 4px;
  color: rgb(147, 153, 159);
  text-decoration:line-through;
}

.food-info-wrapper{
  overflow: hidden;
}

.food-info-cart-control{

}

.food-info-add-buy{
  position: relative;
  float: right;
  top: -24px;
  width: 74px;
  height:24px;
  border-radius: 12px;
  background-color: rgb(0, 160, 220);
  color:#fff;
  font-size: 10px;
  line-height: 24px;
  text-align: center;
}

.food-info-cart-control {
  position: relative;
  float: right;
  top: -24px;
}

.food-info-description{
  padding: 18px;
}

.food-info-description h1 {
  font-size: 14px;
  font-weight: 700;
}

.food-info-description p {
  margin:12px;
  font-size: 12px;
  line-height: 24px;
  color: rgb(77, 85, 93);
}

.food-info-rating {
  padding: 18px;
}

.food-info-rating h1 {
  font-size: 14px;
  line-height: 14px;
  margin-bottom: 6px;
  font-weight: 700;
  color: rgb(7, 17, 27)
}

.food-info-rating-content {
  padding: 18px;
}

.rating-item {
  position: relative;
  padding: 16px;
  border-bottom: 1px solid rgb(7, 17, 27, 0.1);
  margin-bottom: 15px;
}

.user-img{
  vertical-align: top;
  display: inline-block;
}

.user-name{
  display: inline-block;
  color: rgb(147, 153, 159);
  vertical-align: top;
  margin-right: 6px;
  font-size: 10px;
}

.rating-time{
  display: inline-block;
  position: absolute;
  left: 0;
  top: 0;
  font-size: 10px;
  color: rgb(147, 153, 159);
  line-height: 12px;
}

.user-info {
  display: inline-block;
  position: absolute;
  right: 0;
  top: 0;
}

.rating-content span{
  font-size: 12px;
  line-height: 24px;
  margin-right: 4px;
}

.rating-content {
  font-size: 12px;
  line-height: 16px;
  color: rgb(7, 17, 27)
}

.icon-thumb_up {
  color:rgb(0, 160, 220);
}

.icon-thumb_down {
  color: rgb(147, 153, 159);
}

</style>
