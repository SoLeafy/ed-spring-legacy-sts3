package org.apple.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;

@Controller
public class FileController {
	
	@GetMapping("/file")
	public String file() {
		return "file";
	}
	
	@PostMapping("/file")
	public String file(@RequestParam("file1") MultipartFile upFile, HttpServletRequest request) {
		System.out.println("파일 이름 : " +upFile.getOriginalFilename());
		System.out.println("파일 사이즈 : " +upFile.getSize());
		System.out.println("파일 타입 : " +upFile.getContentType());
		
		//경로
		String root = request.getSession().getServletContext().getRealPath("/"); //리눅스, 유닉스 서버는 c:/가 아님. 최상위는 /
		System.out.println("upfileURL : " + root); //upfileURL : C:\workspace-spring\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\feb15\
		String upfile = root + "resources\\upfile\\";
		System.out.println("upfile : " + upfile);
		
		//UUID 생성		UUID-name.png (UUID는 겹치지 않는다고 보면됨.)
		UUID uuid = UUID.randomUUID();
		System.out.println(uuid); //42eae8e6-4731-42db-bab0-71d9ace5b28b 이런 식으로 나왔다
		String newFileName = uuid.toString() + "-" + upFile.getOriginalFilename();
		System.out.println("새로 만들어진 파일이름: " + newFileName);
		
		//Real upload
		File f = new File(upfile, newFileName); //파일경로, 파일이름
		try {

			//썸네일 만들기
			FileOutputStream thumbnail = 
					new FileOutputStream(new File(upfile, "s_"+newFileName)); //썸네일은 이름 앞에 s_를 붙인다.
			Thumbnailator.createThumbnail(upFile.getInputStream(), thumbnail, 100, 100); //inputstream(실제 올라갈 파일내용물), 저장경로, 파일크기 x, y
			thumbnail.close();
			
			upFile.transferTo(f); //multipartfile의 메소드. 파일 전송해서 실제로 저장.
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "redirect:/file";
	}
}
