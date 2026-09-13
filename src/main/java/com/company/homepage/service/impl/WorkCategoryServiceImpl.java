package com.company.homepage.service.impl;

import com.company.homepage.repository.WorkCategoryRepository;
import com.company.homepage.service.WorkCategoryService;
import com.company.homepage.vo.WorkCategoryVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class WorkCategoryServiceImpl implements WorkCategoryService {

    private final WorkCategoryRepository workCategoryRepository;

    @Override
    public List<WorkCategoryVo> getAll() {
        return workCategoryRepository.findAll();
    }

    @Override
    public WorkCategoryVo getById(String id) {
        return workCategoryRepository.findById(id);
    }

    @Override
    public void create(WorkCategoryVo category) {
        category.setId(UUID.randomUUID().toString());
        Integer maxSortOrder = workCategoryRepository.findMaxSortOrder();
        category.setSortOrder(maxSortOrder == null ? 0 : maxSortOrder + 1);
        workCategoryRepository.insert(category);
    }

    @Override
    public void update(WorkCategoryVo category) {
        workCategoryRepository.update(category);
    }

    @Override
    public void delete(String id) {
        workCategoryRepository.delete(id);
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
        List<WorkCategoryVo> ordered = workCategoryRepository.findAll();
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
        WorkCategoryVo current = ordered.get(index);
        WorkCategoryVo neighbor = ordered.get(neighborIndex);
        workCategoryRepository.updateSortOrder(current.getId(), neighbor.getSortOrder());
        workCategoryRepository.updateSortOrder(neighbor.getId(), current.getSortOrder());
    }
}
