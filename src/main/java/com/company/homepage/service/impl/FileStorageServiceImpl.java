package com.company.homepage.service.impl;

import com.company.homepage.service.FileStorageService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Set;
import java.util.UUID;

@Service
public class FileStorageServiceImpl implements FileStorageService {

    private static final Set<String> ALLOWED_CONTENT_TYPES = Set.of("image/jpeg", "image/png");
    private static final String UPLOAD_URL_PREFIX = "/uploads/";

    @Value("${app.upload.dir}")
    private String uploadDir;

    @Override
    public String store(MultipartFile file, String subDir) {
        String contentType = file.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType)) {
            throw new IllegalArgumentException("이미지는 JPG 또는 PNG 파일만 업로드할 수 있습니다.");
        }
        String extension = "image/png".equals(contentType) ? ".png" : ".jpg";
        String filename = UUID.randomUUID() + extension;
        try {
            Path dir = Paths.get(uploadDir, subDir);
            Files.createDirectories(dir);
            file.transferTo(dir.resolve(filename));
        } catch (IOException e) {
            throw new RuntimeException("파일 저장에 실패했습니다.", e);
        }
        return UPLOAD_URL_PREFIX + subDir + "/" + filename;
    }

    @Override
    public void delete(String publicUrl) {
        if (publicUrl == null || !publicUrl.startsWith(UPLOAD_URL_PREFIX)) {
            return;
        }
        try {
            Path path = Paths.get(uploadDir, publicUrl.substring(UPLOAD_URL_PREFIX.length()));
            Files.deleteIfExists(path);
        } catch (IOException ignored) {
            // best-effort cleanup only
        }
    }
}
