import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'
import {Button,Form,FormItem,Input,Container,Main,Footer,Header,Row,Col,Avatar,Dropdown,DropdownItem,DropdownMenu,Card,Image,Divider,Dialog,Rate,Drawer,Menu,MenuItem,Aside,Table,TableColumn,Select,Option}  from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css';
import './mock/index'  

Vue.use(Button)
  .use(Form)
  .use(Input)
  .use(Container)
  .use(Main)
  .use(Footer)
  .use(Header)
  .use(Row)
  .use(Col)
  .use(FormItem)
  .use(Avatar)
  .use(Dropdown)
  .use(DropdownMenu)
  .use(DropdownItem)
  .use(Card)
  .use(Image)
  .use(Divider)
  .use(Dialog)
  .use(Rate)
  .use(Drawer)
  .use(Menu)
  .use(MenuItem)
  .use(Aside)
  .use(Table)
  .use(TableColumn).use(Select).use(Option)
Vue.config.productionTip = false

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')
