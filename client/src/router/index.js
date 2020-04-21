import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Order from './../views/Order'
import flowerType from './../views/flowerType.vue'
import flower  from './../views/flower.vue'
Vue.use(VueRouter)

const routes = [
  {
    path:'/',
    redirect:'/home'
  },
  {
    path: '/login',
    name: 'login',
    component: Login
  },
  {
    path: '/register',
    name: 'register',
    component: () => import(/* webpackChunkName: "about" */ '../views/register.vue')
  },
  {
    path: '/home',
    name: 'Home',
    component: () => import(/* webpackChunkName: "about" */ '../views/Home.vue')
  },{
    path:'/admini',
    name: 'Admini',
    component:()=> import('./../views/Adminisrator.vue'),
    children:[
      {
        path:'',
        component: Order
      },{
        path:'flowertype',
        component:flowerType
      },{
        path:'flower',
        component: flower
      },
    ]
  },{
    path:'/info',
    name:'info',
    component: () => import('./../views/ChangeInfo.vue')
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes
})

export default router
