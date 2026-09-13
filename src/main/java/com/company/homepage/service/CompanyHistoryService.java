package com.company.homepage.service;

import com.company.homepage.vo.CompanyHistoryVo;
import java.util.List;

public interface CompanyHistoryService {
    List<CompanyHistoryVo> getAll();
    CompanyHistoryVo getById(String id);
    void create(CompanyHistoryVo history);
    void update(CompanyHistoryVo history);
    void delete(String id);
    void moveUp(String id);
    void moveDown(String id);
}
