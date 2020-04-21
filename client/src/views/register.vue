<template>
    <section id="Login" >
        <h2>登录注册</h2>
        <el-row type="flex" justify="center">
            <el-form ref="formData" :model="formData" :rules="rules" label-width="80px" @keyup.enter.native="register()">
                <el-form-item prop="userName" label="用户名"><el-input v-model="formData.userName" placeholder="请输入用户名" prefix-icon="icon-login_user" clearable></el-input></el-form-item>
                <el-form-item prop="password" label="密码"><el-input v-model="formData.password" placeholder="请输入密码" type="password" prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
                <el-form-item prop="cheackPassword" label="确认密码"><el-input v-model="formData.cheackPassword" placeholder="再次输入密码" type="password" prefix-icon="icon-login_pwd" clearable></el-input></el-form-item>
                <el-form-item>
                    <el-button type="primary" @click="register('formData')" icon="el-icon-upload">注册</el-button>
                    <el-button @click="resetForm('formData')">重置</el-button></el-form-item>
                <router-link to="login">已有密码？登录</router-link>

            </el-form>
        </el-row>
    </section>

</template>
<script>
    import { resUser } from "./../api/index";
    import { Message } from "element-ui";
    export default {
        data() {
            var validatePass = (rule, value, callback) => {
                if (value === '') {
                    callback(new Error('请再次输入密码'));
                } else if (value !== this.formData.password) {
                    callback(new Error('两次输入密码不一致!'));
                } else {
                    callback();
                }
            };

            return {
                formData: {
                    userName: '',
                    password: '',
                    cheackPassword:''
                },
                rules: {
                    userName: [{ required: true, message: '用户名不能为空', trigger: 'blur' }],
                    password: [{ required: true, message: '密码不能为空', trigger: 'blur' }],
                    cheackPassword: [{ required: true, validator: validatePass, trigger: 'blur' }]

                }
            };
        },
        methods: {
            register(formName) {
                this.$refs[formName].validate(valid => {
                    if (valid) {
                        resUser(this.formData.userName, this.formData.password).then(res => {
                            if (res.data.code == 200) {
                                this.$store.dispatch("fetchUserInfo");
                                Message({
                                    msg: res.data.msg,
                                    type: "success",
                                    message: '注册成功',
                                    duration: 800,
                                    // onClose: () => {
                                    //     if (res.data.data.role == 1) {
                                    //         this.$router.push("/");
                                    //     } else {
                                    //         this.$router.push("/admini");
                                    //     }
                                    // }
                                });
                                this.$router.push({name:'login'});
                            }else {
                                console.log('error submit!!');
                                return false;
                            }
                        });
                        // this.$message({
                        //     type: 'success',
                        //     message: '注册成功'
                        // });
                        // this.$router.push({name:'login'});
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            resetForm(formName) {
                this.$refs[formName].resetFields();
            }

        }
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