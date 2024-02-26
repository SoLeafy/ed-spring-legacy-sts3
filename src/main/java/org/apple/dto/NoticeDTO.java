package org.apple.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
	public int nno, ndel, nread, nlike;
	public String ntitle, ncontent, ndate;
}
