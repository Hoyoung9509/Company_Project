package com.company.homepage.repository;

import com.company.homepage.vo.AuditLogVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface AuditLogRepository {
    List<AuditLogVo> findAll();
    void insert(AuditLogVo log);
}