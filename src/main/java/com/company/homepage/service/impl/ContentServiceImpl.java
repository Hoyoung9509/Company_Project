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
}