package com.company.homepage.repository;

import com.company.homepage.vo.ContactVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ContactRepository {
    void insert(ContactVo contact);
    List<ContactVo> findAll();
    ContactVo findById(Long id);
    void delete(Long id);
}