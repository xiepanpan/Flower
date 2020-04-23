<!--
 * @Author: your name
 * @Date: 2020-03-25 13:31:04
 * @LastEditTime: 2020-03-25 13:31:05
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flower/client/src/views/user.vue
 -->
 <template>
     <div>

         <section id="home">
             <el-container>
                 <el-header>
                     <NavBar>花店</NavBar>
                 </el-header>
                 <el-main class="main">
                     <div class="slide" v-on:mouseover="stop()" v-on:mouseout="move()">
                         <div class="slideshow">
                             <transition-group tag="ul" name="image">
                                 <li v-for="(img, index) in imgArray" v-show="index===mark" :key="index">
                                     <a href="#">
                                         <img :src='img'>
                                     </a>
                                 </li>
                             </transition-group>
                         </div>
                         <div class="bullet">
      <span v-for="(item, index) in imgArray" :class="{ 'active':index===mark }"
            @click="change(index)" :key="index"></span>
                         </div>
                     </div>
                     <flowerUl kind="flowerHot">热卖商品</flowerUl>
                     <flowerUl kind="flower">所有品种</flowerUl>
                     <!--        <flowerUl kind="flowerDiscount">打折鲜花</flowerUl>-->
                 </el-main>
             </el-container>
             <el-dialog title="商品评论" :visible="dialogTableVisible" @close="headerClose('setflowerDetail')" >
                 <flowerComments/>
             </el-dialog>
             <el-drawer
                     :title="isShowDraw=='collect'?'收藏夹':'订单'"
                     :visible.sync="isShowDraw"
                     direction="rtl"
                     size="50%"
                     @close="headerClose('setIsShowDraw')"
                     :destroy-on-close="true"
             >
                 <!-- @open='getColflowers' -->
                 <Collect v-if="isShowDraw=='collect'" />
                 <OrderMu v-if="isShowDraw=='order'"/>
             </el-drawer>
         </section>
     </div>



</template>
 
 <script>
import NavBar from "@/components/NavBar.vue";
import flowerUl from "./../components/flowerUl";
import flowerComments from "./../components/flowerComments";
import OrderMu from "./../components/Order";

import  Collect from "./../components/Collect";
import {mapState} from 'vuex'
import {  deletCollectedflower } from "./../api/index";
import { getImageUrl } from "./../api/bashUrl";
import { Message } from 'element-ui';

export default {
  name: "Home",
  components: {
    NavBar,
    flowerUl,
    flowerComments,
    Collect,
    OrderMu
    // OrderButt
  },
  data(){
    return {
        collectflowers: null,
        imgArray: [
            '../banner/timg1.jpg',
            '../banner/timg2.jpg',
            '../banner/timg3.jpg',
            '../banner/timg4.jpg'
        ],
        timer: null, //定时器
        mark: 0, //比对图片索引的变量


    }
  },
 
  computed:{
    ...mapState({
      flowerDetail: state => state.user.flowerDetail,
      isShowDraw: state => state.user.isShowDraw,
      // drawVisible: state => state.user.drawVisible
    }),
    dialogTableVisible(){
      if(this.flowerDetail){
         return true
      }else {
         return false
      }
    }
  },
  methods:{
    headerClose(commit){
      this.$store.commit(commit,null)
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
      autoPlay () {
          this.mark++;
          if (this.mark === 4) {
              this.mark = 0
          }
      },
      play () {
          this.timer = setInterval(this.autoPlay, 2500)
      },
      change (i) {
          this.mark = i
      },
      stop () {
          clearInterval(this.timer)
      },
      move () {
          this.timer = setInterval(this.autoPlay, 2500)
      }
  },
    created () {
        this.play()
    }
};
</script>
 
<style lang="stylus" scoped>
.main {
  margin-top 2vw
}
* {
    margin: 0;
    padding: 0;
    list-style: none;
}
.slide {
    width: 1024px;
    height: 320px;
    margin: 0 auto;
    margin-top: 50px;
    overflow: hidden;
    position: relative;
}
.slideshow {
    width: 1024px;
    height: 320px;
}
li {
    position: absolute;
}
img {
    width: 1024px;
    height: 320px;
}
.bar {
    position: absolute;
    width: 100%;
    bottom: 10px;
    margin: 0 auto;
    z-index: 10;
    text-align: center;
}
.bar span {
    width: 20px;
    height: 5px;
    border: 1px solid;
    background: white;
    display: inline-block;
    margin-right: 10px;
}
.active {
    background: red !important;
}
.image-enter-active {
    transform: translateX(0);
    transition: all 1.5s ease;
}
.image-leave-active {
    transform: translateX(-100%);
    transition: all 1.5s ease;
}
.image-enter {
    transform: translateX(100%);
}
.image-leave {
    transform: translateX(0);
}
</style>