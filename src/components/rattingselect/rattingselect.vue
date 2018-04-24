<template>
  <div class="ratingselect">
      <div class="rating-type">
          <span class="block" :class="{active: selectType === 2}" @click="select(2)">{{desc.all}} ({{ratings.length}})</span>
          <span class="block" :class="{active: selectType === 0}" @click="select(0)">{{desc.positive}} ({{positiveRatings.length}})</span>
          <span class="block" :class="{active: selectType === 1}" @click="select(1)">{{desc.negative}} ({{negativeRatings.length}})</span>
      </div>
      <div class="switch-type" :class="{onlyContent: onlyContent}" @click="switchOnlyContent">
          <span class="icon-check_circle"></span>
          <span>只看有内容的评价</span>
      </div>
  </div>
</template>
<script>
const POSITIVE = 0
const NGEATIVE = 1
const ALL = 2

export default {
  props: {
    ratings: {
      type: Array,
      default () {
        return []
      }
    },
    selectType: {
      type: Number,
      default () {
        return ALL
      }
    },
    onlyContent: {
      type: Boolean,
      default () {
        return false
      }
    },
    desc: {
      type: Object,
      default () {
        return {
          all: '全部',
          positive: '满意',
          negative: '不满意'
        }
      }
    }
  },
  methods: {
    switchOnlyContent () {
      this.$emit('switchOnlyContent', !this.onlyContent)
    },
    select (type) {
      this.$emit('switchSelectType', type)
    }
  },
  computed: {
    positiveRatings () {
      var result = []
      this.ratings.forEach(element => {
        if (element && element.rateType === POSITIVE) {
          result.push(element)
        }
      })

      return result
    },
    negativeRatings () {
      var result = []
      this.ratings.forEach(element => {
        if (element && element.rateType === NGEATIVE) {
          result.push(element)
        }
      })

      return result
    }
  }
}
</script>
<style>
.rating-type {
    margin-top: 12px;
    margin-bottom: 18px;
}

.rating-type span {
    display: inline-block;
    margin-right: 8px;
    padding: 8px 12px;
    border-radius: 2px;
    font-size: 8px;
    font-weight: 200;
    text-align: center;
    background-color: rgba(7, 85, 93, 0.2);
    color: rgba(7, 17, 27, 0.2)
}

.rating-type .active {
    background-color: rgb(0, 160, 220);
    color: #fff;
}

.switch-type {
    padding-top: 12px;
    font-size: 12px;
    line-height: 24px;
}

.icon-check_circle {
    font-size: 14px;
}

.switch-type span {
    color: rgb(147, 153, 159)
}

.onlyContent span{
    color: rgb(0, 160, 220);
}
</style>
