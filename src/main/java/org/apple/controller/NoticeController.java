package org.apple.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apple.dto.NoticeDTO;
import org.apple.service.NoticeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class NoticeController {

	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@GetMapping("/notice")
	public String notice(Model model) {
		
		List<NoticeDTO> list = noticeService.noticeList();
		model.addAttribute("list", list);
		
		return "notice";
	}
	
	@PostMapping("/noticeWrite")
	public String noticeWrite(NoticeDTO dto) {
		
		int result = noticeService.noticeWrite(dto);
		System.out.println("공지 쓰기 결과: " + result);
		
		return "redirect:/notice?no=" + dto.getNno();
	}
}
