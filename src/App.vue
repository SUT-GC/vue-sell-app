<template>
  <div id="app">
    <sell-header/>
    <sell-tab/>
  </div>
</template>

<script>

import sellHeader from './components/header/header'
import sellTab from './components/tab/tab'

export default {
  name: 'App',
  components: {
    sellHeader,
    sellTab
  }
}
</script>

<style>
</style>
