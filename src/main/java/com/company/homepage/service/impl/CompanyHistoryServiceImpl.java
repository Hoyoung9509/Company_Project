package com.company.homepage.service.impl;

import com.company.homepage.repository.CompanyHistoryRepository;
import com.company.homepage.service.CompanyHistoryService;
import com.company.homepage.vo.CompanyHistoryVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class CompanyHistoryServiceImpl implements CompanyHistoryService {

    private final CompanyHistoryRepository companyHistoryRepository;

    @Override
    public List<CompanyHistoryVo> getAll() {
        return companyHistoryRepository.findAll();
    }

    @Override
    public CompanyHistoryVo getById(String id) {
        return companyHistoryRepository.findById(id);
    }

    @Override
    public void create(CompanyHistoryVo history) {
        history.setId(UUID.randomUUID().toString());
        Integer maxSortOrder = companyHistoryRepository.findMaxSortOrder();
        history.setSortOrder(maxSortOrder == null ? 0 : maxSortOrder + 1);
        companyHistoryRepository.insert(history);
    }

    @Override
    public void update(CompanyHistoryVo history) {
        companyHistoryRepository.update(history);
    }

    @Override
    public void delete(String id) {
        companyHistoryRepository.delete(id);
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
        List<CompanyHistoryVo> ordered = companyHistoryRepository.findAll();
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
        CompanyHistoryVo current = ordered.get(index);
        CompanyHistoryVo neighbor = ordered.get(neighborIndex);
        companyHistoryRepository.updateSortOrder(current.getId(), neighbor.getSortOrder());
        companyHistoryRepository.updateSortOrder(neighbor.getId(), current.getSortOrder());
    }
}
