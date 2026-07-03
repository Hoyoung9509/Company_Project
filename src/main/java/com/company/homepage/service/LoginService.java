package com.company.homepage.service;

import com.company.homepage.vo.UserVo;

public interface LoginService {
    UserVo login(String employeeId, String password);
}