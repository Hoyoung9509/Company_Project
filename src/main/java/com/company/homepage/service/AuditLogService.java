package com.company.homepage.service;

import com.company.homepage.vo.AuditLogVo;
import java.util.List;

public interface AuditLogService {
    List<AuditLogVo> getAll();
    void log(String adminId, String action, String targetType, String targetId, String before, String after);
}