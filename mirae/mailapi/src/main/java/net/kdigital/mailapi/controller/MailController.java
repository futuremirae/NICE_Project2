package net.kdigital.mailapi.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.kdigital.mailapi.dto.MailDTO;
import net.kdigital.mailapi.service.MailService;

@RestController
@RequiredArgsConstructor
@Slf4j
public class MailController {
	private final MailService mailService;
	@PostMapping("/mail")
	public String sendMail(MailDTO mailDTO) {
		//mailSer
		log.info("하이룽가 에불ㄹ하");
		log.info(mailDTO.toString());
		mailService.mailSend(mailDTO);
		return "redirect:/";
	}
	

}
