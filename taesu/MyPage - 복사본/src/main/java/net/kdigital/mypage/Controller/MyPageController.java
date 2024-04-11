package net.kdigital.mypage.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {

	@GetMapping("/myPage")
	public String myPage() {
		return "myPage";
	}
	
	@GetMapping("/myPageEdit")
	public String myPageEdit() {
		return "myPageEdit";
	}

	@GetMapping("/myFavCompany")
	public String myFavCompany() {
		return "myFavCompany";
	}
}
