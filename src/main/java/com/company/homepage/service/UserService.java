package com.company.homepage.service;

import com.company.homepage.vo.UserVo;
import java.util.List;

public interface UserService {
    List<UserVo> getAllUsers();
    List<UserVo> getActiveUsers();
    UserVo getUserById(String id);
    void updateProfile(UserVo user);
    void updateRole(String id, String role);
    void setActive(String id, boolean active);
    void createUser(UserVo user);
}