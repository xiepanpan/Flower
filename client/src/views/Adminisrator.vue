<template>
  <section id="adminis">
    <el-container>
      <el-header>
        <NavBar>花店管理员</NavBar>
      </el-header>
      <el-container>
      <el-aside width="200px">
        <el-menu :router='true' default-active="">
          <el-menu-item 		 index="/admini" >
            <span slot="title">管理订单</span>
          </el-menu-item>
          <el-menu-item index="/admini/flowertype">
            <span slot="title">增添品种</span>
          </el-menu-item>
          <el-menu-item index="/admini/flower">
            <span slot="title">增添鲜花</span>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main>
           <router-view ></router-view>
      </el-main>
      </el-container>
    </el-container>
  </section>
</template>

<script>
import NavBar from "./../components/NavBar";
export default {
  name: "Admini",
  components: {
    NavBar
  }
};
</script>

<style>
</style>