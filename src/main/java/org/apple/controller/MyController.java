package org.apple.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apple.dto.MyDTO;
import org.apple.service.MyService;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MyController {
	
	@Autowired
	private MyService myService;
	
	@Autowired
	private Util util;
	
	@GetMapping("/profile")
	public String profile() {
		if(util.getSession().getAttribute("mid") != null) {
			return "profile";
		} else {
			return "redirect:/login";
		}
	}
	
	@PostMapping("/getProfile")
	public @ResponseBody String getProfile() {
		MyDTO dto = myService.getProfile();
		String profile = dto.getProfile();
		return profile;
	}
	
	@PostMapping("/profile")
	public String updateProfile() {
		HttpSession session = util.req().getSession();
		MyDTO dto = new MyDTO();
		//System.out.println(session.getAttribute("mid"));
		if(!session.getAttribute("mid").equals(null)) {
			//System.out.println((String) session.getAttribute("mid"));
			//System.out.println(request.getParameter("profile"));
			String profile = util.req().getParameter("profile");
			profile = profile.substring(3, profile.length()-8);
			dto.setId((String) session.getAttribute("mid"));
			dto.setProfile(profile);
			int result = myService.updateProfile(dto);
			System.out.println("프로필 등록 결과 : " + result);
		}
		return "redirect:/profile";
	}
	
	@PostMapping("/revisedProfile")
	public String reviseProfile() {
		HttpSession session = util.req().getSession();
		MyDTO dto = new MyDTO();
		//System.out.println(session.getAttribute("mid"));
		if(!session.getAttribute("mid").equals(null)) {
			//System.out.println((String) session.getAttribute("mid"));
			//System.out.println(request.getParameter("profile"));
			String profile = util.req().getParameter("profile");
			dto.setId((String) session.getAttribute("mid"));
			dto.setProfile(profile);
			int result = myService.updateProfile(dto);
			System.out.println("프로필 등록 결과 : " + result);
		}
		return "redirect:/profile";
	}
}
