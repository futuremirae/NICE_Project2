package net.kdigital.mailapi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.kdigital.mailapi.dto.MailDTO;

@Service
@RequiredArgsConstructor 
@Slf4j
public class MailService {
	private JavaMailSender mailSender;
	//private static final String From_ADDRESS= "mirae1296@gmail.com";

//	 public MailService(JavaMailSender mailSender) {
//	        this.mailSender = mailSender;
//	    }
	
	 @Autowired
	    public MailService(JavaMailSender mailSender) {
	        this.mailSender = mailSender;
	    }
	
	 @Value("${spring.mail.username}")
	 String username;
	public void mailSend(MailDTO mailDTO) {
		log.info("하ㅓㅓㅜㄹㄴ알눌노ㅓㅏ~~~~~~~~~~"+username);
		
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(mailDTO.getAddress());
		message.setFrom(username);
        message.setSubject(mailDTO.getTitle());
        message.setText(mailDTO.getMessage());
        log.info("###########"+message.toString());
        mailSender.send(message);
		
		
	}

}
