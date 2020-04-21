package cn.flower.sevice;

import java.util.List;
import java.util.Map;

public interface CommentService {
     List<Map<String,Object>> selectComments(int flower_id);
     int insertComment(Map<String,Object> map);

}
