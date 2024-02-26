package org.apple.service;

import java.util.List;

import org.apple.dao.NoticeDAO;
import org.apple.dto.NoticeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("noticeService")
public class NoticeServiceImpl extends AbstractService implements NoticeService {
	
	@Autowired
	private NoticeDAO noticeDAO;

	@Override
	public List<NoticeDTO> noticeList() {
		return noticeDAO.noticeList();
	}

	@Override
	public NoticeDTO noticeDetail(int no) {
		return noticeDAO.noticeDetail(no);
	}

	@Override
	public int noticeWrite(NoticeDTO dto) {
		return noticeDAO.noticeWrite(dto);
	}

	@Override
	public int noticeUpdate(NoticeDTO dto) {
		return noticeDAO.noticeUpdate(dto);
	}

	@Override
	public int noticeDel(NoticeDTO dto) {
		return noticeDAO.noticeDel(dto);
	}
	
}
