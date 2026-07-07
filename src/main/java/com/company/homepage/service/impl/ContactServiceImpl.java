package com.company.homepage.service.impl;

import com.company.homepage.repository.ContactRepository;
import com.company.homepage.service.ContactService;
import com.company.homepage.vo.ContactVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ContactServiceImpl implements ContactService {

    private final ContactRepository contactRepository;

    @Override
    public void submit(ContactVo contact) {
        contactRepository.insert(contact);
    }
}