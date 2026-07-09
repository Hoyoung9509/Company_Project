package com.company.homepage.service.impl;

import com.company.homepage.repository.AuditLogRepository;
import com.company.homepage.service.AuditLogService;
import com.company.homepage.vo.AuditLogVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AuditLogServiceImpl implements AuditLogService {

    private final AuditLogRepository auditLogRepository;

    @Override
    public List<AuditLogVo> getAll() { return auditLogRepository.findAll(); }

    @Override
    public void log(String adminId, String action, String targetType, String targetId, String before, String after) {
        AuditLogVo log = new AuditLogVo();
        log.setAdminId(adminId);
        log.setAction(action);
        log.setTargetType(targetType);
        log.setTargetId(targetId);
        log.setBefore(toJson(before));
        log.setAfter(toJson(after));
        auditLogRepository.insert(log);
    }

    private String toJson(String value) {
        if (value == null) return null;
        return "\"" + value.replace("\\", "\\\\").replace("\"", "\\\"") + "\"";
    }
}