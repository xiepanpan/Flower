import {login, getflowerDetail,getUser} from './../api'
import {setStore}  from './../extend/storge'

const state = {
    userInfo:null,
    flowerDetail:null,
    isShowDraw:null,
    // drawVisible:null
}

const getters = {
    isLogin : (state) => {
        if(state.userInfo) {
            return true
        }
    },
    isAdmini: (state) =>{
        if(state.userInfo.role){
            return false
        }else {
            return true
        }
    }
}

const mutations = {
    setUserInfo(state,info){
        if(typeof info == 'string'){
            state.userInfo = JSON.parse(info);
            // console.log(state.userInfo)
        }else{
            state.userInfo = info
        }
        setStore('userinfo',state.userInfo);
    },
    setflowerDetail(state,data){
        console.log(data)
        state.flowerDetail = data
    },
    setIsShowDraw(state,data){
        state.isShowDraw = data
    }
}

const actions = {
    fetchLogin({
        commit
    },Payload){
        return login(Payload).then(
            res => {
                if(res.data.code == 200)
                    getUser().then(ress=>{
                        commit('setUserInfo',ress.data.data)
                    })
                return res
            }
        )
    },
    fetchDetail({commit},Payload){
        return getflowerDetail(Payload).then(res=>{
            commit('setflowerDetail',res.data.data)
            return res
        })
    },
    fetchUserInfo({commit}){
        getUser().then(
            res => {
                if(res.data.code == 200){
                    commit('setUserInfo',res.data.data)
                }
                return res
            }
        )
    }
}

export default {
    state,
    mutations,
    actions,
    getters
}