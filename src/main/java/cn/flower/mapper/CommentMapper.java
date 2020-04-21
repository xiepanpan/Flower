package cn.flower.mapper;

import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component(value ="CommentMapper")
public interface CommentMapper {
public List<Map<String,Object>> selectComments(int flower_id);
    int insertComment(Map<String,Object> map);
}
