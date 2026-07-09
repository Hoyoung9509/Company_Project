package com.company.homepage.service.impl;

import com.company.homepage.repository.ContentRepository;
import com.company.homepage.service.ContentService;
import com.company.homepage.service.ElasticsearchSyncService;
import com.company.homepage.vo.ContentVo;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContentServiceImpl implements ContentService {

    private final ContentRepository contentRepository;
    private final ElasticsearchSyncService esSyncService;

    public ContentServiceImpl(ContentRepository contentRepository,
                               @Lazy ElasticsearchSyncService esSyncService) {
        this.contentRepository = contentRepository;
        this.esSyncService = esSyncService;
    }

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
        ContentVo vo = contentRepository.findById(id);
        esSyncService.indexContent(vo);
    }

    @Override
    public void update(ContentVo content) {
        contentRepository.update(content);
        ContentVo updated = contentRepository.findById(content.getId());
        esSyncService.indexContent(updated);
    }

    @Override
    public void delete(String id) {
        contentRepository.delete(id);
        esSyncService.deleteContent(id);
    }
}
