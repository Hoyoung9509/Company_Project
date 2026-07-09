package com.company.homepage.repository.search;

import com.company.homepage.document.ContentDocument;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface ContentSearchRepository extends ElasticsearchRepository<ContentDocument, String> {
}
