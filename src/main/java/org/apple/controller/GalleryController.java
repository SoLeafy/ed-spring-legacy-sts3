package org.apple.controller;

import java.util.List;

import org.apple.dto.GalleryDTO;
import org.apple.service.GalleryService;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService galleryService;
	
	@Autowired
	private Util util;

	@GetMapping("/gallery")
	public String gallery(Model model) {
		//게시판처럼 보여주면 된다
		List<GalleryDTO> list = galleryService.galleryList();
		model.addAttribute("list", list);
		return "gallery";
	}
	
	@GetMapping("/galleryInsert")
	public String galleryInsert() {
		return "galleryInsert";
	}
	
	@PostMapping("/galleryInsert") // 갤러리 들어가기 글쓰기 저장하기 불러오기..?
	public String galleryInsert(GalleryDTO dto, @RequestParam("file1") MultipartFile upFile) {
		System.out.println("제목: " +dto.getGtitle());
		System.out.println("내용~~~~: " + dto.getGcontent());
		System.out.println("파일명: " + upFile.getOriginalFilename()); //실제 업로드할때 파일이름이고
		//보낼건 위 3개와 세션(서비스에서 넣어줌.)
		
		//파일 업로드 -> util
		String newFileName = util.fileUpload(upFile); //근데 서비스에서 보낸다하신거같은데... 컨트롤러에서 했다
		
		dto.setGfile(newFileName); //UUID 넣은 newFileName
		
		int result = galleryService.galleryInsert(dto);
		return "redirect:/gallery";
	}
}
