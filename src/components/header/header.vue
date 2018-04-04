<template>
  <div class="header">
    <div class="content-wrapper">
      <div class="avatar">
        <img width="64" height="64" v-bind:src="seller.avatar"/>
      </div>
      <div class="content">
        <div class="content-title">
          <span class="brand"></span>
          <span class="name">{{seller.name}}</span>
        </div>
        <div class="content-description">
          {{seller.description}} / {{seller.deliveryTime}}分钟送达
        </div>
        <div v-if="seller.supports" class="content-support" @click="showDetail()">
          <span class="icon" v-bind:class="'icon_' + seller.supports[0].type"></span>
          <span class="support-text">{{seller.supports[0].description}}</span>
          <div v-if="seller.supports" class="support-count">
            <span>{{ seller.supports.length }}个</span>
            <a>></a>
          </div>
        </div>
      </div>
    </div>
    <div v-if="seller.bulletin" class="bulletin-wrapper" @click="showDetail()">
      <div class="bulletin-icon"></div>
      <div class="bulletin-content">{{ seller.bulletin }}</div>
    </div>
    <div class="background">
      <img :src="seller.avatar"/>
    </div>
    <transition name="detail-fade">
      <div v-show="detailShow" class="detail">
        <div class="detail-wrapper clearfix">
          <div class="detail-main">
            <h1 class="detail-main-title">
              {{seller.name}}
            </h1>
            <star class="detail-star" :size="48" :score="seller.score"/>
            <div class="activity-header">
              <div class="line"></div>
              <div class="acitvity-header-text">优惠信息</div>
              <div class="line"></div>
            </div>
            <div v-if="seller.supports" class="detail-supports" >
              <div class="detail-supports-item" v-for="item in seller.supports" :key="item.id">
                <span class="icon" v-bind:class="'icon_' + item.type"></span>
                <span class="support-text">{{item.description}}</span>
              </div>
            </div>
            <div class="activity-header">
              <div class="line"></div>
              <div class="acitvity-header-text">商家公告</div>
              <div class="line"></div>
            </div>
            <div class="detail-bulletin">
              {{ seller.bulletin }}
            </div>
          </div>
        </div>
        <div class="detail-close"  @click="hideDetail()">
          <i class="icon-close"></i>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
import star from '../star/star'

export default {
  name: 'sellHeader',
  data: function () {
    return {
      msg: '我是HDEADER',
      seller: '',
      detailShow: false
    }
  },
  components: {
    star
  },
  methods: {
    showDetail () {
      this.detailShow = true
    },
    hideDetail () {
      this.detailShow = false
    }
  },
  created: function () {
    this.$http.get('http://localhost:8888/shop').then(function (response) {
      this.seller = response.data
      console.log(this.seller)
    }, function (response) {
      this.msg = 'baidu error'
    })
  }
}
</script>

<style>
.header{
  position: relative;
  color: white;
  overflow: hidden;
  background-color: rgba(7, 17, 27, 0.5)
}

.header .background{
  top: 0px;
  left: 0px;
  width: 100%;
  height: 100%;
  position: absolute;
  z-index: -1;
  float: left;
  filter: blur(10px)
}

.header .background img{
  width: 100%;
  height: 100%;
}

.header .content-wrapper{
  padding: 24px 16px 18px 24px;
}

.header .content-wrapper .avatar{
  display: inline-block;
}

.header .content-wrapper .avatar img{
  border-radius: 2px;
}

.header .content-wrapper .content{
  display: inline-block;
  margin-left: 12px;
  vertical-align: top;
}

.header .content-wrapper .content .content-title{
  margin: 2px 0px 4px 0px;
}

.header .content-wrapper .content .content-description{
  margin-bottom: 10px;
  margin-top: 10px;
  line-height: 12px;
  font-size: 12px;
}

.header .content-wrapper .content .brand {
  width: 30px;
  height: 18px;
  display: inline-block;
  background-image: url("./brand@2x.png");
  background-repeat: no-repeat;
  background-size: 30px, 18px;
  vertical-align: top;
}

