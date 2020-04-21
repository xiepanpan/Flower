<template>
  <section class="flower-comments">
    <flowerList :flower="flowerDetail"/>
    <el-row type="flex" justify="space-around" :gutter="20"
    v-for="(com,o) in comments"
    :key="o"
    class="commentList"
    align="middle"
    >
      <el-col :span="6">
        <el-avatar size="medium" :src='imageUrl(com.head_image)'></el-avatar>
        <p>{{com.name}}</p>
      </el-col>
      <el-col :span="18" class="comment">
        
        <el-row type="flex" justify="space-between"
        align="middle"
        >
          <el-col :span='6'>{{com.comment_desc}}</el-col>
          <el-col :span='8'><el-rate disabled :value="com.star"></el-rate></el-col>
          <el-col :span="10">{{com.creat_time}}</el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-row type='flex' v-if="islogin">
        <el-rate v-model="star"></el-rate>
        <el-input placeholder="请输入你的评论" v-model="comment_desc">
  </el-input>
    <el-button type="primary" @click="pubComment()">提交</el-button>      
    </el-row>
  </section>
</template>

<script>
import { getflowerComments,inserComments } from "./../api/index";
import flowerList from "./flowerList";
import { getImageUrl } from "./../api/bashUrl";
export default {
  name: "flowerComments",
  components:{
    flowerList
  },
  data() {
    return {
      comments: null,
      flowerId:null,
      comment_desc:null,
      star:0,
      flowerDetail:null
    };
  },
  computed:{
    islogin(){
      return this.$store.state.user.userInfo
    }
  },
  mounted() {
     this.flowerDetail = this.$store.state.user.flowerDetail;
    if(this.flowerDetail){
      getflowerComments(this.flowerDetail.flower_id).then(res => {
      this.comments = res.data.data;
    });
    } 
  },
  methods:{
    imageUrl(url){
      return getImageUrl(url)
    },
    pubComment(){
      inserComments(this.star,this.comment_desc,this.flowerDetail.flower_id).then(
        () => {
            // this.$store.commit('setflowerDetail',null)
            this.getComment()
            this.comment_desc = ''
            this.star = 0
        }
      )
    },
    getComment(){
      this.flowerDetail = this.$store.state.user.flowerDetail;
    if(this.flowerDetail){
      getflowerComments(this.flowerDetail.flower_id).then(res => {
      this.comments = res.data.data;
    });
    } 
    }
  }
};
</script>

<style lang="stylus" scoped>
  .commentList
    padding 10px 0 
</style>