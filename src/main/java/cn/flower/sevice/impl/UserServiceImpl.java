package cn.flower.sevice.impl;

import cn.flower.mapper.UserMapper;
import cn.flower.sevice.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public Map<String, Object> selectUser(String username) {
        return userMapper.selectUser(username);
    }

    @Override
    public int insertUser(Map<String, Object> map) {
        return userMapper.insertUser(map);
    }

    @Override
    public int updateUser(Map<String, Object> map) {
        return userMapper.updateUser(map);
    }

    @Override
    public int registerLogin(Map<String, Object> map) {
        return userMapper.registerLogin(map);
    }
}
