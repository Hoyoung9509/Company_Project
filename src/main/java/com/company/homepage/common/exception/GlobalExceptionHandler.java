package com.company.homepage.common.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.multipart.MaxUploadSizeExceededException;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public String handleMaxUploadSize(HttpServletRequest request) {
        String uri = request.getRequestURI();
        String separator = uri.contains("?") ? "&" : "?";
        return "redirect:" + uri + separator + "error=fileTooLarge";
    }
}
