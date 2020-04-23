<template>
  <section class="list">
<!--    <Tag v-if="flower.discount">{{flower.discount/10}}折</Tag>-->
    <el-card :body-style="{ padding: '0px' }" shadow="hover">
      <img 
        :src="imgUrl"
        class="image"
         @click="open(flower.flower_id)"
         width="100px"
         height="100px"
      >
      <div style="padding: 14px;">
        <el-row type='flex' justify="space-around">
          <el-col :span='10'>{{flower.name}}</el-col>
          <el-col :span='10'>{{flower.type_name}}</el-col>
          
        </el-row>
        <el-divider></el-divider>
        <el-row :gutter='20'>
          <el-col :span='8'> 
            已售{{flower.sell_times}}
          </el-col>
          <el-col :span='8' class="price"
          >价格
            <s v-if="flower.now_price">{{flower.price}}</s> 
            <span>{{flower.now_price?flower.now_price:flower.price}}</span>
            
          </el-col>
          <el-col :span='8' v-if="!flower.now_price">
            <el-button icon="el-icon-shopping-cart-full" circle
            @click="colflower()"
            ></el-button>
            <OrderButt :flowerId="flower.flower_id"/>
          </el-col>
        </el-row>
<!--        <el-rate  disabled :value="flower.star">-->

<!--        </el-rate>-->
      </div>
    </el-card>
  </section>
</template>

<script>
// import Tag from './Tag'
import OrderButt from "./OrderButt";
import {imageUrl} from './../api/bashUrl'
import { collectflower } from "./../api/index";
import { Message } from 'element-ui';

export default {
  name: "flowerlist",
  components: {
    // Tag,
    OrderButt
  },
  data() {
    return {
 
    } 
  },
  props:['flower'],
  
  methods:{
    open(id){
      this.$store.dispatch('fetchDetail',id)
    },
    colflower(){
      collectflower(this.flower.flower_id).then(
        res =>{
          let data = res.data;
          if(data.code == 200){
            Message({
              type:'success',
              message: data.msg,
              duration: 800
            })
          }else{
            Message({
              type:'warning',
              message:data.msg,
              duration: 800
            })
          }
        }
      )
    }
  },
  computed:{
    imgUrl(){
      return imageUrl + this.flower.flower_image
    }
  }
};
</script>

<style>
  .list{
    position: relative;
  }
  .time {
    font-size: 13px;
    color: #999;
  }
  
  .bottom {
    margin-top: 13px;
    line-height: 12px;
  }

  .button {
    padding: 0;
    float: right;
  }

  .image {
    width: 100%;
    display: block;
  }

  .clearfix:before,
  .clearfix:after {
      display: table;
      content: "";
  }
  
  .clearfix:after {
      clear: both
  }
</style>