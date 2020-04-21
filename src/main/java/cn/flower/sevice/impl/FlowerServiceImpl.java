package cn.flower.sevice.impl;

import cn.flower.sevice.FlowerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class FlowerServiceImpl implements FlowerService {
    @Autowired
    private cn.flower.mapper.FlowerMapper FlowerMapper;
    @Override
    public List<Map<String, Object>>  selectFlower() {
        return FlowerMapper.selectFlower();
    }

    @Override
    public List<Map<String, Object>> selectFlowerDiscount()
    {
        return FlowerMapper.selectFlowerDiscount();
    }

    @Override
    public List<Map<String, Object>> selectFlowerHot() {
        return FlowerMapper.selectFlowerHot();
    }

    @Override
    public Map<String, Object> selectFlowerById(int flower_id) {
        return FlowerMapper.selectFlowerById(flower_id);
    }

    @Override
    public int collectFlower(Map<String, Object> map) {
        return FlowerMapper.collectFlower(map);
    }

    @Override
    public int buyFlower(Map<String, Object> map) {
        return FlowerMapper.buyFlower(map);
    }

    @Override
    public List<Map<String, Object>> soldFlower(int status) {
        return FlowerMapper.soldFlower(status);
    }

    @Override
    public int sellFlower(Map<String,Object> map) {
        return FlowerMapper.sellFlower(map);
    }

    @Override
    public List<Map<String, Object>> selectCollectFlower(int user_id) {
        return FlowerMapper.selectCollectFlower(user_id);
    }

    @Override
    public int collectDelete(Map<String, Object> map) {
        return FlowerMapper.collectDelete(map);
    }

    @Override
    public int sell_times(int buy_id) {
        Map<String, Object> map = FlowerMapper.sellTimes(buy_id);
        int flower_id = (int) map.get("flower_id");
        int sell_times = (int) map.get("sell_times");
        sell_times+=1;
        return FlowerMapper.updateSellTimes(sell_times,flower_id);
    }

    @Override
    public int insertFlower(Map<String, Object> map) {
        return FlowerMapper.insertFlower(map);
    }

    @Override
    public int deleteFlower(Map<String, Object> map) {
        return FlowerMapper.deleteFlower(map);
    }

    @Override
    public List<Map<String, Object>> FlowerType() {
        return FlowerMapper.FlowerType();
    }

    @Override
    public int insertFlowerType(Map<String, Object> map) {
        return FlowerMapper.insertFlowerType(map);
    }

    @Override
    public int deleteFlowerType(Map<String, Object> map) {
        return FlowerMapper.deleteFlowerType(map);
    }

    @Override
    public Map<String, Object> avgStar(int flower_id) {
        return FlowerMapper.avgStar(flower_id);
    }

    @Override
    public List<Map<String, Object>> myOrder(int user_id, int status) {
        return FlowerMapper.myOrder(user_id,status);
    }

    @Override
    public int updateFlower(Map<String, Object> map) {
        return FlowerMapper.updateFlower(map);
    }
}
