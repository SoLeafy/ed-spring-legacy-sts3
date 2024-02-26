package org.apple.dao;

import java.util.List;

import org.apple.dto.NoticeDTO;
import org.springframework.stereotype.Repository;

@Repository
public class NoticeDAO extends AbstractDAO {
	
	public List<NoticeDTO> noticeList() {
		return sqlSession.selectList("notice.noticeList");
	}

	public NoticeDTO noticeDetail(int no) {
		return sqlSession.selectOne("notice.noticeDetail", no);
	}

	public int noticeWrite(NoticeDTO dto) {
		return sqlSession.insert("notice.noticeWrite", dto);
	}

	public int noticeUpdate(NoticeDTO dto) {
		return sqlSession.update("notice.noticeUpdate", dto);
	}

	public int noticeDel(NoticeDTO dto) {
		return sqlSession.update("notice.noticeDel", dto);
	}
}
