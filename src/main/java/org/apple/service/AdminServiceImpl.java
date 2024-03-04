package org.apple.service;

import java.util.List;

import org.apple.dao.AdminDAO;
import org.apple.dto.BoardDTO;
import org.apple.dto.MemberDTO;
import org.apple.dto.SearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
@Service("adminService")
public class AdminServiceImpl extends AbstractService implements AdminService {
	@Autowired
	private AdminDAO adminDAO;

	@Override
	public List<BoardDTO> adminBoardList(SearchDTO dto) {
		return adminDAO.adminBoardList(dto);
	}

	@Override
	public int totalRecordCount(SearchDTO dto) {
		return adminDAO.totalRecordCount(dto);
	}

	@Override
	public int totalMemberCount(String search) {
		return adminDAO.totalMemberCount(search);
	}

	@Override
	public List<MemberDTO> memberList(SearchDTO searchDTO) {
		return adminDAO.memberList(searchDTO);
	}

	@Override
	public int postDel(BoardDTO dto) {
		return adminDAO.postDel(dto);
	}

	@Override
	public int findDel(int no) {
		return adminDAO.findDel(no);
	}

}
