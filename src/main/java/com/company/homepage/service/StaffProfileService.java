package com.company.homepage.service;

import com.company.homepage.vo.StaffProfileVo;
import java.util.List;

public interface StaffProfileService {
    List<StaffProfileVo> getAll();
    StaffProfileVo getById(String id);
    void create(StaffProfileVo profile);
    void update(StaffProfileVo profile);
    void delete(String id);
    void moveUp(String id);
    void moveDown(String id);
}
