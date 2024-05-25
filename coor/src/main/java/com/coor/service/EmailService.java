package com.coor.service;

import com.coor.dto.EmailDTO;

public interface EmailService {
   void sendMail(EmailDTO dto, String content);
}
