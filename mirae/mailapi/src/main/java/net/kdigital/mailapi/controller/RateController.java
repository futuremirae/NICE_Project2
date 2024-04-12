package net.kdigital.mailapi.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.kdigital.mailapi.service.ExchangeRateService;


@Controller
@RequiredArgsConstructor
@Slf4j
public class RateController {
	private final ExchangeRateService rateService;
	
	@GetMapping("/rate")
	public String rate() {
		Map<String, Double> result =rateService.restTest();
		//log.info("결과값 출력: "+ result);
		return "rate";
	}
	
	

}
