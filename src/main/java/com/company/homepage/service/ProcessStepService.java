package com.company.homepage.service;

import com.company.homepage.vo.ProcessStepVo;
import java.util.List;

public interface ProcessStepService {
    List<ProcessStepVo> getAll();
    ProcessStepVo getById(String id);
    void create(ProcessStepVo step);
    void update(ProcessStepVo step);
    void delete(String id);
    void moveUp(String id);
    void moveDown(String id);
}
