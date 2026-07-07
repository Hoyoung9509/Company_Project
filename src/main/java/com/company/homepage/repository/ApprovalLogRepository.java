package com.company.homepage.repository;

import com.company.homepage.vo.ApprovalLogVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface ApprovalLogRepository {
    List<ApprovalLogVo> findByApprovalId(String approvalId);
    void insert(ApprovalLogVo log);
}