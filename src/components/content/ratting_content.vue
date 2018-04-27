<template>
  <div class="ratings">
    <div class="overview">
      <div class="overview-left">
        <div class="overview-left-content">
          <h1>4.9</h1>
          <h2>综合评分</h2>
          <h3>高于周边商家69.2%</h3>
        </div>
      </div>
      <div class="overview-right" v-if="seller">
        <div class="overivew-right-content">
          <div class="service-score">
            <span class="service-score-title">服务态度</span>
            <star class="service-score-star" :score="seller.serviceScore" :size="24"/>
            <span class="service-score-value">{{seller.serviceScore}}</span>
          </div>
          <div class="food-score">
            <span class="food-score-title">食物评分</span>
            <star class="food-score-star" :score="seller.foodScore" :size="24"/>
            <span class="food-score-value">{{seller.foodScore}}</span>
          </div>
          <div class="delivery-info">
            <span class="delivery-time-table">送达时间</span>
            <span class="delivery-time-value">{{seller.deliveryTime}}</span>
          </div>
        </div>
      </div>
    </div>
    <split/>
    <div class="shop-ratings" v-if="ratings">
      <ratting-select class="shop-ratings-head" :ratings="ratings" :select-type="selectType" :only-content="onlyContent" :decs="desc" v-on:switchOnlyContent="switchOnlyContent" v-on:switchSelectType="switchSelectType"/>
      <div class="shop-ratings-content">
        <ul v-for="shoprating in selectRattings" :key="shoprating.id">
          <li>
            <div class="shop-rating-head">
              <div class="shop-rating-head-left">
                <div class="shop-rating-head-left-userimg">
                  <img :src="shoprating.avatar"/>
                </div>
                <div class="shop-rating-head-left-userinfo">
                  <div class="userinfo-name">
                    {{shoprating.username}}
                  </div>
                  <di class="userinfo-star">
                    <star class="userinfo-star-content" :score="shoprating.score" :size="24"/>
                    <span class="userinfo-delivery-time" v-if="shoprating.deliveryTime">
                      {{shoprating.deliveryTime}}分钟送达
                    </span>
                  </di>
                </div>
              </div>
              <div class="shop-rating-head-right">
                {{(new Date(shoprating.rateTime)).Format("yyyy-MM-dd hh:mm")}}
              </div>
            </div>
            <div class="shop-rating-value">
                {{shoprating.text}}
            </div>
          </li>
        </ul>
      </div>
    </div>
    <div v-else class="shop-no-ratings" >
      暂无评论
    </div>
  </div>
</template>

<script>
import Star from '../star/star'
import Split from '../split/split'
import RattingSelect from '../rattingselect/rattingselect'

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
  name: 'RattingContent',
  data: function () {
    return {
      msg: '我是 RATTING CONTENT',
      seller: null,
      ratings: null,
      selectType: ALL,
      onlyContent: false,
      desc: {all: '全部', positive: '满意', negative: '不满意'}
    }
  },
  components: {
    Star,
    Split,
    RattingSelect
  },
  created: function () {
    this.$http.get('http://localhost:8888/ratings').then(function (response) {
      this.ratings = response.data
      console.log(this.ratings)
    }, function (response) {
      this.ratings = []
    })
    this.$http.get('http://localhost:8888/shop').then(function (response) {
      this.seller = response.data
      console.log(this.seller)
    }, function (response) {
      this.seller = null
    })
  },
  methods: {
    switchOnlyContent (value) {
      this.onlyContent = value
    },
    switchSelectType (value) {
      this.selectType = value
    }
  },
  computed: {
    selectRattings () {
      var result = []
      if (this.ratings) {
        this.ratings.forEach(p => {
          if (this.onlyContent) {
            if (this.selectType === ALL && p.text.length > 0) {
              result.push(p)
            } else if (p.rateType === this.selectType && p.text.length > 0) {
              result.push(p)
            }
          } else {
            if (this.selectType === ALL) {
              result.push(p)
            } else if (p.rateType === this.selectType) {
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
.ratings {
  position: absolute;
  overflow: auto;
  top: 180px;
  bottom: 0px;
  left: 0px;
  width: 100%;
}

.ratings::-webkit-scrollbar {display:none}

.overview {
  display: flex;
}

.overview-left {
  flex: 0 0 137px;
  text-align: center;
  padding: 18px;
}

.overview-right {
  flex: auto;
  padding: 18px;
}

.overview-left h1 {
  font-size: 24px;
  color: rgb(255, 153, 0);
  line-height: 28px;
}

.overview-left h2 {
  font-size: 12px;
  color: rgb(7, 17, 27);
  margin-top: 6px;
}

.overview-left h3 {
  font-size: 10px;
  color:rgb(7, 17, 27, 0.4);
  line-height: 10px;
  margin-top: 8px;
}

.overview-left-content {
  border-right: 1px solid rgb(236, 12, 12)
}

.service-score-star, .food-score-star{
  display: inline-block;
}

.overivew-right-content span {
  display: inline-block;
}

.service-score {
  margin-bottom: 8px;
}

.food-score {
  margin-bottom: 8px;
}

.service-score-title, .food-score-title, .delivery-time-table {
  font-size: 12px;
  color: rgb(7, 17, 27);
  line-height: 12px;
}

.service-score-value, .food-score-value {
  font-size: 12px;
  color: rgb(255, 153, 0);
  line-height: 12px;
}

.delivery-time-value {
  font-size: 12px;
  color: rgb(147, 153, 159);
}

.shop-no-ratings {
  margin: 18px;
  text-align: center;
  font-size: 12px;
  color: rgb(147, 153, 159);
}

.shop-ratings-head{
  padding: 18px;
  border-bottom: 1px solid rgba(147, 153, 159, 0.2);
}

.shop-ratings-content{
    margin: 18px;
}

.shop-ratings-content li {
    margin-top: 18px;
    padding-bottom: 18px;
    border-bottom: 1px solid rgba(147, 153, 159, 0.2);
}

.shop-rating-head-left, .shop-rating-head-right {
    display: inline-block;
    vertical-align: top;
}

.shop-rating-head-right {
    position: absolute;
    right: 18px;
}

.shop-rating-head-left-userimg, .shop-rating-head-left-userinfo, .userinfo-star-content{
    display: inline-block;
}

.shop-rating-head-left-userimg img {
    height: 28px;
    width: 28px;
    border-radius: 14px;
}

.userinfo-delivery-time, .shop-rating-head-right{
    font-size: 10px;
    font-weight: 200;
    color: rgb(147, 153, 159);
    line-height: 12px;
}

.userinfo-name {
    font-size: 10px;
    color: rgb(7, 17, 27);
    line-height: 24px;
}

.shop-rating-value {
    margin-left: 28px;
    margin-top: 6px;
    font-size: 12px;
    color:rgb(7, 17, 27);
    line-height: 18px;
}

</style>
