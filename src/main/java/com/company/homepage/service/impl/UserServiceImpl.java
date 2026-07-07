package com.company.homepage.service.impl;

import com.company.homepage.repository.UserRepository;
import com.company.homepage.service.UserService;
import com.company.homepage.vo.UserVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override public List<UserVo> getAllUsers()         { return userRepository.findAll(); }
    @Override public List<UserVo> getActiveUsers()      { return userRepository.findActive(); }
    @Override public UserVo getUserById(String id)      { return userRepository.findById(id); }
    @Override public void updateProfile(UserVo user)    { userRepository.updateProfile(user); }
    @Override public void updateRole(String id, String role)    { userRepository.updateRole(id, role); }
    @Override public void setActive(String id, boolean active)  { userRepository.updateActive(id, active ? 1 : 0); }
    @Override public void createUser(UserVo user)       { userRepository.insert(user); }
}