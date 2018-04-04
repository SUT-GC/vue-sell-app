<template>
  <div class="star" :class="starType">
      <span v-for="item in itemClass" class="star-item" :key="item.id" :class="item + '-star'">
      </span>
  </div>
</template>

<script>
const STAR_NUMBER = 5
const STAR_ON = 'on'
const STAR_OFF = 'off'
const STAR_HALF = 'half'

export default {
  props: {
    size: {
      type: Number,
      required: true,
      default: 24
    },
    score: {
      type: Number,
      required: true,
      default: 0
    }
  },
  computed: {
    starType () {
      return 'star-' + this.size
    },
    itemClass () {
      var result = []
      var score = Math.floor(this.score * 2) / 2
      var hasDecimal = score % 1 !== 0
      var intNum = Math.floor(score)
      for (let i = 0; i < intNum; i++) {
        result.push(STAR_ON)
      }

      if (hasDecimal) {
        result.push(STAR_HALF)
      }

      if (result.length < STAR_NUMBER) {
        for (let i = intNum; i < STAR_NUMBER; i++) {
          result.push(STAR_OFF)
        }
      }

      return result
    }
  }
}
</script>

<style>
.star{
    text-align: center;
}

.star-item{
    display: inline-block;
    background-repeat: no-repeat;
}

.star-24 .star-item{
    width:10px;
    height:10px;
    margin-right:3px;
    background-size:10px;
}

.star-24 .half-star{
    background-image: url("./star24_half@2x.png");
}

.star-24 .on-star{
    background-image: url("./star24_on@2x.png");
}

.star-24 .off-star{
    background-image: url("./star24_off@2x.png");
}

.star-36 .star-item{
    width:15px;
    height:15px;
    margin-right:6px;
    background-size:15px;
}

.star-36 .half-star{
    background-image: url("./star36_half@2x.png");
}

.star-36 .on-star{
    background-image: url("./star36_on@2x.png");
}

.star-36 .off-star{
    background-image: url("./star36_off@2x.png");
}

.star-48 .star-item{
    width:20px;
    height:20px;
    margin-right:22px;
    background-size:20px;
}

.star-48 .half-star{
    background-image: url("./star48_half@2x.png");
}

.star-48 .on-star{
    background-image: url("./star48_on@2x.png");
}

.star-48 .off-star{
    background-image: url("./star48_off@2x.png");
}

</style>
