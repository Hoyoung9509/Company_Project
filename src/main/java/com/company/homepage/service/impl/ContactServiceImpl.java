package com.company.homepage.service.impl;

import com.company.homepage.repository.ContactRepository;
import com.company.homepage.service.ContactService;
import com.company.homepage.vo.ContactVo;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ContactServiceImpl implements ContactService {

    private final ContactRepository contactRepository;

    @Override
    public void submit(ContactVo contact) {
        contactRepository.insert(contact);
    }

    @Override
    public List<ContactVo> findAll() {
        return contactRepository.findAll();
    }

    @Override
    public ContactVo findById(Long id) {
        return contactRepository.findById(id);
    }

    @Override
    public void delete(Long id) {
        contactRepository.delete(id);
    }
}