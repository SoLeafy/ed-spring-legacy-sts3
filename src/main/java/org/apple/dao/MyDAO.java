package org.apple.dao;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.MyDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyDAO {

	@Autowired
	private SqlSession sqlSession;
	
	public int updateProfile(MyDTO dto) {
		return sqlSession.update("member.updateProfile", dto);
	}

	public MyDTO getProfile(MyDTO dto) {
		return sqlSession.selectOne("member.getProfile", dto);
	}
}
