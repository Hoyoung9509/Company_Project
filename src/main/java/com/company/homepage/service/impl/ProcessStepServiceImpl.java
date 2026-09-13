package com.company.homepage.service.impl;

import com.company.homepage.repository.ProcessStepRepository;
import com.company.homepage.service.ProcessStepService;
import com.company.homepage.vo.ProcessStepVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ProcessStepServiceImpl implements ProcessStepService {

    private final ProcessStepRepository processStepRepository;

    @Override
    public List<ProcessStepVo> getAll() {
        return processStepRepository.findAll();
    }

    @Override
    public ProcessStepVo getById(String id) {
        return processStepRepository.findById(id);
    }

    @Override
    public void create(ProcessStepVo step) {
        step.setId(UUID.randomUUID().toString());
        Integer maxSortOrder = processStepRepository.findMaxSortOrder();
        step.setSortOrder(maxSortOrder == null ? 0 : maxSortOrder + 1);
        processStepRepository.insert(step);
    }

    @Override
    public void update(ProcessStepVo step) {
        processStepRepository.update(step);
    }

    @Override
    public void delete(String id) {
        processStepRepository.delete(id);
    }

    @Override
    public void moveUp(String id) {
        swapWithNeighbor(id, -1);
    }

    @Override
    public void moveDown(String id) {
        swapWithNeighbor(id, 1);
    }

    private void swapWithNeighbor(String id, int offset) {
        List<ProcessStepVo> ordered = processStepRepository.findAll();
        int index = -1;
        for (int i = 0; i < ordered.size(); i++) {
            if (ordered.get(i).getId().equals(id)) {
                index = i;
                break;
            }
        }
        int neighborIndex = index + offset;
        if (index < 0 || neighborIndex < 0 || neighborIndex >= ordered.size()) {
            return;
        }
        ProcessStepVo current = ordered.get(index);
        ProcessStepVo neighbor = ordered.get(neighborIndex);
        processStepRepository.updateSortOrder(current.getId(), neighbor.getSortOrder());
        processStepRepository.updateSortOrder(neighbor.getId(), current.getSortOrder());
    }
}
