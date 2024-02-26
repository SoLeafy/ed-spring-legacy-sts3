package org.apple.service;

import java.util.List;

import org.apple.dto.GalleryDTO;

public interface GalleryService {

	public int galleryInsert(GalleryDTO dto); //추상메서드
	
	public List<GalleryDTO> galleryList();
	
	public GalleryDTO detail(String no);

	public int galleryDel(String no);
	
}
