package com.company.homepage.repository;

import com.company.homepage.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface UserRepository {
    List<UserVo> findAll();
    List<UserVo> findActive();
    UserVo findById(String id);
    void updateProfile(UserVo user);
    void updateRole(@Param("id") String id, @Param("role") String role);
    void updateActive(@Param("id") String id, @Param("isActive") int isActive);
    void insert(UserVo user);
    void adminUpdate(UserVo user);
}