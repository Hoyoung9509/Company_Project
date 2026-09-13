package com.company.homepage.repository;

import com.company.homepage.vo.WorkCategoryVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface WorkCategoryRepository {
    List<WorkCategoryVo> findAll();
    WorkCategoryVo findById(String id);
    Integer findMaxSortOrder();
    void insert(WorkCategoryVo category);
    void update(WorkCategoryVo category);
    void updateSortOrder(@Param("id") String id, @Param("sortOrder") int sortOrder);
    void delete(String id);
}
