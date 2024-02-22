package org.apple.util;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

// controller, service, repository 이외의 기능 = component
// 얘 역시 autowired로 쓴다.
@Component
public class Util {
	
	public int str2Int(String str) {
		try {
			return Integer.parseInt(str); //123A
		} catch (Exception e) {
			return 0;
		}
	}
	
	public int str2Int2(String str) {
//		int result = 0;
//		
//		StringBuilder sb = new StringBuilder();
//		for(int i = 0; i < str.length(); i++) {
//			if(Character.isDigit(str.charAt(i))) {
//				sb.append(str.charAt(i));
//			}
//		}
//		
//		if(sb.length() > 0) {
//			result = Integer.parseInt(sb.toString());
//		}
		int result = Integer.parseInt(str);
		
		return result;
	}
	
	//2024-02-21 psd 웹표준
	//HttpServletRequest와 HttpSession을 매번 controller 메서드 파라미터로 넣기 힘드니까 그거 만들어주는 메소드 만들기
	//인터넷 검색하면 나온다. 이렇게 하면 현재 접속한 사람 request가 나옴.
	public HttpServletRequest req() {
		ServletRequestAttributes sra = 
				(ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		return request;
	}
	
	public HttpSession getSession() {
		HttpSession session = req().getSession();
		return session;
	}
	
	//ip
	public String getIp() {
		HttpServletRequest request = req();
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");   
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if(ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if(ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	//숫자인지 검사하는 메소드
	public boolean checkInt(String str) {
		try {
			Integer.parseInt(str);
			return true;
		} catch(Exception e) {
			return false;
		}
	}
	
	public void sendEmail(String email, String key) throws EmailException {
		//mail 보내기 -> 지금은 controller에다 치지만 util로 보낼 것.
		String emailAddr = MailInfo.emailId;//이메일 주소 MailInfo.emailId <- 여기 변수로 보내는 사람 이메일주소
		String name = "하츄초콜릿";//이름
		String passwd = MailInfo.emailPw;//암호 MailInfo.emailPw
		String hostName ="smtp-mail.outlook.com"; //SMTP server name
		int port = 587; //포트 번호
		
		SimpleEmail simpleEmail = new SimpleEmail(); // 전송할 메일
		simpleEmail.setCharset("UTF-8"); //언어셋 설정
		simpleEmail.setDebug(true); //화면 상에 메일 잘 가고 있는지 보여줌
		simpleEmail.setHostName(hostName);
		simpleEmail.setAuthentication(emailAddr, passwd);
		simpleEmail.setSmtpPort(port);
		simpleEmail.setStartTLSEnabled(true); //startTLS로 암호화하고 있다
		simpleEmail.setFrom(emailAddr, name);
		simpleEmail.addTo(email); //받는 사람 (우리 사이트에 가입한 회원)
		simpleEmail.setSubject("하츄초콜릿 인증번호입니다."); //제목
		simpleEmail.setMsg("인증번호는 [" + key + "] 입니다"); //본문 내용 text (우리 상황에선 text)
		simpleEmail.send(); //전송하기
	}

	public String createKey() {
		Random random = new Random();
		random.setSeed(System.currentTimeMillis()); //컴퓨터가 뽑는 숫자들이 진짜 랜덤하지 않고 비슷비슷해서.. 진짜 랜덤하도록(?)
		String key = random.nextInt(10) + "" + random.nextInt(10) + random.nextInt(10) + random.nextInt(10);
		return key;
	}
	
}
