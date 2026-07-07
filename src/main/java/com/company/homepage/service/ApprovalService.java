package com.company.homepage.service;

import com.company.homepage.vo.ApprovalVo;
import java.util.List;

public interface ApprovalService {
    List<ApprovalVo> getMyApprovals(String drafterId);
    List<ApprovalVo> getAllApprovals();
    ApprovalVo getById(String id);
    void create(ApprovalVo approval, String drafterId);
    void submit(String id, String actorId);
    void approve(String id, String actorId, String comment);
    void reject(String id, String actorId, String comment);
    void resubmit(String id, String actorId);
    void adminOverride(String id, String adminId, String status, String comment);
}