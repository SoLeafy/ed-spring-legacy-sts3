package org.apple.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NoticeDTO {
	public int nno, ndel, nread, nlike;
	public String ntitle, ncontent, mid, mname, mpfpic, nip;
	public Date ndate;
}
