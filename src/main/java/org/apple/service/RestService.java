package org.apple.service;

import org.apple.dao.RestDAO;
import org.apple.dto.MemberDTO;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RestService extends AbstractService {
	@Autowired
	private RestDAO restDAO;

	public int sendEmail() {
		//로그인검사 controller 말고 service에서
		if(util.getSession().getAttribute("mid") != null) {
			//메일 발송 + key 데이터베이스에 저장
			String email = getEmail(String.valueOf(util.getSession().getAttribute("mid")));
			//인증번호 생성
			String key = util.createKey();
			
			MemberDTO dto = new MemberDTO();
			dto.setMemail(email);
			dto.setMkey(key);
			dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
			restDAO.setKey(dto); //db에 키 저장하기
			
			//util.sendEmail(email, key);
			//System.out.println("key: " + key);
			return 1;
		} else {
			return 0;
		}
	}
	//sendEmail()에서 쓸려고 만든...
	private String getEmail(String id) {
		return restDAO.getEmail(id);
	}

}
