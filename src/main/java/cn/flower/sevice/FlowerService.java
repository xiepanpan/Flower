package cn.flower.sevice;

import java.util.List;
import java.util.Map;

public interface FlowerService {
    List<Map<String, Object>> selectFlower();
    List<Map<String, Object>>  selectFlowerDiscount();
    List<Map<String, Object>> selectFlowerHot();
    Map<String, Object> selectFlowerById(int flower_id);
    int collectFlower(Map<String,Object> map);
    int buyFlower(Map<String,Object> map);
    List<Map<String, Object>> soldFlower(int status);
    int sellFlower(Map<String,Object> map);
    List<Map<String, Object>> selectCollectFlower(int user_id);
    int collectDelete(Map<String,Object> map);
    int sell_times(int buy_id);
    int insertFlower(Map<String,Object> map);
    int deleteFlower(Map<String,Object> map);
    List<Map<String,Object>>FlowerType();
    int insertFlowerType(Map<String,Object> map);
    int deleteFlowerType(Map<String,Object> map);
    Map<String,Object> avgStar(int flower_id);
    List<Map<String,Object>>myOrder(int user_id,int status);
    int updateFlower(Map<String,Object> map);
}
