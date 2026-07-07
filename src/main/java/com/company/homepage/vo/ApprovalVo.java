package com.company.homepage.vo;

import lombok.Data;
import java.util.List;

@Data
public class ApprovalVo {
    private String id;
    private String title;
    private String content;
    private String status;
    private String drafterId;
    private String drafterName;
    private String createdAt;
    private String updatedAt;
    private List<ApprovalLogVo> logs;
}