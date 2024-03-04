package org.apple.service;

import java.util.List;

import org.apple.dto.BoardDTO;
import org.apple.dto.MemberDTO;
import org.apple.dto.SearchDTO;

public interface AdminService {
	public List<BoardDTO> adminBoardList(SearchDTO searchDTO);

	public int totalRecordCount(SearchDTO searchDTO);

	public int totalMemberCount(String search);

	public List<MemberDTO> memberList(SearchDTO searchDTO);

	public int postDel(BoardDTO dto);

	public int findDel(int no);
}
