<template>
  <div class="seller" v-if="seller">
    <div class="seller-content">
      <div class="seller-overview">
        <h1 class="title">{{seller.name}}</h1>
        <div class="desc">
          <star class="seller-star" :size="24" :score="seller.score"/>
          <span class="rating-count">({{seller.ratingCount}})</span>
          <span class="sell-count">月售{{seller.sellCount}}单</span>
        </div>
        <ul class="remark">
          <li class="block">
            <h2>起送价</h2>
            <div class="price-content">
              <span class="number">
                {{seller.minPrice}}
              </span>
              <span class="unit">
                元
              </span>
            </div>
          </li>
          <li class="block delivery">
            <h2>商家配送</h2>
            <div class="delivery-content">
              <span class="number">
                {{seller.deliveryPrice}}
              </span>
              <span class="unit">
                元
              </span>
            </div>
          </li>
          <li class="block">
            <h2>平均配送时间</h2>
            <div class="time-content">
              <span class="number">
                {{seller.deliveryTime}}
              </span>
              <span class="unit">
                分钟
              </span>
            </div>
          </li>
        </ul>
        <div class="favorite">
          <span class="icon-favorite" :class="{'favorite-active': favorite}" @click="changeFavorite"></span>
          <span class="favorite-text">{{favoriteText}}</span>
        </div>
      </div>
      <spilt/>
      <div class="bulletin">
        <h1 class="bulletin-title">公告与活动</h1>
        <p class="bulletin-desc">{{seller.bulletin}}</p>
        <div v-if="seller.supports" class="bulletin-supports" >
          <div class="bulletin-supports-item" v-for="item in seller.supports" :key="item.id">
            <span class="icon" v-bind:class="'icon_' + item.type"></span>
            <span class="support-text">{{item.description}}</span>
          </div>
        </div>
      </div>
      <spilt/>
      <div class="shop-pics">
        <h1 class="title">商家实景</h1>
        <div class="pic-wrapper">
          <ul class="pics-list" v-if="seller.pics">
            <li class="shop-pic" v-for="pic in seller.pics" :key="pic.id">
              <img :src="pic"/>
            </li>
          </ul>
        </div>
      </div>
      <spilt/>
      <div class="shop-info">
        <h1 class="info-title">商家信息</h1>
        <div class="info-line" v-for="info in seller.infos" :key="info.id">{{info}}</div>
      </div>
    </div>
  </div>
</template>

<script>
import Star from '../star/star'
import Spilt from '../split/split'

export default {
  name: 'SellerContent',
  data: function () {
    return {
      seller: null,
      error_msg: '',
      favorite: false ,
    }
  },
  components: {
    Star,
    Spilt
  },
  created: function () {
    this.$http.get('/d2/shop').then(function (response) {
      this.seller = response.data
      console.log(this.msg)
    }, function (response) {
      this.error_msg = 'baidu error'
    })
  },
  methods: {
    changeFavorite () {
      this.favorite = !this.favorite
    }
  },
  computed: {
    favoriteText () {
      if (this.favorite) {
        return '已收藏'
      } else {
        return '未收藏'
      }
    }
  }
}
</script>

<style>
.seller{
  position: absolute;
  top: 180px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  width: 100%;
  overflow: auto;
}

.seller-overview{
  padding:18px;
}

.title{
  font-size: 14px;
  color:rgb(7,17,27);
  line-height: 14px;
  margin-bottom: 8px;
}

.seller-star{
  display: inline-block;
}

.rating-count, .sell-count{
  margin-left: 8px;
  font-size: 10px;
  color: rgb(77, 85, 93);
  line-height: 18px;
}

.desc{
  margin-bottom: 18px;
}

.remark {
  padding-top: 18px;
  padding-bottom: 18px;
  display: flex;
  border-top: 1px solid rgba(7, 17, 27, 0.1);
}

.block {
  flex:1;
  text-align: center;
}

.block h2{
  font-size: 10px;
  line-height: 10px;
  margin-bottom: 4px;
  color: rgb(147, 153, 159);
}

.number {
  font-size: 20px;
  color: rgb(7,17,27);
  line-height: 24px;
}

.unit{
  font-size: 10px;
  font-weight: 200;
  color: rgb(7,17,27);
  line-height: 24px;
}

.delivery{
  border-right: 1px solid rgba(7, 17, 27, 0.1);
  border-left: 1px solid rgba(7, 17, 27, 0.1);
}

.bulletin {
  padding: 18px;
}

.bulletin-title{
  font-size: 14px;
  color: rgb(7,17,27);
  line-height: 14px;
}

.bulletin-desc{
  font-size: 12px;
  font-weight: 200;
  color:rgb(200, 20, 20);
  line-height: 24px;
  margin-top: 8px;
  padding:0 12px;
}

.bulletin-supports{
  margin-top: 16px;
}

.bulletin-supports-item {
  border-top: 1px solid rgba(7, 17, 27, 0.1);
  padding: 16px;
  font-size: 12px;
  font-weight: 200;
  color:rgb(7,17,27);
  line-height: 16px;
}

.bulletin-supports-item .icon_0 {
  background-size: 12px 12px;
  background-image: url("./decrease_4@3x.png");
}

.bulletin-supports-item .icon_1 {
  background-size: 12px 12px;
  background-image: url("./discount_4@3x.png");
}

.bulletin-supports-item .icon_2 {
  background-size: 12px 12px;
  background-image: url("./special_4@3x.png");
}

.bulletin-supports-item .icon_3 {
  background-size: 12px 12px;
  background-image: url("./invoice_4@3x.png");
}

.bulletin-supports-item .icon_4 {
  background-size: 12px 12px;
  background-image: url("./guarantee_4@3x.png");
}

.shop-pics {
  padding: 18px;
}

.shop-pics .title{
  font-size: 14px;
  color: rgb(7,17,27);
  line-height: 14px;
}

.pic-wrapper {
  margin-top: 12px;
  width: 100%;
  white-space: nowrap;
  overflow: auto;
}

.shop-pic{
  display: inline-block;
}

.shop-pic img{
  width: 120px;
  height: 90px;
  margin-right: 6px;
}

.shop-info {
  padding: 18px;
}

.info-title{
  font-size: 14px;
  color: rgb(7,17,27);
  line-height: 14px;
  margin-bottom: 12px;
}

.info-line{
  padding: 16px 13px;
  font-size: 12px;
  font-weight: 200;
  color: rgb(7,17,27);
  line-height: 16px;
  border-top: 1px solid rgba(7, 17, 27, 0.1);
}

.favorite{
  position: absolute;
  right: 18px;
  top: 18px;
  width: 40px;
  text-align: center;
}

.icon-favorite{
  font-size: 24px;
  line-height: 24px;
  color: #d4d6d9;
}

.favorite-text {
  margin-top: 4px;
  font-size: 10px;
  line-height: 10px;
  color: rgb(77, 85, 93);
}

.favorite-active {
  color: red;
}

</style>
