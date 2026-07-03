package com.company.homepage.repository;

import com.company.homepage.vo.UserVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginRepository {
    UserVo findByEmployeeId(String employeeId);
}