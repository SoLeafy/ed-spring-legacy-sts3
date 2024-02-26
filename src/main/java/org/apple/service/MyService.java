package org.apple.service;

import javax.servlet.http.HttpSession;

import org.apple.dao.MyDAO;
import org.apple.dto.MyDTO;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MyService extends AbstractService {

	@Autowired
	private MyDAO myDAO;
	
	public int updateProfile(MyDTO dto) {
		return myDAO.updateProfile(dto);
	}

	public MyDTO getProfile() {
		MyDTO dto = new MyDTO();
		HttpSession session = util.getSession();
		dto.setId(String.valueOf(session.getAttribute("mid")));
		return myDAO.getProfile(dto);
	}
}
