package org.apple.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apple.dto.BoardDTO;
import org.apple.service.BoardService;
import org.apple.service.LoginService;
import org.apple.service.RestService;
import org.apple.util.Util;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@RestController
public class RestFullController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private Util util;
	@Autowired
	private RestService restService; //REST service 다 몰아두자.

	@PostMapping("/restDetail")
	public BoardDTO restDetail(@Param("no") int no) {
		//System.out.println("restDetail : " + no);
		BoardDTO detail = boardService.detail(no); //dto는 autowired 안씀(어노테이션 없어서 그런가)
		
		System.out.println(detail.getBoard_title());
		//System.out.println(detail.getBoard_content());
		
		return detail;
	}
	
	@PostMapping("/emailAuth")
	public int emailAuth() {
		//로그인 검사, key 저장 등 service에서 한다.
		return restService.sendEmail();
	}
	
	@PostMapping("/idCheck")
	public String idCheck(@RequestParam("id") String id) {
		//System.out.println(id);
		
		int result = restService.idCheck(id);
		System.out.println("가입된 아이디 수 : " + result);
		// json 타입 -> { key:value, key2:value, key3: value }
		// { key:value, {} }
		// result : { count : 1/0 }
		//Map<String, Object> resultMap = new HashMap<String, Object>();
		//resultMap.put("count", result);
		
		//JsonObject 이용 시
		JSONObject json = new JSONObject();
		json.put("count", result);
		
		return json.toString();
	}
	
	// 게시판을 json으로 출력해주는 api
	@GetMapping("/jsonBoard")
	public String jsonBoard(@RequestParam(value="pageNo", required=false) String pageNo) {
		//pageNo가 오지 않는다면
		int currentPageNo = 1;
		if(util.str2Int(pageNo) > 0) { //운영하다보면 여기 수정해야함. 정수..?
			currentPageNo = Integer.parseInt(pageNo);
		}
		
		//int totalRecordCount 전체 글 수
		int totalRecordCount = boardService.totalRecordCount();
		System.out.println("총 게시글 수 : " + totalRecordCount);
		//pagination
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPageNo);//현재 페이지 번호
		paginationInfo.setRecordCountPerPage(10); //한 페이지에 게시되는 게시물 건수
		paginationInfo.setPageSize(10); // 페이징 리스트의 사이즈
		paginationInfo.setTotalRecordCount(totalRecordCount); //전체 게시물 건수
		
		List<BoardDTO> list = boardService.boardList(paginationInfo.getFirstRecordIndex());//DTO -> 전통적인 방법으로 해야해서
		//전자정부 페이징 가져와야~
		//List<BoardDTO> list = boardService.boardList(pageNo);
		
		//JSON
		// 이 구조를 알아야 필요한 값을 찍어낼 수 있다.
		JSONObject jsonList = new JSONObject();
		jsonList.put("list", list);
		jsonList.put("paginationInfo", paginationInfo);
		jsonList.put("pageNo", pageNo);
		
		return jsonList.toString();
	}
}
