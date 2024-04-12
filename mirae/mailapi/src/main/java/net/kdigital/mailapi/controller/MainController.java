package net.kdigital.mailapi.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.kdigital.mailapi.dto.MailDTO;
import net.kdigital.mailapi.service.MailService;

@Controller
@RequiredArgsConstructor
@Slf4j
public class MainController {
	
	
	@GetMapping({"","/"})
	public String index() {
		return "index";
		
	}
	
	

}
