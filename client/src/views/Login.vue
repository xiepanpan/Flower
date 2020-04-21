<template>
  <section id="Login" >
    <h2>登录注册</h2>
    <el-form ref="loginForm" :model="loginForm" :rules="rules">
      <el-form-item class="form-item-tel" prop="name">
        <el-input v-model="loginForm.name" maxlength="11" placeholder="用户名" size="large"></el-input>
      </el-form-item>

      <el-form-item class="form-item-pas" prop="pas">
        <el-input type="password"  v-model="loginForm.pas" placeholder="密码" size="large"></el-input>
      </el-form-item>
      <el-form-item class="form-item-mess" prop="mess">
        <el-input v-model="loginForm.mess" placeholder="验证码" size="large">
          <template slot="suffix" type="text" style="width:200px">{{loginForm.captcha}}</template>
          <el-button
            slot="append"
            type="text"
            :disabled="buttonIsDisabled"
            @click="getTheUrlBa64"
            style="width:100px;"
          >{{butIsConTxt}}</el-button>
        </el-input>
      </el-form-item>
<!--     <p style="color:red">没有帐号默认注册</p>-->
        <el-form-item>
            <el-button type="success" @click="login('loginForm')">登录</el-button>

            <el-button @click="resetForm('loginForm')">重置</el-button>
        </el-form-item>
        <router-link to="register">没有密码？注册</router-link>
<!--      <el-button type="success" @click="login('loginForm')">登录</el-button>-->
    </el-form>
  </section>
</template>

<script>
import { getCaptcha } from "./../api/index";
import { Message } from "element-ui";

export default {
  name: "Login",
  data() {
    return {
      loginForm: {
        name: "",
        pas: "",
        mess: "",
        captcha: ""
      },
      rules: {
        name: [
          { required: true, message: "请输入用户名名称", trigger: "blur" }
          // { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        ],
        pas: [{ required: true, message: "请输入密码", trigger: "blur" }],
        mess: [{ required: true, message: "请输入验证码", trigger: "blur" }]
      },

      butConTxt: "获取验证码",
      isBuShow: false
    };
  },
  computed: {
    buttonIsDisabled() {
      let butShow = this.isBuShow;
      console.log(butShow);
      if (this.butConTxt == 0) {
        butShow = false;
      }
      return butShow;
    },

    //验证码内的文本
    butIsConTxt() {
      let contxt = this.butConTxt;
      if (contxt == 0) {
        contxt = "获取验证码";
      }
      return contxt;
    }
  },
  created() {
    this.getTheUrlBa64();
  },
  methods: {
    getTheUrlBa64() {
      getCaptcha().then(response => {
        console.log(response, response.data.text);
        // console.log(response.data.code, this.loginForm.captcha);
        //判断是否第一次加载验证码
        if (response.status == 200) {
          this.isBuShow = true;
          this.butConTxt = 6;
          this.countDown();
        }
        //在给验证码赋值
        this.loginForm.captcha = response.data.data.text;
      });
    },
    countDown() {
      //验证码倒计时
      // console.log(typeof this.butConTxt, this.butConTxt);
      if (typeof this.butConTxt == "number") {
        for (let i = 0; i <= 5; i++) {
          setTimeout(
            s => {
              // console.log(s.butConTxt);
              s.butConTxt--;
            },
            1000 * i,
            this
          );
        }
      }
      // this.butConTxt = "获取验证码"
    },
      //重置表单
      resetForm(formName) {
          this.$refs[formName].resetFields();
      },

    login(formName) {
      // console.log(this.$store)
      this.$refs[formName].validate(valid => {
        if (valid) {
          this.$store
            .dispatch("fetchLogin", {
              username: this.loginForm.name,
              password: this.loginForm.pas,
              captcha: this.loginForm.mess
            })
            .then(res => {
              let data = res.data;

              switch (data.code) {
                case 500:
                  Message({
                    message: data.msg,
                    type: "error",
                    duration: "800"
                  });
                  break;
                // case 501:
                //   resUser(this.loginForm.name, this.loginForm.pas).then(res => {
                //     if (res.data.code == 200) {
                //       this.$store.dispatch("fetchUserInfo");
                //       Message({
                //         msg: res.data.msg,
                //         type: "success",
                //         duration: 800,
                //         onClose: () => {
                //           if (res.data.data.role == 1) {
                //             this.$router.push("/");
                //           } else {
                //             this.$router.push("/admini");
                //           }
                //         }
                //       });
                //     }
                //   });
                //   break;
                default:
                  Message({
                    message: data.msg,
                    type: "success",
                    duration: "800",
                    onClose: () => {
                      if (res.data.data.role == 1) {
                        this.$router.push("/");
                      } else {
                        this.$router.push("/admini");
                      }
                    }
                  });
                  break;
              }
            });
        } else {
          return false;
        }
      });
    }
  },
    // components: {
    //     register
    // }
};
</script>

<style lang="stylus" scoped>
#Login {
  display: flex;
  flex-direction column
  width: 100vw;
  height: 100vh;
  justify-content: center;
  align-items: center;
  background-image: url("../assets/bg.jpg");
  background-repeat:no-repeat
  background-size cover
  .el-form {
    width: 30vw;

    .el-input {
      margin: 1vw 0;
    }
  }
}
</style>