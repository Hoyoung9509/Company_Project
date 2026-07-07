package com.company.homepage.vo;

import lombok.Data;

@Data
public class AuditLogVo {
    private String id;
    private String adminId;
    private String adminName;
    private String action;
    private String targetType;
    private String targetId;
    private String before;
    private String after;
    private String createdAt;
}