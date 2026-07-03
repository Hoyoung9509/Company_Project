package com.company.homepage.repository;

import com.company.homepage.vo.ContentVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface ContentRepository {
    List<ContentVo> findPublished();
}