.header .content-wrapper .content .name {
  margin-left: 6px;
  font-size: 16px;
  line-height: 18px;
  font-weight: bold;
  vertical-align: top;
}

.icon{
  display: inline-block;
  width: 12px;
  height: 12px;
  background-size: 12px 12px;
  background-repeat: no-repeat;
  margin-right: 2px;
  vertical-align: top;
}

.support-text{
  font-size: 12px;
  vertical-align: top;
}

.icon_0 {
  background-size: 12px 12px;
  background-image: url("./decrease_1@2x.png");
}

.icon_1 {
  background-size: 12px 12px;
  background-image: url("./discount_1@2x.png");
}

.icon_2 {
  background-size: 12px 12px;
  background-image: url("./guarantee_1@2x.png");
}

.icon_3 {
  background-size: 12px 12px;
  background-image: url("./invoice_1@2x.png");
}

.icon_4 {
  background-size: 12px 12px;
  background-image: url("./special_1@2x.png");
}

.header .content-wrapper .content .content-support .support-count {
  position: absolute;
  right: 12px;
  top: 70px;
  padding: 0px 8px;
  height: 24px;
  line-height: 24px;
  border-radius: 14px;
  background-color: rgba(0, 0, 0, 0.2);
}

.header .content-wrapper .content .content-support .support-count span{
  font-size: 10px;
  width: 30px;
  vertical-align: top;
}

.header .content-wrapper .content .content-support .support-count a{
  font-size: 5px;
  vertical-align: top;

  color: rgba(255, 255, 255, 0.4)
}

.header .bulletin-wrapper{
  background-color: rgba(7, 17, 27, 0.2);
  height: 28px;
  line-height: 28px;
}

.bulletin-wrapper .bulletin-icon{
  float: left;
  width: 30px;
  height: 15px;
  margin-left: 12px;
  margin-top: 7px;
  vertical-align: top;
  background-size: 30px 15px;
  background-image: url("./bulletin@2x.png");
}

.bulletin-wrapper .bulletin-content{
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  vertical-align: top;
  padding-left: 10px;
  font-weight: 200;
  line-height: 28px;
  font-size: 13px;
  margin-right: 20px;
}

.header .detail{
  position: fixed;
  top: 0px;
  left: 0px;
  z-index: 100;
  height: 100%;
  width: 100%;
  overflow: auto;
  transition: all .3s;
  background-color: rgba(7, 17, 28, 0.9);
}

.header .detail .detail-wrapper{
  min-height: 100%;
  min-width: 100%;
}

.header .detail .detail-wrapper .detail-main{
  margin-top: 64px;
  padding-bottom: 64px;
}

.header .detail .detail-close{
  position: relative;
  width: 32px;
  height: 32px;
  margin: -64px auto 0 auto;
  clear: both;
  font-size:32px;
}

.detail-main-title{
  line-height: 20px;
  font-size:20px;
  font-weight: 700;
  text-align: center;
}

.detail-star{
  margin-top: 16px;
}

.activity-header{
  display: flex;
  width: 80%;
  margin-top: 28px;
  margin-bottom: 24px;
  margin-left: auto;
  margin-right: auto;
  text-align: center;
}

.line{
  flex: 1px;
  position: relative;
  top: -6px;
  border-bottom: rgba(255, 255, 255, 0.3) solid 1px
}

.acitvity-header-text{
  padding: 0px 12px 0px 12px;
  font-weight: 600;
  font-size: 16px;
}

.detail-supports{
  width: 60%;
  margin:0 auto;
}

.detail-supports-item{
  font-size: 15px;
  line-height: 15px;
  margin-top: 10px;
}

.detail-bulletin{
  width: 80%;
  margin:0 auto;
  font-size: 14px;
  line-height: 25px;
}

.detail-fade-enter-active, .detail-fade-leave-active {
  background-color: rgba(7, 17, 28, 0.8);
}

.detail-fade-enter, .detail-fade-leave {
  opacity: 0;
  background-color: rgba(7, 17, 28, 0);
}

</style>
