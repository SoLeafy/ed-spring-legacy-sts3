package org.apple.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.BoardDTO;
import org.apple.dto.MemberDTO;
import org.apple.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDAO {
	@Autowired
	private SqlSession sqlSession;
	
	public List<BoardDTO> adminBoardList(SearchDTO dto) {
		return sqlSession.selectList("admin.boardList", dto);
	}

	public int totalRecordCount(SearchDTO dto) {
		return sqlSession.selectOne("admin.totalRecordCount", dto);
	}

	public int totalMemberCount(String search) {
		return sqlSession.selectOne("admin.totalMemberCount", search);
	}

	public List<MemberDTO> memberList(SearchDTO searchDTO) {
		return sqlSession.selectList("admin.memberList", searchDTO);
	}

	public int postDel(BoardDTO dto) {
		return sqlSession.update("admin.postDel", dto);
	}

	public int findDel(int no) {
		return sqlSession.selectOne("admin.findDel", no);
	}

	public BoardDTO adminDetail(int no) {
		return sqlSession.selectOne("admin.detail", no);
	}
}
