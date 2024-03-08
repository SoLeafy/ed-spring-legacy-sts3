package org.apple.controller;

import java.io.Reader;
import java.util.List;

import javax.annotation.Resource;

import org.apple.dto.BoardDTO;
import org.apple.dto.MemberDTO;
import org.apple.dto.SearchDTO;
import org.apple.service.AdminService;
import org.apple.util.Util;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

//administrator = admin
//root
@Controller
@RequestMapping("/admin") // 겹치는 /admin을 위로 빼준거.
public class AdminController {
	@Resource(name="adminService")
	private AdminService adminService;
	@Autowired
	private Util util;
	
	// http://localhost/web/admin/index (web은 context. 패키지이름 들어간거~)
	// 경로----------------------이 뒤부터 실제로 불러들일 이름
	
	@GetMapping("/")
	public String index() {
		
		return "admin/index";
	}
	
	@GetMapping("/index")
	public String index2() {
		
		return "admin/index";
	}
	
	//20240304 안드로이드 앱 프로그래밍 psd
//	@GetMapping("/board")
//	public String board() {
//		return "admin/board";
//	}
	
	@GetMapping("/board")
	public String board(@RequestParam(value="page", defaultValue="1") String page, 
			@RequestParam(value="perPage", defaultValue="1", required=false) String perPage, 
			@RequestParam(value="searchOption", required=false) String searchOption, 
			@RequestParam(value="search", required=false) String search, 
			Model model) {
		//페이징 + 검색 + 한 화면에 보이는 게시글 수 변경 기능
		//페이지 limit 바꿔서 나오는 화면의 수 다르게도 할 수 있게
		
		//전체 글 수에 DTO보내기
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch(search);
		searchDTO.setSearchOption(searchOption);
		
		//전체 글 수 뽑기
		int totalRecordCount = adminService.totalRecordCount(searchDTO);
		int recordCountPerPage = util.str2Int(perPage) * 10;
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(util.str2Int(page));
		paginationInfo.setRecordCountPerPage(recordCountPerPage);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalRecordCount);
		
		//페이징 결과 boardList에 보내기
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<BoardDTO> list = adminService.adminBoardList(searchDTO);
		model.addAttribute("list", list);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("search", search);
		model.addAttribute("searchOption", searchOption);
		model.addAttribute("page", page);
		model.addAttribute("perPage", perPage);
		return "admin/board";
	}
	
	//20240304
	@GetMapping("/postDel")
	public String postDel(@RequestParam("no") String no, @RequestParam("del") String del) {
		BoardDTO dto = new BoardDTO();
		dto.setBoard_no(util.str2Int(no));
		dto.setBoard_del(util.str2Int(del));
		int result = adminService.postDel(dto);
		return "redirect:/admin/board";
	}
	
	@PostMapping("/postDel")
	public @ResponseBody String postDelAjax(BoardDTO dto) {
		int result = adminService.postDel(dto);
		int foundDel = adminService.findDel(dto.getBoard_no());
		
		JSONObject json = new JSONObject();
		json.put("del", foundDel);
		//System.out.println("del값: " + foundDel);
		return json.toString();
	}
	
	@GetMapping("/members")
	public String members(@RequestParam(value="page", defaultValue="1") String page, 
			@RequestParam(value="perPage", defaultValue="1") String perPage, 
			@RequestParam(value="searchOption", required=false) String searchOption, 
			@RequestParam(value="search", required=false) String search, 
			Model model) {
		
		int totalMemberCount = adminService.totalMemberCount(search);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(util.str2Int(page));
		paginationInfo.setRecordCountPerPage(util.str2Int(perPage) * 10);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalMemberCount);
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setPageNo(paginationInfo.getFirstRecordIndex());
		searchDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchDTO.setSearch(search);
		List<MemberDTO> list = adminService.memberList(searchDTO);
		
		model.addAttribute("list", list);
		model.addAttribute("page", page);
		model.addAttribute("perPage", perPage);
		model.addAttribute("search", search);
		return "admin/members";
	}
	
	@GetMapping("/notice")
	public String notice(@RequestParam(value="page", defaultValue="1") String page, 
			@RequestParam(value="perPage", required=false) String perPage, 
			@RequestParam(value="searchOption", required=false) String searchOption, 
			@RequestParam(value="search", required=false) String search, 
			Model model) {
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch(search);
		searchDTO.setSearchOption(searchOption);
		
		int totalNoticeCount = adminService.totalNoticeCount(searchDTO);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(util.str2Int(page));
		paginationInfo.setRecordCountPerPage(util.str2Int(perPage));
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalNoticeCount);
		
		return "admin/notice";
	}
	
	@GetMapping("/comments")
	public String comments(@RequestParam(value="page", defaultValue="1") String page, 
			@RequestParam(value="perPage", required=false) String perPage, 
			@RequestParam(value="searchOption", required=false) String searchOption, 
			@RequestParam(value="search", required=false) String search, 
			Model model) {
		
		SearchDTO searchDTO = new SearchDTO();
		searchDTO.setSearch(search);
		searchDTO.setSearchOption(searchOption);
		
		int totalCommentsCount = adminService.totalCommentsCount(searchDTO);
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(util.str2Int(page));
		paginationInfo.setRecordCountPerPage(util.str2Int(perPage));
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalCommentsCount);
		
		return "admin/comments";
	}
	
	@GetMapping("/login")
	public String login() {
		return "admin/login";
	}
	
	@GetMapping("/join")
	public String join() {
		return "admin/join";
	}
	
	//20240305
	@GetMapping("/detail")
	public String detail(@RequestParam(value="no", defaultValue="0") String no, Model model) {
		//db에서 받아오기
		if(util.str2Int(no) == 0) {
			return "redirect:/admin/board";
		}
		BoardDTO dto = adminService.adminDetail(util.str2Int(no)); 
		//모델에 붙여주기
		model.addAttribute("detail", dto);
		return "admin/detail";
	}
}

/*
 * 20240305 psd
 * 				세션			쿠키
 * 사용 예)		로그인			쇼핑 정보, 장바구니, 자동 로그인
 * 저장위치		서버			브라우저
 * 속도			느림			빠름
 * 보안			높음			낮음(위변조가능)
 * 
 * 세션과 쿠키의 차이점
 * 
 * 쿠키/세션은 캐시와 다름.
 * 
 * 쿠키는 이름, 값, 유효시간, 도메인, 경로 등을 저장.
 * 클라이언트에 총300개의 쿠기 저장 가능
 * 쿠키는 도메인당 20개만 가질 수 있다.
 * 쿠키 크기는 4096(4KB)까지만 저장 가능.
 * 
 */
