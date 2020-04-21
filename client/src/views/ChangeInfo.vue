<template>
  <section class="info">
    <h2>个人信息</h2>
    <el-row type="flex">
      <el-col :span="12" class="info">
        <div>
          <el-avatar :src="getUrl()"></el-avatar>
          <h3>名称：{{userinfo.name}}</h3>
        </div>
        <h3>地址：{{userinfo.address}}</h3>
        <h3>电话：{{userinfo.phone}}</h3>
        <h3>角色：{{userinfo.role?'买家':'商家'}}</h3>
      </el-col>
      <el-col :span="12">
        <el-row type="flex" justify="center" align="middle" style="height:40vw">
          <el-col>
            <h3>修改信息</h3>
            <el-form
              :label-position="labelPosition"
              label-width="80px"
              
            >
              <el-form-item label="名称" >
                <el-input v-model="changeinfo.name" :placeholder="userinfo.name">
                </el-input>
              </el-form-item>
              <el-form-item label="电话" >
                <el-input v-model="changeinfo.phone" :placeholder="userinfo.phone"></el-input>
              </el-form-item>
              <el-form-item label="地址" >
                <el-input v-model="changeinfo.address" :placeholder="userinfo.address"></el-input>
              </el-form-item>
              <el-form-item label="上传头像">
                <input
                  id="categoryPic"
                  accept="image/*"
                  type="file"
                  name="image"
                  @change="getFile($event)"
                />
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="updateUserInfo">提交信息</el-button>
              </el-form-item>
            </el-form>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
  </section>
</template>

<script>
import { updateUser, getUser } from "./../api/index";
import { mapState } from "vuex";
import { Message } from "element-ui";
import { getImageUrl } from "./../api/bashUrl";
export default {
  name: "ChangeInfo",
  data() {
    return {
      labelPosition: "right",
      // formLabelAlign:null,
      formDa: new FormData(),
      // userinfo:null,
      changeinfo:null
    };
  },
  methods: {
    getFile(event) {
      console.log(event);
      if (event) {
        let formData = this.formDa;
        formData.append("file", event.target.files[0]);
        this.formDa = formData;
      }
    },
    updateUserInfo() {
          let formData = this.formDa;
          formData.append("phone", this.changeinfo.phone);
          formData.append("address", this.changeinfo.address);
          formData.append("name", this.changeinfo.name);
          updateUser(formData).then(res => {
            if (res.data.code == 200) {
                Message({
                message: res.data.msg,
                type: "success",
                duration: 800,
                onClose:()=> {
                  this.$router.go(0)
                }
              });
              
              
              // this.formDa = new FormData();
              // this.initFor()
            }
          });
    },
    getUrl() {
      return getImageUrl(this.userinfo.head_image);
    },
    //初始化表单

  },
  computed: {
    ...mapState({
      userinfo: state => state.user.userInfo
    })
  },
  mounted(){
    // this.$store.dispatch("fetchUserInfo")
    this.formDa.append('file',null)
    getUser().then(
      res=>{
        this.changeinfo = res.data.data 
      }
    )
    // this.initFor()
  }
};
</script>

<style lang="stylus" scoped>
  
.info, h3 {
  margin: 1vw 0;
}
</style>