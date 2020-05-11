package cn.flower;

import cn.flower.mapper.CommentMapper;
import cn.flower.mapper.UserMapper;
import cn.flower.sevice.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.HashMap;
import java.util.Map;

@SpringBootTest
class FlowerApplicationTests {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private cn.flower.mapper.FlowerMapper FlowerMapper;
    @Autowired
    private CommentMapper commentMapper;

    @Test
    void contextLoads() {
        Map<String, Object> map = new HashMap<>();
        map.put("Flower_type_id", 2);
        FlowerMapper.deleteFlowerType(map);
    }
}