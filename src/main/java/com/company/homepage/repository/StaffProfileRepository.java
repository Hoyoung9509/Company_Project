package com.company.homepage.repository;

import com.company.homepage.vo.StaffProfileVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface StaffProfileRepository {
    List<StaffProfileVo> findAll();
    StaffProfileVo findById(String id);
    Integer findMaxSortOrder();
    void insert(StaffProfileVo profile);
    void update(StaffProfileVo profile);
    void updateSortOrder(@Param("id") String id, @Param("sortOrder") int sortOrder);
    void delete(String id);
}
