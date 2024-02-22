package org.apple.dao;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RestDAO {
	@Autowired
	private SqlSession sqlSession;

	public String getEmail(String id) {
		return sqlSession.selectOne("rest.getEmail", id);
	}

	public void setKey(MemberDTO dto) {
		sqlSession.update("rest.setKey", dto);
	}
}
