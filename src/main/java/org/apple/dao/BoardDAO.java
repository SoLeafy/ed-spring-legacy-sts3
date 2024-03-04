package org.apple.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.BoardDTO;
import org.apple.dto.CommentDTO;
import org.apple.dto.SearchDTO;
import org.apple.dto.WriteDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO extends AbstractDAO {

	public List<BoardDTO> boardList(int pageNo) {
		return sqlSession.selectList("board.boardList", pageNo);
	}

	public BoardDTO detail(int no) {
		return sqlSession.selectOne("board.detail", no);
	}

	public int write(WriteDTO dto) {
		return sqlSession.insert("board.write", dto);
	}

	public int commentWrite(CommentDTO comment) {
		return sqlSession.insert("board.commentWrite", comment);
	}

	public List<CommentDTO> commentList(int no) {
		return sqlSession.selectList("board.commentList", no);
	}

	public int postDel(WriteDTO dto) {
		return sqlSession.update("board.deletePost", dto);
	}

	public int totalRecordCount(String search) {
		return sqlSession.selectOne("board.totalRecordCount", search);
	}
	
	public int totalRecordCount() {
		return sqlSession.selectOne("board.totalRecordCount2");
	}

	public int deleteComment(CommentDTO dto) {
		return sqlSession.update("board.deleteComment", dto);
	}

	public int viewCount(BoardDTO dto) {
		return sqlSession.insert("board.viewCount", dto);
	}

	public int alreadyRead(BoardDTO dto) {
		return sqlSession.selectOne("board.viewCheck", dto);
	}

	public int clikeUp(CommentDTO dto) {
		return sqlSession.update("board.clikeUp", dto);
	}

	public int likeUp(CommentDTO dto) {
		return sqlSession.update("board.likeUp", dto);
	}

	public int clikeReturn(CommentDTO dto) {
		int result = sqlSession.selectOne("board.clikeReturn", dto);
		return result;
	}

	public List<BoardDTO> boardList(SearchDTO dto) {
		return sqlSession.selectList("board.boardListSearch", dto);
	}

}
