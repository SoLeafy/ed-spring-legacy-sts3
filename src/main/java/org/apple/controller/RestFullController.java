package org.apple.controller;

import org.apache.ibatis.annotations.Param;
import org.apple.dto.BoardDTO;
import org.apple.service.BoardService;
import org.apple.service.RestService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class RestFullController {
	@Autowired
	private BoardService boardService;
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
	
}
