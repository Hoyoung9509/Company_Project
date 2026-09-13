package com.company.homepage.repository;

import com.company.homepage.vo.ProcessStepVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ProcessStepRepository {
    List<ProcessStepVo> findAll();
    ProcessStepVo findById(String id);
    Integer findMaxSortOrder();
    void insert(ProcessStepVo step);
    void update(ProcessStepVo step);
    void updateSortOrder(@Param("id") String id, @Param("sortOrder") int sortOrder);
    void delete(String id);
}
