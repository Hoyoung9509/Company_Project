package com.company.homepage.vo;

import lombok.Data;

@Data
public class ProcessStepVo {
    private String id;
    private String title;
    private String description;
    private int sortOrder;
    private String createdAt;
}
