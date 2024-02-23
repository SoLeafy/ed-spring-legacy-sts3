package org.apple.service;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.SimpleEmail;
import org.apple.util.MailInfo;
import org.springframework.stereotype.Service;

@Service
public class MailService {

	//메일 보내기
	public void sendTextMail(String email, String title, String content) throws EmailException {
		String emailAddr = MailInfo.emailId; //보내는 사람 이메일 = outlook
		String name = "하츄초콜릿"; //보내는 사람 이름
		String pw = MailInfo.emailPw; //보내는 사람 비번 = outlook 만든거
		String host = "smtp-mail.outlook.com"; //아웃룩 호스트
		int port = 587; //아웃룩 포트
		
		SimpleEmail mail = new SimpleEmail(); //여기다 조립
		mail.setCharset("UTF-8"); //언어셋 인코딩
		mail.setDebug(true); //디버그 - 이유는 잘 몰라도 결과 보기위해 적어주자
		mail.setHostName(host); //호스트 = 아웃룩(보내는사람꺼)
		mail.setAuthentication(emailAddr, pw);//보내는 사람 이메일주소, 비번
		mail.setSmtpPort(port);//보내는 쪽의 포트
		mail.setStartTLSEnabled(true);
		mail.setFrom(emailAddr, name); //보내는 사람의 주소, 이름 -> EmailException throw해주자 (이 메서드 호출한 Controller가 에러 -> 걔도 던지자)
		mail.addTo(email); //받는 사람 === 파라미터로 받은거
		mail.setSubject(title); //메일 제목 === 파라미터로 받은거
		mail.setMsg(content); //메일 내용 === 파라미터로 받음~
		mail.send(); //발송
		
	}

	public void sendHTMLMail(String email, String title, String content) throws EmailException {
		String emailAddr = MailInfo.emailId; //보내는 사람 이메일 = outlook
		String name = "하츄초콜릿"; //보내는 사람 이름
		String pw = MailInfo.emailPw; //보내는 사람 비번 = outlook 만든거
		String host = "smtp-mail.outlook.com"; //아웃룩 호스트
		int port = 587; //아웃룩 포트
		
		HtmlEmail mail = new HtmlEmail();
		mail.setCharset("UTF-8"); //언어셋 인코딩
		mail.setDebug(true); //디버그 - 이유는 잘 몰라도 결과 보기위해 적어주자
		mail.setHostName(host); //호스트 = 아웃룩(보내는사람꺼)
		mail.setAuthentication(emailAddr, pw);//보내는 사람 이메일주소, 비번
		mail.setSmtpPort(port);//보내는 쪽의 포트
		mail.setStartTLSEnabled(true);
		mail.setFrom(emailAddr, name); //보내는 사람의 주소, 이름 -> EmailException throw해주자 (이 메서드 호출한 Controller가 에러 -> 걔도 던지자)
		mail.addTo(email); //받는 사람 === 파라미터로 받은거
		mail.setSubject(title); //메일 제목 === 파라미터로 받은거
		mail.setMsg(content); //메일 내용 === 파라미터로 받음~
		
		//파일 첨부도 가능
		EmailAttachment file = new EmailAttachment();
		file.setPath("c:\\temp\\img.png");
		mail.attach(file);
		
		mail.send(); //발송
	}

}
