package com.company.homepage.vo;

import lombok.Data;

@Data
public class ContactVo {
    private Long id;
    private String name;
    private String email;
    private String phone;
    private String message;
    private String createdAt;
}