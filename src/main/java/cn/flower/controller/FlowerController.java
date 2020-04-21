package cn.flower.controller;

import cn.flower.utils.R;
import cn.flower.sevice.FlowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FlowerController {
    @Autowired
    private FlowerService flowerService;
    @ResponseBody
    @GetMapping("/flower")
    public R selectFlower(){
        return R.ok(200,"查询成功", flowerService.selectFlower());
    }
    @ResponseBody
    @GetMapping("/flowerDiscount")
    public R selectFlowerDiscount(){
        return R.ok(200,"查询成功", flowerService.selectFlowerDiscount());
    }
    @ResponseBody
    @GetMapping("/flowerHot")
    public R selectFlowerHot(){
        return R.ok(200,"查询成功", flowerService.selectFlowerHot());
    }
    @ResponseBody
    @GetMapping("/flowerDetail")
    public R selectFlowerHot(int flower_id){
        Map<String, Object> map = flowerService.selectFlowerById(flower_id);
        int discount= (int) map.get("discount");
        int price = (int) map.get("price");
        if(discount!=0) {
            map.put("now_price", price - (price / discount));
        }else {
            map.put("now_price",price) ;
        }
        Map<String, Object> star = flowerService.avgStar(flower_id);
        if (star!=null){
            map.put("star",star.get("star"));
        }else {
            map.put("star",0);
        }
        return R.ok(200,"查询成功",map);

    }
    @ResponseBody
    @PostMapping("/flowerCollect")
    public R flowerCollect(@RequestBody Map<String,Object> map, HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        int user_id = (int) user.get("user_id");
        map.put("user_id",user_id);
        flowerService.collectFlower(map);
        return R.ok("收藏成功");

    }
    @ResponseBody
    @PostMapping("/flowerBuy/")
    public R flowerBuy(@RequestBody Map<String,Object> map, HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        int user_id = (int) user.get("user_id");
        map.put("user_id",user_id);
        map.put("status",0);//下单状态为0，接单为1,收货为2
        flowerService.buyFlower(map);
        return R.ok("下单成功，等待商家接单");

    }
    @ResponseBody
    @GetMapping("/flowerSold")
    public R flowerSold(int status){
        return R.ok(200,"查询成功", flowerService.soldFlower(status));
    }

    @ResponseBody
    @PostMapping("/flowerSell/")//接单&收货
    public R flowerSell(@RequestBody Map<String,Object> map){
        int status= (int) map.get("status");
        int buy_id= (int) map.get("buy_id");
        String msg="接单成功";
        flowerService.sellFlower(map);
        if (status==2){
            msg="收货成功";
            //收货成功调用添加成交次数接口,成交次数加1
            flowerService.sell_times(buy_id);
        }
        return R.ok(msg);

    }
    @ResponseBody
    @GetMapping("/flowerCollected")
    public R flowerCollected(HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        int user_id = (int) user.get("user_id");
        return R.ok(200,"查询成功", flowerService.selectCollectFlower(user_id));
    }
    @ResponseBody
    @PostMapping("/collectDelete/")
    public R collectDelete(@RequestBody Map<String,Object> map){
        flowerService.collectDelete(map);
        return R.ok("取消收藏成功");
    }
    @ResponseBody
    @PostMapping("/insertFlower/")
    public R insertFlower(@RequestParam("image") MultipartFile file,String name,int price,int discount,int flower_type_id) throws IOException {
        File path = new File(ResourceUtils.getURL("classpath:").getPath());
        File realPath = new File(path.getAbsolutePath(),"/static/images/");
        System.out.println(realPath);
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
        Map<String,Object> map=new HashMap<>();
        map.put("sell_times",0);
        map.put("flower_image",file_name);
        map.put("name",name);
        map.put("price",price);
        map.put("discount",discount);
        map.put("flower_type_id",flower_type_id);
        flowerService.insertFlower(map);
        return R.ok("新增成功");
    }
    @ResponseBody
    @PostMapping("/deleteFlower/")
    public R deleteFlower(@RequestBody Map<String,Object> map)  {
        flowerService.deleteFlower(map);
        return R.ok("删除成功");
    }
    @ResponseBody
    @GetMapping("/flowerType")
    public R FlowerType(){
    return R.ok(200,"查询成功", flowerService.FlowerType());
    }
    @ResponseBody
    @PostMapping("/insertType/")
    public R insertType(@RequestBody Map<String,Object> map){
        flowerService.insertFlowerType(map);
        return R.ok("新增成功");
    }
    @ResponseBody
    @PostMapping("/deleteType/")
    public R deleteType(@RequestBody Map<String,Object> map){
        int i = flowerService.deleteFlowerType(map);
        return R.ok("删除成功");
    }
    @ResponseBody
    @GetMapping("/myOrder")
    public R deleteType(int status,HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error(500,"尚未登录");
        }
        int user_id = (int) user.get("user_id");
        List<Map<String, Object>> maps = flowerService.myOrder(user_id, status);
        return R.ok(200,"查询成功",maps);
    }
    @ResponseBody
    @PostMapping("/updateFlower/")
    public R updateFlower(@RequestParam(value = "image",required = false) MultipartFile file,
                        String name,int price,int discount,int flower_id
                        )throws IOException{
        Map<String,Object> map=new HashMap<>();
        if (file!=null) {
            File path = new File(ResourceUtils.getURL("classpath:").getPath());
            File realPath = new File(path.getAbsolutePath(), "/static/images/");
            if (!realPath.exists()) {
                realPath.mkdirs();
            }
            //存储文件名
            int max = 10000, min = 1;
            int ran = (int) (Math.random() * (max - min) + min);
            String file_name = file.getOriginalFilename();
            String[] split = file_name.split("\\.");
            file_name = split[0] + ran + "." + split[1];
            file.transferTo(new File(realPath + "/" + file_name));
            System.out.println(realPath + "/" + file_name);
            map.put("flower_image",file_name);
        }
        map.put("name",name);
        map.put("price",price);
        map.put("discount",discount);
        map.put("flower_id",flower_id);
        flowerService.updateFlower(map);
        return R.ok("修改成功");
    }
}

