<template>
 <div id="app">
   <router-view ></router-view>
 </div>
</template>

<script>
// import {getStore} from './extend/storge'
import {mapMutations,mapState} from "vuex"
import { getUser } from './api';

export default {
  name: 'app',
  methods:{
    ...mapMutations([
      'setUserInfo'
    ])
  },
  mounted(){
    // let userinfo = getStore('userinfo');
    // this.$store.dispath('fetchUserInfo')
    getUser().then(
      res =>{
        this.setUserInfo(res.data.data)
      }
    )
    // if(userinfo){
    //   
    // }
  },
   computed: {
    ...mapState({
        userInfo:state => state.user.userInfo,
    })
  },

}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
</style>
