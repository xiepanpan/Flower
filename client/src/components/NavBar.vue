<template>
  <nav>
    <el-row type="flex">
      <el-col :span="20">
        <h2>
          <slot></slot>
        </h2>
      </el-col>
      <el-col :span="4">
        <el-button v-if="!isLogin" @click="login">登录/注册</el-button>
        <el-dropdown v-if="isLogin" @command="handleCommand">
          <el-avatar :src="imageUrl()"></el-avatar>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="/info">
              <!-- <el-button> -->
              个人信息
              <!-- </el-button>  -->
            </el-dropdown-item>
            <el-dropdown-item
            v-if='!isAdmini' command="collect">收藏夹</el-dropdown-item>
            <el-dropdown-item command="order" v-if='!isAdmini' >订单信息</el-dropdown-item>
            <el-dropdown-item command="out" >退出</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>
      </el-col>
    </el-row>
  </nav>
</template>

<script>
import { mapGetters } from "vuex";
import { getImageUrl } from "./../api/bashUrl";
import { rmStore } from "./../extend/storge";
import { logOut } from "../api";
import { Message } from "element-ui";
// import { getCollectedflowers } from "./../api/index";
export default {
  name: "NavBar",
  data() {
    return {};
  },
  methods: {
    login() {
      this.$router.push("/login");
    },
    imageUrl() {
      return getImageUrl(this.$store.state.user.userInfo.head_image);
    },
    handleCommand(command) {
      switch (command) {
        case "/info":
          this.$router.push("/info");
          break;
        case "out":
          logOut().then(res => {
            this.$store.commit("setUserInfo", null);
            rmStore("userinfo");
            Message({
              message: res.data.msg,
              type: "success"
            });
          });
          break;
        case "collect":
          this.$router.push("/collect");
          break;
        case "order":
          this.$router.push("/order");
      }
    }
  },
  computed: {
    ...mapGetters(["isLogin",'isAdmini'])
  }
};
</script>

<style lang="stylus" scoped>
nav {
  height: 20vw;

  .el-row {
    padding: 1vw 0;
  }
}
</style>