package com.company.homepage.repository;

import com.company.homepage.vo.ContactVo;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ContactRepository {
    void insert(ContactVo contact);
}