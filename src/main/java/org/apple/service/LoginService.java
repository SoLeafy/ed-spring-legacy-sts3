package org.apple.service;

import org.apple.dao.LoginDAO;
import org.apple.dto.LoginDTO;
import org.apple.dto.MemberDTO;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService extends AbstractService {
	@Autowired
	private LoginDAO loginDAO;

	public LoginDTO login(LoginDTO dto) {
		return loginDAO.login(dto);
	}

	public void mcountUp(LoginDTO loginDTO) {
		loginDAO.mcountUp(loginDTO);
	}

	public void mcountReset(LoginDTO dto) {
		loginDAO.mcountReset(dto);
	}

	public String getEmail(String id) {
		return loginDAO.getEmail(id);
	}

	//email과 key... 하다 말아버렸구나
	public void setKey(MemberDTO dto) {
		String email = getEmail(String.valueOf(util.getSession().getAttribute("mid")));
		//인증번호 생성
		String key = util.createKey();
		dto.setMemail(email);
		dto.setMkey(key);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		//loginDAO.setKey(dto);
	}

	public void myInfo() {
		String email = getEmail(String.valueOf(util.getSession().getAttribute("mid")));
		//인증번호 생성
		String key = util.createKey();
		
		MemberDTO dto = new MemberDTO();
		dto.setMemail(email);
		dto.setMkey(key);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		//setKey(dto);
		
		//util.sendEmail(email, key);
		//System.out.println("key: " + key);
	}

	public int join(MemberDTO join) {
		return loginDAO.join(join);
	}

	public int checkId(String id) {
		return loginDAO.checkId(id);
	}

	public int checkEmail(String email) {
		return loginDAO.checkEmail(email);
	}

}
