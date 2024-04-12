package net.kdigital.mailapi.controller;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.kdigital.mailapi.dto.InputKeywordDTO;
import net.kdigital.mailapi.service.CosineService;


@Controller
@RequiredArgsConstructor
@Slf4j
public class CosineController {
	private final CosineService service; 
	
	@GetMapping("/search")
	public String searchProduct() {
		return "cosine";
	}
	
	@PostMapping("/predict")
	@ResponseBody
	public  List<Map<String, Object>>  searchProduct(@ModelAttribute InputKeywordDTO inputkeyword) {
		
		log.info(inputkeyword.toString());// 사용자가 입력한 값 
		List<Map<String, Object>> result = service.predictRest(inputkeyword);
		log.info("ajax로 넘길거");// 사용자가 입력한 값 
		return result;
		
	}

	

}
