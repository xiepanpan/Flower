package cn.flower.mapper;

import org.springframework.stereotype.Component;

import java.util.Map;

@Component(value ="UserMapper")
public interface UserMapper {
//    id="selectUser"
     Map<String,Object> selectUser(String username);
     int insertUser(Map<String,Object> map);
     int updateUser(Map<String,Object> map);
     int registerLogin(Map<String,Object> map);
}
