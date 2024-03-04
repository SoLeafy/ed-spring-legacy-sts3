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
	public List<NoticeDTO> noticeList(int page) {
		return noticeDAO.noticeList(page);
	}

	@Override
	public NoticeDTO noticeDetail(String no) {
		int reNo = util.str2Int(no);
		return noticeDAO.noticeDetail(reNo);
	}

	@Override
	public int noticeWrite(NoticeDTO dto) {
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		dto.setNip(util.getIp());
		return noticeDAO.noticeWrite(dto);
	}

	@Override
	public int noticeUpdate(NoticeDTO dto) {
		return noticeDAO.noticeUpdate(dto);
	}

	@Override
	public int noticeDel(int no) {
		NoticeDTO dto = new NoticeDTO();
		dto.setNno(no);
		dto.setMid(String.valueOf(util.getSession().getAttribute("mid")));
		return noticeDAO.noticeDel(dto);
	}

	@Override
	public int totalRecordCount() {
		return noticeDAO.totalRecordCount();
	}
	
}
