package com.company.homepage.vo;

import lombok.Data;

@Data
public class StaffProfileVo {
    private String id;
    private String name;
    private String position;
    private String photoUrl;
    private String bio;
    private String career;
    private String portfolio;
    private int sortOrder;
    private String createdAt;
}
