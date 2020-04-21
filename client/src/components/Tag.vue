<!--
 * @Description: 提醒标记组件,elm的标记组件只能在按钮图标上
 * @Author: so-hard
 * @Date: 2019-08-22 13:48:13
 * @LastEditTime: 2019-08-22 14:39:49
 * @LastEditors: Please set LastEditors
 -->
<template>
  <section class="tag">
      <slot></slot>
  </section>
</template>

<script>
export default {
    name: 'Tag'
}
</script>

<style lang="stylus">
    .tag {
        position: absolute;
        transform: translate(50%,-50%) 
        top: 0;
        right: 0;
        height: 1vw;
        font-size: 10px;
        width: 1vw;
        padding: 10px
        color: #fff;
        background: #ffff09;
        border-radius: 50%;
        text-align: center
        line-height 10px
    }
</style>