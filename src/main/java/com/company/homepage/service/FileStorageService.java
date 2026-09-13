package com.company.homepage.service;

import org.springframework.web.multipart.MultipartFile;

public interface FileStorageService {
    String store(MultipartFile file, String subDir);
    void delete(String publicUrl);
}
