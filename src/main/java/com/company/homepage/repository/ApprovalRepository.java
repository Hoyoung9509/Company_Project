package com.company.homepage.repository;

import com.company.homepage.vo.ApprovalVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface ApprovalRepository {
    List<ApprovalVo> findByDrafterId(String drafterId);
    List<ApprovalVo> findAll();
    ApprovalVo findById(String id);
    void insert(ApprovalVo approval);
    void updateStatus(@Param("id") String id, @Param("status") String status);
}