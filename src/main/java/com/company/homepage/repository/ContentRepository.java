package com.company.homepage.repository;

import com.company.homepage.vo.ContentVo;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface ContentRepository {
    List<ContentVo> findPublished();
    List<ContentVo> findByType(String type);
    List<ContentVo> findAll();
    ContentVo findById(String id);
    void updatePublished(@org.apache.ibatis.annotations.Param("id") String id,
                         @org.apache.ibatis.annotations.Param("isPublished") int isPublished);
    void update(ContentVo content);
    void delete(String id);
}