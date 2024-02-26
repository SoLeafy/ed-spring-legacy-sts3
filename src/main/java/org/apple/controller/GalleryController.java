package org.apple.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apple.dto.GalleryDTO;
import org.apple.service.GalleryService;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class GalleryController {
	//이래도 되는 이유는 부모 형태로 말해도 자식 형태가 들어갈 수 있으니까(다형성?)
	@Resource(name="galleryService") // 실제로 주입된 객체는 이름이 "galleryService"인 GalleryServiceImpl
	private GalleryService galleryService; // 여기서 말하는 GalleryService는 GalleryService 인터페이스
	
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
	
	//galleryDetail
	//2024-02-26 요구사항 확인 psd
	@GetMapping("/galleryDetail@{no}") // @대신 /로 하니까 css가 경로 못찾아서 /<-경로로 받아들임. ../라고 쓸 수 없으니 @로.
	public String galleryDetail(@PathVariable("no") String no, Model model) { //int로 받아도 되는데 error 나니까 나중에 int로 바꿔준다고한다..
		//System.out.println("경로 : " + no);
		if(util.checkInt(no)) {
			GalleryDTO detail = galleryService.detail(no);
			
			model.addAttribute("detail", detail);
			return "galleryDetail";
		} else {
			return "redirect:/error";
		}
	}
	
	@PostMapping("/galleryDel")
	public String galleryDel(@RequestParam("no") String no) {
		//System.out.println("갤러리 글번호: " + no);
		
		if(!util.getSession().getAttribute("mid").equals(null)) {
			int result = galleryService.galleryDel(no);
			System.out.println("갤러리 글 삭제 결과: " + result);
			if(result == 1) {
				return "redirect:/gallery";
			} else {
				return "redirect:/error";
			}
		} else {
			return "redirect:/login";
		}
		
	}
	
}
