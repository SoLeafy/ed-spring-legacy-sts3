package org.apple.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apple.dto.NoticeDTO;
import org.apple.service.NoticeService;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class NoticeController {

	@Resource(name="noticeService")
	private NoticeService noticeService;
	@Autowired
	private Util util;
	
	@GetMapping("/notice")
	public String notice(@RequestParam(value="page", required=false) String no, Model model) {
		int currentPage = 1;
		if(util.str2Int(no) > 0) {
			currentPage = util.str2Int(no);
		}
		
		int totalRecordCount = noticeService.totalRecordCount();
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(currentPage);
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		paginationInfo.setTotalRecordCount(totalRecordCount);
		
		List<NoticeDTO> list = noticeService.noticeList(paginationInfo.getFirstRecordIndex());
		model.addAttribute("list", list);
		model.addAttribute("totalRecordCount", totalRecordCount);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("page", currentPage);
		
		return "notice";
	}
	
	// noticeDetail?no=100
	@GetMapping("/noticeDetail")
	public String noticeDetail(@RequestParam(value="no", defaultValue="0", required=true) String no, Model model) { //int no로 잡으면 문제 생겨서 String이 베스트
		
		if(Integer.valueOf(no) == 0) {
			return "redirect:/error";
		} else {
			NoticeDTO detail = noticeService.noticeDetail(no);
			if(detail.getNno() == 0) { //없는 글번호일 경우. (db에 없는 숫자 거를 수 있는 시스템.. 상수에 넣어두거나..)
				return "redirect:/error";
			} else {
				model.addAttribute("detail", detail);
				return "noticeDetail";
			}
		}
		
	}
	
	//공지 글쓰기 -> admin 관리자 화면에서(이사해야함)
	@GetMapping("/admin/noticeWrite") //관리자 화면은 이렇게 할 것
	public String noticeWrite() {
		return "admin/noticeWrite"; //	....../views/admin/noticeWrite.jsp
	}
	
	@GetMapping("admin/noticeUpdate")
	public String noticeUpdate() {
		return "admin/noticeUpdate";
	}
	
	@GetMapping("/noticeDel{no}") //#도 안써도됨 -> 아니.. #{ } 이렇게 쓰니까 뭔가 안돼서 빼버림..
	public String noticeDel(@PathVariable("no") int no) {
		//System.out.println("@PathVariable : " + no);
		int result = noticeService.noticeDel(no);
		return "redirect:/notice";
	}
	
	@PostMapping("/admin/noticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		System.out.println(dto.getNtitle());
		System.out.println(dto.getNcontent());
		
		if(util.getSession().getAttribute("mid") != null) {
			if(Integer.parseInt(util.getSession().getAttribute("mgrade").toString()) > 5) {
				int result = noticeService.noticeWrite(dto);
				//System.out.println("공지 쓰기 결과: " + result);
				
				return "redirect:/notice";
			} else {
				return "redirect:/error";
			}
		} else {
			return "redirect:/login";
		}
	}
	
	@PostMapping("/noticeWrite")
	public String noticeWriteModal(NoticeDTO dto) {
		
		if(util.getSession().getAttribute("mid") != null) {
			if(Integer.parseInt(util.getSession().getAttribute("mgrade").toString()) > 5) {
				int result = noticeService.noticeWrite(dto);
				System.out.println("공지 쓰기 결과: " + result);
				
				return "redirect:/notice";
			} else {
				return "redirect:/error";
			}
		} else {
			return "redirect:/login";
		}
		
	}
	
	
}
