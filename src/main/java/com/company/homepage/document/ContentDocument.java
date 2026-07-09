package com.company.homepage.document;

import lombok.Data;
import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

@Data
@Document(indexName = "company_content")
public class ContentDocument {

    @Id
    private String id;

    @Field(type = FieldType.Keyword)
    private String type;

    @Field(type = FieldType.Text, analyzer = "standard")
    private String title;

    @Field(type = FieldType.Text, analyzer = "standard")
    private String body;

    @Field(type = FieldType.Boolean)
    private boolean published;

    @Field(type = FieldType.Keyword)
    private String createdAt;
}
