package org.apple.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apple.dao.BoardDAO;
import org.apple.dto.BoardDTO;
import org.apple.dto.CommentDTO;
import org.apple.dto.WriteDTO;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private Util util;
	
	public List<BoardDTO> boardList(int pageNo) {
		return boardDAO.boardList(pageNo);
	}

	public BoardDTO detail(int no) {
		//문자? util에 숫자로 변경해주는 메소드 쓰기 (앞에서 이미 정수로 하면 여기서 이런거 안써도 된다.)
		//웬만하면 모든 로직은 service에 쓰라고 하지만 Controller에 써둔거 가져온다.
		
		//2024-02-22 psd 요구사항 확인
		//로그인 했어? -> 읽음 수 올리기
		if (util.getSession().getAttribute("mid") != null) {
			//DTO 객체 만들기 = 번호 + 아이디
			BoardDTO dto = new BoardDTO();
			dto.setBoard_no(no);
			dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
			//이미 읽은 사람은 조회수 안 올리기
			//int result = boardDAO.alreadyRead(dto);
			//if(result == 0)
			boardDAO.viewCount(dto);
		}
		
		return boardDAO.detail(no);
	}

	public int write(WriteDTO dto) {
		//엔터키 처리
		dto.setContent(dto.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		dto.setIp(util.getIp());
		return boardDAO.write(dto);
	}

	public int commentWrite(CommentDTO comment) {
		// 댓글 내용 + 글번호 + mid
		// 엔터키 처리
		comment.setComment(comment.getComment().replaceAll("(\r\n|\r|\n|\n\r)", "<br>"));
		comment.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		comment.setCip(util.getIp());
		return boardDAO.commentWrite(comment);
	}

	public List<CommentDTO> commentList(int no) {
		return boardDAO.commentList(no);
	}

	public int postDel(int no) { //글번호 + mid = 자신의 글만 삭제하게 하기 위해서
		// mid와 no는 따로 가도 되지만, 둘다 넣을 수 있는 DTO를 사용 (WriteDTO)
		WriteDTO dto = new WriteDTO();
		dto.setBoard_no(no);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		return boardDAO.postDel(dto);
	}

	public int totalRecordCount() {
		return boardDAO.totalRecordCount();
	}

	public int deleteComment(int no, int cno) {
		CommentDTO dto = new CommentDTO();
		dto.setNo(cno);
		dto.setBoard_no(no);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		return boardDAO.deleteComment(dto);
	}

	public int clikeUp(CommentDTO dto) {
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		return boardDAO.clikeUp(dto);
	}

	public int likeUp(CommentDTO dto) {
		return boardDAO.likeUp(dto);
	}

	public int clikeReturn(CommentDTO dto) {
		return boardDAO.clikeReturn(dto);
	}


}
