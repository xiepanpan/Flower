<template>
    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
      <el-tab-pane label="已下单" name="first">
        <h3>已下单</h3>
        <el-table :data="status0"  border style="width: 100%">
          <el-table-column label="图片">
            <template slot-scope="scope">
              <el-image  :src="reImageUrl(scope.row.flower_image)"></el-image>
            </template>
          </el-table-column>
          <el-table-column v-if="add" prop="flower_name" label="花名"></el-table-column>
          <el-table-column prop="price" label="价格"></el-table-column>
          <el-table-column prop="type_name" label="品种"></el-table-column>
          <el-table-column v-if="add" prop="phone" label="电话"></el-table-column>
          <el-table-column v-if="add" prop="address" label="地址"></el-table-column>
          <el-table-column prop="name" :label="add?'用户':'花名'"></el-table-column>
          <el-table-column v-if="add" label="操作">
            <template slot-scope="scope">
              <el-button @click="receiptflower(scope.row)" type="primary">接单</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="已接单" name="second">
        <h3>已接单</h3>
        <el-table :data="status1"  border style="width: 100%">
          <el-table-column label="图片">
            <template slot-scope="scope">
              <el-image :src="reImageUrl(scope.row.flower_image)"></el-image>
            </template>
          </el-table-column>
          <el-table-column v-if="add" prop="flower_name" label="花名"></el-table-column>
          <el-table-column prop="price" label="价格"></el-table-column>
          <el-table-column prop="type_name" label="品种"></el-table-column>
          <el-table-column v-if="add" prop="phone" label="电话"></el-table-column>
          <el-table-column v-if="add" prop="address" label="地址"></el-table-column>
          <el-table-column prop="name" :label="add?'用户':'菜名'"></el-table-column>
          <el-table-column v-if="!add" label="操作">
            <template slot-scope="scope">
              <el-button @click="receiptflower(scope.row)" type="primary">{{!add?'收货':'接单'}}</el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane label="已收货" name="third">
        <h3>已收货</h3>
        <el-table :data="status2"  border style="width: 100%">
          <el-table-column label="图片">
            <template slot-scope="scope">
              <el-image :src="reImageUrl(scope.row.flower_image)"></el-image>
            </template>
          </el-table-column>
          <el-table-column v-if="add" prop="flower_name" label="花名"></el-table-column>
          <el-table-column prop="price" label="价格"></el-table-column>
          <el-table-column prop="type_name" label="品种"></el-table-column>
          <el-table-column v-if="add" prop="phone" label="电话"></el-table-column>
          <el-table-column v-if="add" prop="address" label="地址"></el-table-column>
          <el-table-column prop="name" :label="add?'用户':'花名'"></el-table-column>
        </el-table>
      </el-tab-pane>
    </el-tabs>
    <!--  <section>-->


<!--  </section>-->
</template>

<script>
import { getImageUrl } from "./../api/bashUrl";
import { flowerSold, findOrder, flowerSell } from "./../api/index";
import { Message } from "element-ui";
export default {
  name: "Ordermu",
  data() {
    return {
      status0: null,
      status1: null,
      status2: null,
      activeName: 'first'
    };
  },
  props: ["add"],
  methods: {
    handleClick(tab, event) {
      console.log(tab, event);
    },
    reImageUrl(url) {
      return getImageUrl(url);
    },
    getStatus() {
      if (this.add) {
        flowerSold(0).then(res => {
          this.status0 = res.data.data;
        });
        flowerSold(1).then(res => {
          this.status1 = res.data.data;
        });
        flowerSold(2).then(res => {
          this.status2 = res.data.data;
        });
      } else {
        findOrder(0).then(res => {
          this.status0 = res.data.data;
        });
        findOrder(1).then(res => {
          this.status1 = res.data.data;
        });
        findOrder(2).then(res => {
          this.status2 = res.data.data;
        });
      }
    },
    receiptflower(id) {
      let status = this.add ? 1 : 2
      flowerSell(status, id.buy_id).then(res => {
        if (res.data.code == 200) {
          Message({
            message: res.data.msg,
            type: "success",
            duration: 800
          });
           this.getStatus();
        }
      });
    }
  },
  created() {
    this.getStatus();
  }
};
</script>

<style>
.el-image{
  height: 50px;
  width: 100px;
}
</style>