package com.company.homepage.vo;

import lombok.Data;

@Data
public class ContentVo {
    private String id;
    private String type;
    private String title;
    private String body;
    private String mediaUrl;
    private int isPublished;
    private String createdAt;

    public String getTypeLabel() {
        if (type == null) return "";
        switch (type) {
            case "SERVICE": return "서비스";
            case "CAREER": return "채용";
            case "NOTICE_PUBLIC": return "뉴스";
            case "NOTICE_INTERNAL": return "사내공지";
            case "WORK": return "작업물";
            case "ABOUT": return "회사소개";
            default: return type;
        }
    }

    public String getYoutubeId() {
        if (mediaUrl == null) return null;
        java.util.regex.Matcher m = java.util.regex.Pattern
                .compile("(?:youtu\\.be/|youtube\\.com/(?:watch\\?v=|embed/))([\\w-]{11})")
                .matcher(mediaUrl);
        return m.find() ? m.group(1) : null;
    }
}