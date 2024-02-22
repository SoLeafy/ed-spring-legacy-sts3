package org.apple.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ErrorController {
	
	
	//		/error
	@GetMapping("/error")
	public String error() {
		return "error/error";	//	servlet-context.jsp에 적혀있다.	/WEB-INF/views/error/error.jsp
	}
}
