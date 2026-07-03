package com.company.homepage.service.impl;

import com.company.homepage.repository.LoginRepository;
import com.company.homepage.service.LoginService;
import com.company.homepage.vo.UserVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LoginServiceImpl implements LoginService {

    private final LoginRepository loginRepository;

    @Override
    public UserVo login(String employeeId, String password) {
        UserVo user = loginRepository.findByEmployeeId(employeeId);
        if (user == null || !password.equals(user.getPasswordHash())) return null;
        // TODO: BCrypt 해시 비교로 교체 필요
        user.setPasswordHash(null);
        return user;
    }
}