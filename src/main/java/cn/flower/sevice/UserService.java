package cn.flower.sevice;

import java.util.Map;

public interface UserService {
    Map<String,Object> selectUser(String username);
    int insertUser(Map<String,Object>map);
    int updateUser(Map<String,Object> map);
    int registerLogin(Map<String,Object> map);

}
