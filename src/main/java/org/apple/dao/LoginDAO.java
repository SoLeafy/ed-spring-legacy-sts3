package org.apple.dao;

import org.apple.dto.LoginDTO;
import org.apple.dto.MemberDTO;
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

	public int join(MemberDTO join) {
		return sqlSession.insert("login.join", join);
	}

	public int checkId(String id) {
		return sqlSession.selectOne("login.checkId", id);
	}

	public int checkEmail(String email) {
		return sqlSession.selectOne("login.checkEmail", email);
	}
}
