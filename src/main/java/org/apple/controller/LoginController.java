package org.apple.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.apple.dto.LoginDTO;
import org.apple.dto.MemberDTO;
import org.apple.service.LoginService;
import org.apple.util.MailInfo;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private Util util;
	
	//get /login
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		//System.out.println("id: " + id + " / pw : " + pw);
		LoginDTO loginDTO = new LoginDTO();
		loginDTO.setId(id);
		loginDTO.setPw(pw);
		
		LoginDTO login = loginService.login(loginDTO);
		if(login.getCount() == 1 && login.getMcount() < 5) {
			//진정한 로그인
			if(login.getPw().equals(loginDTO.getPw())) { //비밀번호 비교..
				//세션만들기
				HttpSession session = request.getSession();
				session.setAttribute("mid", id);
				session.setAttribute("mname", login.getMname());
				//해당 id의 mcount를 1로 만들기
				loginService.mcountReset(loginDTO);
				return "redirect:/index"; //정상 로그인
			} else { //비번틀린거
				//mcountUp
				loginService.mcountUp(loginDTO);
				return "redirect:/login?count="+login.getMcount();
			}
		} else {
			//잘못된 로그인일 경우 로그인 창으로 이동하기 = 5번 시도했으면 잠그기.
			//해당 id의 mcount를 +1 시키기
			loginService.mcountUp(loginDTO); //원랜 id만 들어가면 되니까 귀찮으니까~ // int result로 잡아도 되지만 크게 의미 없을거같다고,,
			return "redirect:/login?count="+login.getMcount();
		}
		
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		if(session.getAttribute("mid") != null) {
			session.removeAttribute("mid");
		}
		if(session.getAttribute("mname") != null) {
			session.removeAttribute("mname");
		}
		session.invalidate();
		
		return "redirect:/login";
	}
	
	//http://172.30.1.21/myInfo@hachu
	//http://172.30.1.21/detail?no=456 -> path variable 쓰면 이 모양이
	// http://172.30.1.21/detail/456 -> 이 모양이 될 수 있다.
	// http://172.30.1.21/detail/{no}/{pageNo}
	@GetMapping("/myInfo@{id}") //id를 변수로 쓸거야~ 라는 뜻
	public String myInfo(@PathVariable("id") String id) throws EmailException {
		//System.out.println("id: " + id);
		// 로그인 했어?
		if(util.getSession().getAttribute("mid") != null) {
			
			//인증 요청하기 = ajax용으로 빼두기 (요청하기 누르면 인증번호 입력화면 나오게)
			//loginService.myInfo();
			
			return "myinfo";
		} else {
			return "redirect:/login?error=error";
		}
	}
}
