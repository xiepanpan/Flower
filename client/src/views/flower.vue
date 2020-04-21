<template>
  <section>
    <el-table :data="tableData">
      <el-table-column label="图片">
        <template slot-scope="scope">
          <el-image :src="reImageUrl(scope.row.flower_image)"></el-image>
        </template>
      </el-table-column>
      <el-table-column label="品种" prop="type_name">
        
      </el-table-column>
      <el-table-column label="花名" prop="name"></el-table-column>
      <el-table-column label="价格" prop="price"></el-table-column>
      <el-table-column label="折扣" prop="discount"></el-table-column>
      <el-table-column align="right">
        <template slot="header">
          <el-button type="success" @click="showDialog= true">添加品种</el-button>
        </template>
        <template slot-scope="scope">
          <el-button type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
          <el-button type="success" @click="handleUpdata(scope.$index, scope.row)">更新</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-dialog title="添加鲜花" :visible.sync="showDialog">
      <el-input placeholder="请输入新增鲜花" v-model="name"></el-input>
      <el-input placeholder="请输入价格" v-model="price"></el-input>
      <el-input placeholder="折扣（0-100，如10就是1折）" v-model="discount"></el-input>
      <el-select v-model="typeId" placeholder="请选择品种">
        <el-option
          v-for="item in flowerTypes"
          :key="item.flower_type_id"
          :label="item.name"
          :value="item.flower_type_id"
        ></el-option>
      </el-select>
      <input type="file" accept="image/*" @change="getFile($event)" name="image" />
      <el-button type="primary" @click="add">提交</el-button>
    </el-dialog>
    <el-dialog title="更新品种" :visible.sync="upDialog">
      <el-input   v-model="flowerData.name">
            <template slot="prepend">更新品种</template>

      </el-input>
      <el-input placeholder="请输入价格" v-model="flowerData.price">
            <template slot="prepend">更新价格</template>

      </el-input>
      <el-input placeholder="折扣（0-100，如10就是1折）" v-model="flowerData.discount">
            <template slot="prepend">更新折扣</template>

      </el-input>

      <input type="file" accept="image/*" @change="getFile($event)" name="image" />
      <el-button type="primary" @click="updata">提交</el-button>
    </el-dialog>
  </section>
</template>

<script>
import { findAllflower, delflower, findflowerType, addflower, updataflower } from "../api";
import { Message } from "element-ui";
import { getImageUrl } from '../api/bashUrl';
export default {
  name: "flower",
  data() {
    return {
      tableData: null,
      showDialog: false,
      formDa: new FormData(),
      name: null,
      flowerTypes: null,
      price: null,
      discount: null,
      typeId: null,
      flowerData:{
        image:null,
        name:null,
        price:null,
        discount:null,
        flower_id:null
      },
      upDialog:false
      
    };
  },
  methods: {
    getflower() {
      findAllflower().then(res => {
        console.log(res);
        this.tableData = res.data.data;
      });
    },
    reImageUrl(url) {
      return getImageUrl(url);
    },
    handleDelete(index, row) {
      delflower(row.flower_id).then(res => {
        if (res.data.code == 200) {
          this.getflower();
          Message({
            message: res.data.msg,
            type: "success",
            duration: 800
          });
        }
      });
    },
    getFile(event) {
      // console.log(event);
              let formData = this.formDa;

      if (event) {
        formData.append("image", event.target.files[0]);
        // console.log(formData)
      }
      this.formDa = formData;
    },
    add() {
      let formData = this.formDa;
      formData.append("name", this.name);
      formData.append("price", this.price);
      formData.append("discount", this.discount);
      formData.append("flower_type_id", this.typeId);
      addflower(formData).then(res =>{
        if(res.data.code == 200) {
          this.getflower()
          Message({
            message:res.data.msg,
            type:'success',
            duration: 800
          })
        }
        this.formDa = new FormData()
      })
    },
    handleUpdata(index,row){
      console.log(index,row)
      this.flowerData = row
      this.upDialog = true
    },
    updata(){
       let formData = this.formDa
       formData.append("name", this.flowerData.name);
      formData.append("price", this.flowerData.price);
      formData.append("discount", this.flowerData.discount);
      formData.append("flower_id", this.flowerData.flower_id);
      updataflower(formData).then(res =>{
        if(res.data.code == 200) {
          this.getflower()
          Message({
            message:res.data.msg,
            type:'success',
            duration: 800
          })
        }
        this.formDa = new FormData()
      })
    }
  },
  mounted() {
    this.formDa.append('image',null)
    this.getflower();
    findflowerType().then(res => {
      this.flowerTypes = res.data.data;
    });
  }
};
</script>

<style>
.el-image{
  height: 50px;
  width: 50px;
}
</style>