package org.apple.service;

import java.util.List;

import org.apple.dao.GalleryDAO;
import org.apple.dto.GalleryDTO;
import org.apple.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("galleryService")
public class GalleryServiceImpl extends AbstractService implements GalleryService {
	
	@Autowired
	private GalleryDAO galleryDAO;
	
	@Override
	public int galleryInsert(GalleryDTO dto) {
		//세션 추가
		if(util.getSession().getAttribute("mid") != null) {
			dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
			dto.setGip(util.getIp());
			return galleryDAO.galleryInsert(dto);
		} else {
			return 0;
		}
		
	}

	@Override
	public List<GalleryDTO> galleryList() {
		return galleryDAO.galleryList();
	}

	@Override
	public GalleryDTO detail(String no) {
		int reNo = util.str2Int(no);
		return galleryDAO.galleryDetail(reNo);
	}

	@Override
	public int galleryDel(String no) {
		GalleryDTO dto = new GalleryDTO();
		int reNo = util.str2Int(no);
		dto.setGno(reNo);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		return galleryDAO.galleryDel(dto);
	}
	
}
