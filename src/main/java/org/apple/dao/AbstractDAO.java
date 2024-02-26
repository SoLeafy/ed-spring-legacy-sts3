package org.apple.dao;
//부모 형태로 존재하게 할 것.
//@없다. (@Repository 없다)
//2024-02-26 psd

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class AbstractDAO {
	
	@Autowired
	SqlSession sqlSession;
	
}
