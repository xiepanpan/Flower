<!--
 * @Author: your name
 * @Date: 2020-03-25 13:31:04
 * @LastEditTime: 2020-03-25 13:31:05
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: /flower/client/src/views/user.vue
 -->
 <template>
  <section id="home">
    <el-container>
      <el-header>
        <NavBar>花店</NavBar>
      </el-header>
      <el-main class="main">
        <flowerUl kind="flowerHot">热卖商品</flowerUl>
        <flowerUl kind="flower">花品</flowerUl>
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
      collectflowers: null
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

  }
};
</script>
 
<style lang="stylus" scoped>
.main {
  margin-top 2vw
}


</style>