package com.company.homepage.service;

import com.company.homepage.vo.ContactVo;

import java.util.List;

public interface ContactService {
    void submit(ContactVo contact);
    List<ContactVo> findAll();
    ContactVo findById(Long id);
    void delete(Long id);
}