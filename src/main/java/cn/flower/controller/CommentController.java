package cn.flower.controller;


import cn.flower.utils.R;
import cn.flower.sevice.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class CommentController {

    @Autowired
    private CommentService commentService;

    @ResponseBody
    @RequestMapping("/comments")
    public R comments(int flower_id){
        List<Map<String, Object>> maps = commentService.selectComments(flower_id);
        return R.ok(200,"查询成功",maps);
    }
    @ResponseBody
    @RequestMapping("/insertComments/")
    public R insertComments(@RequestBody Map<String,Object> map,HttpSession session){
        Map<String,Object> user = (Map<String, Object>) session.getAttribute("user");
        if (user==null){
            return R.error("尚未登录");
        }
        map.put("user_id",user.get("user_id"));
        commentService.insertComment(map);
        return R.ok("评论成功");
    }
}
