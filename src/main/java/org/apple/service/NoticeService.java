package org.apple.service;

import java.util.List;

import org.apple.dto.NoticeDTO;

public interface NoticeService {

	public List<NoticeDTO> noticeList();
	public NoticeDTO noticeDetail(int no);
	public int noticeWrite(NoticeDTO dto);
	public int noticeUpdate(NoticeDTO dto);
	public int noticeDel(NoticeDTO dto);
	
}
