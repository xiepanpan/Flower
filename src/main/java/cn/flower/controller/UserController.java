package cn.flower.controller;


import cn.flower.utils.R;
import cn.flower.sevice.UserService;
import com.google.code.kaptcha.Producer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private Producer producer;
    //验证码
    @RequestMapping("/captcha.jpg")
public void kaptcha(HttpServletResponse response, HttpSession session) throws IOException {
        response.setHeader("Cache-Control","no-store,no-cache" );
        response.setContentType("image/jpeg");
        //文字
        String text=producer.createText();
        //将文字存入session
        session.setAttribute("captcha",text);
        //图片
        BufferedImage bufferedImage= producer.createImage(text);
        //响应客户
        ServletOutputStream out =response.getOutputStream();
        ImageIO.write(bufferedImage,"jpg",out);
        out.flush();//清空缓冲区
}
    @ResponseBody
    @RequestMapping("/captcha")
    public R captcha(HttpServletResponse response, HttpSession session) throws IOException {
//        {"code":20000,"data":{"token":"admin-token"}}
        //文字
        String text=producer.createText();
        //将文字存入session
        session.setAttribute("captcha",text);
        Map<String,Object> map=new HashMap<>();
        map.put("text",text);
        map.put("token","admin-token");
        return R.ok(200,"请求成功",map);
    }

    /**
     * 登录
     */
    @Autowired
    private UserService userService;

    @ResponseBody
    @PostMapping("/login/")
    public R login(@RequestBody Map<String, String> map,HttpSession session) {
        String captchaSession= (String) session.getAttribute("captcha");
        String captcha=map.get("captcha");
        if (!captcha.equals(captchaSession)){
            return R.error(500,"验证码错误");
        }
        String username=map.get("username");
        Map<String, Object> user = userService.selectUser(username);
        if (user==null){
            return R.error(501,"无此帐号");
        }
        String password = map.get("password");
        if (!user.get("password").equals(map.get("password"))){
            return R.error(500,"密码错误");
        }
        //将user存入session
        session.setAttribute("user",user);
        return R.ok(200,"登录成功",user);
    }
    /**
     * 注册（不使用）
     */
    @ResponseBody
    @RequestMapping("/register/")
    public R uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request,
                         String username,String phone,String password,String address,String name
                         ) throws IOException {
        Map<String, Object> isRegister = userService.selectUser(username);
        if (isRegister!=null){
            return R.error(500,"帐号已被注册");
        }
        File path = new File(ResourceUtils.getURL("classpath:").getPath());
        File realPath = new File(path.getAbsolutePath(),"/static/images/");
        if (!realPath.exists()) {
            realPath.mkdirs();
        }
        //存储文件名
        int max=10000,min=1;
        int ran = (int) (Math.random()*(max-min)+min);
        String file_name=file.getOriginalFilename();
        String[] split = file_name.split("\\.");
        file_name=split[0]+ran+"."+split[1];
        file.transferTo(new File(realPath + "/" + file_name));
        Map<String,Object> userMap=new HashMap<>();
        userMap.put("username",username);
        userMap.put("phone",phone);
        userMap.put("password",password);
        userMap.put("address",address);
        userMap.put("name",name);
        userMap.put("head_image",file_name);
        userMap.put("role",1);//默认注册为买家
        int i = userService.insertUser(userMap);
        if (i==1){
        return R.ok("注册成功");
    }
        return R.error(500,"注册失败");
    }

    @ResponseBody
    @PostMapping("/registerLogin/")
    public R registerLogin(@RequestBody Map<String,Object> map,HttpSession session) {
        map.put("role",1);
        userService.registerLogin(map);
        String username = (String) map.get("username");
        Map<String, Object> user = userService.selectUser(username);
        session.setAttribute("user",user);
        return R.ok("注册成功");
    }
    /**
     * 获取已登录用户信息用于前台展示
     */
    @ResponseBody
    @RequestMapping("/user")
    public R getUser(HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        String username = (String) user.get("username");
        Map<String, Object> map = userService.selectUser(username);
        session.setAttribute("user",map);
        return R.ok(200,"已登录",map);
    }

    @ResponseBody
    @PostMapping("/updateUser/")
    public R updateUser( @RequestParam(value = "file",required = false)MultipartFile file, HttpSession session,
    String phone,String address,String name)throws IOException{
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        int user_id = (int) user.get("user_id");
        Map<String,Object> map=new HashMap<>();
        if (file!=null){
            File path = new File(ResourceUtils.getURL("classpath:").getPath());
            File realPath = new File(path.getAbsolutePath(),"/static/images/");
            if (!realPath.exists()) {
                realPath.mkdirs();
            }
            //存储文件名
            int max=10000,min=1;
            int ran = (int) (Math.random()*(max-min)+min);
            String file_name=file.getOriginalFilename();
            String[] split = file_name.split("\\.");
            file_name=split[0]+ran+"."+split[1];
            file.transferTo(new File(realPath + "/" + file_name));
            map.put("head_image",file_name);
        }else {
            map.put("head_image",null);
        }
        map.put("user_id",user_id);
        map.put("phone",phone);
        map.put("address",address);
        map.put("name",name);
        userService.updateUser(map);
        return R.ok("修改成功");
    }
    @ResponseBody
    @GetMapping("/logout")
    public R logout(HttpSession session) {
        session.removeAttribute("user");
        return R.ok("登出成功");
    }
}
