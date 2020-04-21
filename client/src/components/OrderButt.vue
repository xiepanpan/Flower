<template>
  <section>
    <el-button icon="el-icon-s-goods
" circle @click="orderflower(flowerId)">
    </el-button>
  </section>
</template>

<script>
import { flowerBuy} from "./../api/index";
import { Message } from 'element-ui';
export default {
  
  name: 'OrderButt',
  props: ["flowerId"],
  methods:{
    orderflower(id){
      flowerBuy(id).then(res=>{
        if(res.data.code == 200){
          Message({
            message:res.data.msg,
            type: 'success',
            duration: '800'
          })
        }else{
          Message({
            message:res.data.msg,
            type:'error',
            duration:'800'
          })
        }
      })
    }
  }

}
</script>

<style>

</style>