package com.company.homepage.service;

import com.company.homepage.vo.ContentVo;
import java.util.List;

public interface ContentService {
    List<ContentVo> getPublishedContents();
}