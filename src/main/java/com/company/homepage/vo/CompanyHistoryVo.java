package com.company.homepage.vo;

import lombok.Data;

@Data
public class CompanyHistoryVo {
    private String id;
    private String year;
    private String description;
    private int sortOrder;
    private String createdAt;
}
