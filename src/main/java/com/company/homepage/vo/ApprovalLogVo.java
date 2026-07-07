package com.company.homepage.vo;

import lombok.Data;

@Data
public class ApprovalLogVo {
    private String id;
    private String approvalId;
    private String actorId;
    private String actorName;
    private String action;
    private String comment;
    private String createdAt;
}