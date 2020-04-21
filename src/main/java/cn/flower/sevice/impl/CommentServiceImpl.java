package cn.flower.sevice.impl;

import cn.flower.mapper.CommentMapper;
import cn.flower.sevice.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
@Service
public class CommentServiceImpl implements CommentService {
    @Autowired
    private CommentMapper commentMapper;
    @Override
    public List<Map<String, Object>> selectComments(int flower_id) {
        return commentMapper.selectComments(flower_id);
    }

    @Override
    public int insertComment(Map<String, Object> map) {
        return commentMapper.insertComment(map) ;
    }
}
