package com.company.homepage.service.impl;

import com.company.homepage.repository.ApprovalLogRepository;
import com.company.homepage.repository.ApprovalRepository;
import com.company.homepage.service.ApprovalService;
import com.company.homepage.vo.ApprovalLogVo;
import com.company.homepage.vo.ApprovalVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ApprovalServiceImpl implements ApprovalService {

    private final ApprovalRepository approvalRepository;
    private final ApprovalLogRepository approvalLogRepository;

    @Override public List<ApprovalVo> getMyApprovals(String drafterId) { return approvalRepository.findByDrafterId(drafterId); }
    @Override public List<ApprovalVo> getAllApprovals()                 { return approvalRepository.findAll(); }
    @Override public ApprovalVo getById(String id) {
        ApprovalVo approval = approvalRepository.findById(id);
        if (approval != null) approval.setLogs(approvalLogRepository.findByApprovalId(id));
        return approval;
    }

    @Override
    public void create(ApprovalVo approval, String drafterId) {
        approval.setDrafterId(drafterId);
        approval.setStatus("DRAFT");
        approvalRepository.insert(approval);
    }

    @Override
    @Transactional
    public void submit(String id, String actorId) {
        approvalRepository.updateStatus(id, "IN_REVIEW");
        addLog(id, actorId, "SUBMITTED", null);
    }

    @Override
    @Transactional
    public void approve(String id, String actorId, String comment) {
        approvalRepository.updateStatus(id, "APPROVED");
        addLog(id, actorId, "APPROVED", comment);
    }

    @Override
    @Transactional
    public void reject(String id, String actorId, String comment) {
        approvalRepository.updateStatus(id, "REJECTED");
        addLog(id, actorId, "REJECTED", comment);
    }

    @Override
    @Transactional
    public void resubmit(String id, String actorId) {
        approvalRepository.updateStatus(id, "IN_REVIEW");
        addLog(id, actorId, "RESUBMITTED", null);
    }

    @Override
    @Transactional
    public void adminOverride(String id, String adminId, String status, String comment) {
        approvalRepository.updateStatus(id, status);
        addLog(id, adminId, "ADMIN_OVERRIDE", comment);
    }

    private void addLog(String approvalId, String actorId, String action, String comment) {
        ApprovalLogVo log = new ApprovalLogVo();
        log.setApprovalId(approvalId);
        log.setActorId(actorId);
        log.setAction(action);
        log.setComment(comment);
        approvalLogRepository.insert(log);
    }
}