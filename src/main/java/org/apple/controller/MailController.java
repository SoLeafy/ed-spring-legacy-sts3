package org.apple.controller;

import org.apache.commons.mail.EmailException;
import org.apple.service.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

//20240223 요구사항확인
@Controller
public class MailController {
	@Autowired
	private MailService mailService;
	//제작순서
	//menu에다가 추가 -> Controller(기존 컨트롤러 혹은 새 컨트롤러에) -> jsp -> 화면구성 -> service~
	@GetMapping("/mail")
	public String mail() {
		//로그인한 사용자만 접근가능
		return "mail";
	}
	//jsp -> Controller -> Service(여기까지만 가기. DB 안가도됨) 메일발송
	@PostMapping("/mail")
	public String mail(@RequestParam("email") String email, 
			@RequestParam("title") String title, @RequestParam("content") String content) throws EmailException { //나중에 Map으로 받는 거 배울 것.(DTO도 썼었지..) 일일이 적는 법도 있고 request.getParameter()도 있고...

		//mailService.sendTextMail(email, title, content);
		mailService.sendHTMLMail(email, title, content);
		return "redirect:/mail"; //get방식으로 돌아가게
	}
}
