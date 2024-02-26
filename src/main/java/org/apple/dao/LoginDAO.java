package org.apple.dao;

import org.apple.dto.LoginDTO;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO extends AbstractDAO {
	
	public LoginDTO login(LoginDTO dto) {
		return sqlSession.selectOne("login.login", dto);
	}

	public void mcountUp(LoginDTO dto) {
		sqlSession.update("login.mcountUp", dto);
	}

	public void mcountReset(LoginDTO dto) {
		sqlSession.update("login.mcountReset", dto);
	}

	public String getEmail(String id) {
		return sqlSession.selectOne("login.getEmail", id);
	}
}
