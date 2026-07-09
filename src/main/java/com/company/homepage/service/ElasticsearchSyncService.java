package com.company.homepage.service;

import co.elastic.clients.elasticsearch._types.FieldValue;
import com.company.homepage.document.ContentDocument;
import com.company.homepage.repository.ContentRepository;
import com.company.homepage.repository.search.ContentSearchRepository;
import com.company.homepage.vo.ContentVo;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.elasticsearch.client.elc.NativeQuery;
import org.springframework.data.elasticsearch.core.ElasticsearchOperations;
import org.springframework.data.elasticsearch.core.SearchHit;
import org.springframework.data.elasticsearch.core.query.Query;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
public class ElasticsearchSyncService {

    private final ContentRepository contentRepository;
    private final ContentSearchRepository contentSearchRepository;
    private final ElasticsearchOperations elasticsearchOperations;

    @PostConstruct
    public void syncAll() {
        try {
            List<ContentDocument> docs = contentRepository.findAll().stream()
                    .filter(c -> c.getIsPublished() == 1)
                    .map(this::toDoc)
                    .collect(Collectors.toList());
            contentSearchRepository.deleteAll();
            contentSearchRepository.saveAll(docs);
            log.info("[ES] Sync complete: {} documents indexed", docs.size());
        } catch (Exception e) {
            log.warn("[ES] Sync skipped (Elasticsearch may not be running): {}", e.getMessage());
        }
    }

    public void indexContent(ContentVo vo) {
        try {
            if (vo.getIsPublished() == 1) {
                contentSearchRepository.save(toDoc(vo));
            } else {
                contentSearchRepository.deleteById(vo.getId());
            }
        } catch (Exception e) {
            log.warn("[ES] Index failed: {}", e.getMessage());
        }
    }

    public void deleteContent(String id) {
        try {
            contentSearchRepository.deleteById(id);
        } catch (Exception e) {
            log.warn("[ES] Delete failed: {}", e.getMessage());
        }
    }

    public List<ContentDocument> search(String keyword, boolean includeInternal) {
        try {
            List<FieldValue> typeValues = (includeInternal
                    ? List.of("NOTICE_PUBLIC", "NOTICE_INTERNAL", "CAREER", "SERVICE")
                    : List.of("NOTICE_PUBLIC", "CAREER", "SERVICE"))
                    .stream().map(FieldValue::of).collect(Collectors.toList());

            String wildcardKeyword = "*" + keyword + "*";
            Query query = NativeQuery.builder()
                    .withQuery(q -> q.bool(b -> b
                            .must(m -> m.queryString(qs -> qs
                                    .fields("title^2", "body")
                                    .query(wildcardKeyword)
                            ))
                            .filter(f -> f.terms(t -> t
                                    .field("type")
                                    .terms(tv -> tv.value(typeValues))
                            ))
                    ))
                    .withMaxResults(50)
                    .build();

            return elasticsearchOperations.search(query, ContentDocument.class)
                    .stream()
                    .map(SearchHit::getContent)
                    .collect(Collectors.toList());
        } catch (Exception e) {
            log.warn("[ES] Search failed: {}", e.getMessage());
            return List.of();
        }
    }

    private ContentDocument toDoc(ContentVo vo) {
        ContentDocument doc = new ContentDocument();
        doc.setId(vo.getId());
        doc.setType(vo.getType());
        doc.setTitle(vo.getTitle());
        doc.setBody(vo.getBody());
        doc.setPublished(vo.getIsPublished() == 1);
        doc.setCreatedAt(vo.getCreatedAt());
        return doc;
    }
}
