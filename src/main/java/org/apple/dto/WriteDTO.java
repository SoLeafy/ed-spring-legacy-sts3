package org.apple.dto;

import lombok.Getter;
import lombok.Setter;

//글쓰기할 때 사용할 DTO
@Getter
@Setter
public class WriteDTO {
	private int board_no;
	private String title, content, mid, ip;
}
