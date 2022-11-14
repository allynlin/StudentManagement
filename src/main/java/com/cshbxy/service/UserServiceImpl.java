package com.cshbxy.service;

import com.cshbxy.mapper.UserMapper;
import com.cshbxy.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Allyn
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(User user) {
        return userMapper.login(user);
    }

    @Override public int updateUserPassword(User user) {
        return userMapper.updateUserPassword(user);
    }
}
