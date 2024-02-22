package org.apple.dao;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.LoginDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDAO {

	@Autowired
	private SqlSession sqlSession;
	
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
