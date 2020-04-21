<template>
  <section class="flower-ul">
    <h3>
       <slot></slot>
    </h3>
    <el-row type="flex" justify="space-around" :gutter='20'>
          <el-col :span="6" v-for="(flower,o) in this.flowers" :key="o">
            <flowerList :flower="flower" />
          </el-col>
    </el-row>
    <!-- <flowerList/> -->

  </section>
</template>

<script>
import flowerList from './flowerList'
import {getflower}  from './../api'
export default {
  components:{
    flowerList
  },
  name: 'flowerul',
  data(){
    return {
      flowers:null
    }
  },
  props: [
    'kind'
  ],
  created(){
    getflower(this.kind).then(
      (res)=> {
        this.flowers = res.data.data
      }
    )
  },
  methods: {
    openDialog(){
      console.log(123)
    }
  }
}
</script>

<style lang="stylus" scoped>
  .flower-ul{
    margin 2vw 0
  }

  h3 {
    padding 1vw 0
  }
</style>