package com.company.homepage.service.impl;

import com.company.homepage.repository.ContentRepository;
import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContentVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ContentServiceImpl implements ContentService {

    private final ContentRepository contentRepository;

    @Override
    public List<ContentVo> getPublishedContents() {
        return contentRepository.findPublished();
    }

    @Override
    public List<ContentVo> getContentsByType(String type) {
        return contentRepository.findByType(type);
    }

    @Override
    public List<ContentVo> getAllContents() {
        return contentRepository.findAll();
    }

    @Override
    public ContentVo getById(String id) {
        return contentRepository.findById(id);
    }

    @Override
    public void setPublished(String id, boolean published) {
        contentRepository.updatePublished(id, published ? 1 : 0);
    }

    @Override
    public void update(ContentVo content) {
        contentRepository.update(content);
    }

    @Override
    public void create(ContentVo content) {
        content.setId(java.util.UUID.randomUUID().toString());
        contentRepository.insert(content);
    }

    @Override
    public void delete(String id) {
        contentRepository.delete(id);
    }
}
