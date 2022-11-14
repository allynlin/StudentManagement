package com.cshbxy.service;

import com.cshbxy.pojo.User;

public interface UserService {
  User login(User user);

  int updateUserPassword(User user);
}
