package org.apple.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apple.dto.BoardDTO;
import org.apple.dto.CommentDTO;
import org.apple.dto.SearchDTO;
import org.apple.dto.WriteDTO;
import org.apple.service.BoardService;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class BoardController {
	//1. 엔터키 처리 / /글쓰기 /댓글쓰기
	//2. 로그인 처리 / /글쓰기 /댓글쓰기
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private Util util;

	//@GetMapping("/index")
	@GetMapping({"/", "/index"})
	public String index() {
		//System.out.println("메인 아이피: " + request.getRemoteAddr());
		return "index";
	}
	
	//페이징 추가하기 2024-02-20 psd
	@GetMapping("/board")
	public String board(
			@RequestParam(value = "pageNo", required = false) String no, 
			@RequestParam(value="search", required=false) String search, 
			Model model) {
		
		//System.out.println("검색어: " + search);
		
		//pageNo가 오지 않는다면
		int currentPageNo = 1;
		if(util.str2Int(no) > 0) { //운영하다보면 여기 수정해야함. 정수..?
			currentPageNo = Integer.parseInt(no);
		}
		
		//int totalRecordCount 전체 글 수
		int totalRecordCount = boardService.totalRecordCount(search); // 검색 건수에 대한 페이징을 해야해서
		System.out.println("총 게시글 수 : " + totalRecordCount);
		//pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);//현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totalRecordCount); //전체 게시물 건수
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex()); // paginationInfo가 계산해서 준 값.
		searchDTO.setSearch(search);
		
		List<BoardDTO> list = boardService.boardList(searchDTO);
		model.addAttribute("list", list);
		//페이징 관련 정보가 있는 PaginationInfo 객체를 모델에 반드시 넣어준다.
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("pageNo", currentPageNo);
		model.addAttribute("search", search);
		return "board";
	}
	//2024-02-16 웹표준 기술 psd
	@GetMapping("/detail")
	public String detail(@RequestParam(value = "no", defaultValue = "10") String no, Model model) {
		//오는 no잡기 -> int로 바꾸기(util)
		//String no = request.getParameter("no");
		//System.out.println(util.str2Int(no)); //숫자면 자신의 숫자, 문자면 0
		int reNo = util.str2Int(no);
		if(reNo != 0) {
			//0이 아님 = 정상접근 : DB에 물어보기 / 값 가져오기 / 붙이기
			BoardDTO detail = boardService.detail(reNo); //DTO -> 전통적인 방법으로 해야해서
			model.addAttribute("detail", detail);
			//2024-02-19 psd 댓글도 뽑기
			//System.out.println("댓글 수 : " + detail.getComment());
			if(detail.getComment() > 0) {
				List<CommentDTO> commentList = boardService.commentList(reNo);
				model.addAttribute("commentList", commentList);
				//System.out.println(commentList.get(0).getMname());
			}
			
			return "detail";
		} else {
			//0임 = 비정상 : 에러로 페이지 이동하기
			//return "error/error"; //에러 폴더 안의 error.jsp
			return "redirect:/error"; //controller 어딘가에 있는 error매핑을 실행해 라는 뜻
		}
	}
	@GetMapping("/write")
	public String write() {
		
		//return "write";
		return "redirect:/login?error=2048";
	}
	
	//글쓰기 2024-02-16
	@PostMapping("/write") //내용 + 제목 받아요 -> db에 저장 -> 보드로
	public String write(HttpServletRequest request, WriteDTO dto) {
		System.out.println(dto.getTitle());
		System.out.println(dto.getContent());
		
		HttpSession session = util.getSession();
		if(session.getAttribute("mid") != null) {
			int result = boardService.write(dto); //지금은 영향받은 행으로 쓰다가 나중에는 pkey?값을 받을 것 (db 몇번째로 저장된 글인지)
			if(result == 1) {
				System.out.println("글쓰기 결과 : " + result + " / " + request.getRemoteAddr());
				return "redirect:detail?no="+dto.getBoard_no();
			} else {
				System.out.println("글쓰기 결과 : " + result + " / " + request.getRemoteAddr());
				return "redirect:/error";
			}
		} else {
			return "redirect:/login";
		}
		//추후 세션관련 작업을 더 해야 합니다.
		//return "redirect:/board"; //바로 자기가 쓴 글 보려면 동적쿼리 써야해서 나중에 (=> selectKey로 했다)
	}
	
	//댓글쓰기 2024-02-19 psd == 글번호 no, 댓글내용 comment, 글쓴이
	@PostMapping("/commentWrite")
	public String commentWrite(CommentDTO comment) {
		if(util.getSession().getAttribute("mid") != null) {
			//HttpSession session = request.getSession();
			//comment.setMid(String.valueOf(session.getAttribute("mid")));
			int result = boardService.commentWrite(comment);
			if(result == 1) {
				System.out.println("댓글쓰기 결과 : " + result);
				return "redirect:/detail?no="+comment.getNo();
			} else {
				return "redirect:/error";
			}
		} else {
			return "redirect:/login?error='로그인 하셔야 합니다'";
		}
	}
	
	@PostMapping("/postDel")
	public String postDel(@RequestParam("no") int no) {
		//로그인 여부
		if(util.getSession().getAttribute("mid") != null) {
			//System.out.println("no : " + no);
			int result = boardService.postDel(no);
			System.out.println("포스트 삭제 결과 : " + result);
			return "redirect:/board";
		} else {
			return "redirect:/login";
		}
	}
	
	//댓글 삭제 2024-02-21 psd == 댓글 번호 + 글번호(다시 그 글로 돌아가) + mid(얘는 service에서 넣기)
	@GetMapping("/deleteComment")
	public String deleteComment(@RequestParam("no") int no, @RequestParam("cno") int cno) {
		//System.out.println("no : " + no);
		//System.out.println("cno : " + cno);
		
		int result = boardService.deleteComment(no, cno);
		//System.out.println("댓글 삭제 결과: " + result);
		
		return "redirect:/detail?no="+no;
	}
	
	//2024-02-22 요구사항 확인 psd
	//선생님은 get방식으로 다시 내 글로 돌아가는 메서드
	@GetMapping("/likeUp") // util에 숫자 체크하는 메서드
	public String likeUp(@RequestParam("no") String no, @RequestParam("cno") String cno) {
		if(util.checkInt(no) && util.checkInt(cno)) {
			CommentDTO dto = new CommentDTO();
			dto.setBoard_no(util.str2Int2(no));
			dto.setNo(util.str2Int2(cno));
			
			int result = boardService.likeUp(dto);
			
			return "redirect:/detail?no="+dto.getBoard_no();
		} else {
			return "redirect:/error";
		}
	}
	//ajax post로 해볼 것
	@PostMapping("/clikeUp")
	public @ResponseBody int clikeUp(@RequestParam("no") int no,@RequestParam("cno") int cno) { //board_no=no, cno=cno
		CommentDTO dto = new CommentDTO();
		dto.setBoard_no(no);
		dto.setNo(cno);
		int clike = boardService.clikeReturn(dto);
		if(util.getSession().getAttribute("mid") != null) { //아이디 당 좋아요 하나만 올라가게 하려면 visitcount처럼 테이블 따로 만들어야. 
			boardService.clikeUp(dto);
			// 성공하면 like 숫자도 되돌려주기.. 성공 안해도 돌려줄까
			clike = boardService.clikeReturn(dto);
			return clike;
		} else {
			return clike;
		}
	}
	
}
