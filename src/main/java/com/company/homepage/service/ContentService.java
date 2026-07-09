package com.company.homepage.service;

import com.company.homepage.vo.ContentVo;
import java.util.List;

public interface ContentService {
    List<ContentVo> getPublishedContents();
    List<ContentVo> getContentsByType(String type);
    List<ContentVo> getAllContents();
    ContentVo getById(String id);
    void setPublished(String id, boolean published);
    void update(ContentVo content);
    void create(ContentVo content);
    void delete(String id);
}