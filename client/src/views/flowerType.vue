<template>
  <section>
    <el-table :data="tableData">
      <el-table-column label="品种" prop="name"></el-table-column>
      <el-table-column align="right">
        <template slot="header">
          <el-button type="success" @click="showDialog= true">添加品种</el-button>
        </template>
        <template slot-scope="scope">
          <el-button type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="添加品种" :visible.sync="showDialog">
      <el-input placeholder="请输入新增品种" v-model="typeName"></el-input>
      <el-button type="primary" @click="addType">提交</el-button>
    </el-dialog>
  </section>
</template>

<script>
import { addflowerType, deleteType, findflowerType } from "./../api/index";
import { Message } from "element-ui";
export default {
  name: "flowerType",
  data() {
    return {
      tableData: null,
      showDialog: false,
      typeName: null
    };
  },
  methods: {
    handleDelete(index, row) {
      deleteType(row.flower_type_id).then(res => {
        if (res.data.code == 200) {
          findflowerType().then(res =>{this.tableData = res.data.data});
          Message({
            message: res.data.msg,
            type: "success",
            duration: 800
          });
        }
      });
    },
    addType() {
      addflowerType(this.typeName).then(res => {
        // this.showDialog == false;
        if (res.data.code == 200) {
          findflowerType().then(res => {
            this.tableData = res.data.data;
          });
          Message({
            message: res.data.msg,
            type: "success",
            duration: 800
          });
          // this.typeName == null;
        }
      });
    }
  },
  created() {
    findflowerType().then(res => {this.tableData = res.data.data});
  }
};
</script>

<style>
</style>