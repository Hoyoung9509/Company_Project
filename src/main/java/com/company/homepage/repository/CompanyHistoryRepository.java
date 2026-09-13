package com.company.homepage.repository;

import com.company.homepage.vo.CompanyHistoryVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface CompanyHistoryRepository {
    List<CompanyHistoryVo> findAll();
    CompanyHistoryVo findById(String id);
    Integer findMaxSortOrder();
    void insert(CompanyHistoryVo history);
    void update(CompanyHistoryVo history);
    void updateSortOrder(@Param("id") String id, @Param("sortOrder") int sortOrder);
    void delete(String id);
}
