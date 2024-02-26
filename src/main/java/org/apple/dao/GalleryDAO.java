package org.apple.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apple.dto.GalleryDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GalleryDAO extends AbstractDAO {
	
	public int galleryInsert(GalleryDTO dto) {
		return sqlSession.insert("gallery.galleryInsert", dto);
	}

	public List<GalleryDTO> galleryList() {
		return sqlSession.selectList("gallery.galleryList");
	}

	public GalleryDTO galleryDetail(int no) {
		return sqlSession.selectOne("gallery.galleryDetail", no);
	}

	public int galleryDel(GalleryDTO dto) {
		return sqlSession.update("gallery.galleryDel", dto);
	}
}
