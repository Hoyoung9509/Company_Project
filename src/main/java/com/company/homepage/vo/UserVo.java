package com.company.homepage.vo;

import lombok.Data;

@Data
public class UserVo {
    private String id;
    private String employeeId;
    private String name;
    private String email;
    private String department;
    private String position;
    private String phone;
    private String role;
    private String passwordHash;
    private int isActive;
}