<template>
  <section>
    <section>
      <el-row type="flex" align="middle" v-for="flower in collectflowers" :key="flower.collect_id">
        <el-col :span="4">
          <el-image hstyle="width: 50px; height: 50px" :src="reImageUrl(flower.flower_image)"></el-image>
        </el-col>
        <el-col :span="4">{{flower.flower_name}}</el-col>
        <el-col :span="4">{{flower.price}}</el-col>
        <el-col :span="8">收藏时间{{flower.creat_date}}</el-col>
        <el-col :span="2">
          <OrderButt :flowerId="flower.flower_id" />
        </el-col>
        <el-col :span="2">
          <el-button
            type="danger"
            icon="el-icon-delete"
            circle
            @click="deletColect(flower.collect_id)"
          ></el-button>
        </el-col>
      </el-row>
    </section>
  </section>
</template>

<script>
import { getCollectedflowers } from "./../api/index";
import { Message } from 'element-ui';
import {  deletCollectedflower } from "./../api/index";
import { getImageUrl } from "./../api/bashUrl";

import OrderButt from "./OrderButt";

export default {
  name:'Collect',
  components:{
    OrderButt
  },
  data(){
    return {
      collectflowers:null
    }
  },
  mounted(){
    this.getColflowers()
  },
  methods: {
    getColflowers() {
      getCollectedflowers().then(res => {
        this.collectflowers = res.data.data;
      });
    },
    deletColect(id){
      deletCollectedflower(id).then(res=>{
        if(res.data.code == 200){
          Message({
            message: res.data.msg,
            type: 'success',
            duration: '800',
            onClose: ()=>{
              this.getColflowers()
            }
          })
        }
      })
    },
    reImageUrl(url){
      return getImageUrl(url)
    },
  }
};
</script>

<style>
</style>