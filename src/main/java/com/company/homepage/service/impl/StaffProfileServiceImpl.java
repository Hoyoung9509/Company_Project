package com.company.homepage.service.impl;

import com.company.homepage.repository.StaffProfileRepository;
import com.company.homepage.service.StaffProfileService;
import com.company.homepage.vo.StaffProfileVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class StaffProfileServiceImpl implements StaffProfileService {

    private final StaffProfileRepository staffProfileRepository;

    @Override
    public List<StaffProfileVo> getAll() {
        return staffProfileRepository.findAll();
    }

    @Override
    public StaffProfileVo getById(String id) {
        return staffProfileRepository.findById(id);
    }

    @Override
    public void create(StaffProfileVo profile) {
        profile.setId(UUID.randomUUID().toString());
        Integer maxSortOrder = staffProfileRepository.findMaxSortOrder();
        profile.setSortOrder(maxSortOrder == null ? 0 : maxSortOrder + 1);
        staffProfileRepository.insert(profile);
    }

    @Override
    public void update(StaffProfileVo profile) {
        staffProfileRepository.update(profile);
    }

    @Override
    public void delete(String id) {
        staffProfileRepository.delete(id);
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
        List<StaffProfileVo> ordered = staffProfileRepository.findAll();
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
        StaffProfileVo current = ordered.get(index);
        StaffProfileVo neighbor = ordered.get(neighborIndex);
        staffProfileRepository.updateSortOrder(current.getId(), neighbor.getSortOrder());
        staffProfileRepository.updateSortOrder(neighbor.getId(), current.getSortOrder());
    }
}
