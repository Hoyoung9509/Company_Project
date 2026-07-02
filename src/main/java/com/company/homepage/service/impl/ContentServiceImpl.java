package com.company.homepage.service.impl;

import com.company.homepage.service.ContentService;
import com.company.homepage.vo.ContentVo;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ContentServiceImpl implements ContentService {

    @Override
    public List<ContentVo> getPublishedContents() {
        // TODO: Repository 연결 전 임시 데이터
        ContentVo item = new ContentVo();
        item.setId("1");
        item.setTitle("예시 콘텐츠");
        item.setBody("본문 내용");
        return List.of(item);
    }
}