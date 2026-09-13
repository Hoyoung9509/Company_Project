package com.company.homepage.service;

import com.company.homepage.vo.WorkCategoryVo;
import java.util.List;

public interface WorkCategoryService {
    List<WorkCategoryVo> getAll();
    WorkCategoryVo getById(String id);
    void create(WorkCategoryVo category);
    void update(WorkCategoryVo category);
    void delete(String id);
    void moveUp(String id);
    void moveDown(String id);
}
