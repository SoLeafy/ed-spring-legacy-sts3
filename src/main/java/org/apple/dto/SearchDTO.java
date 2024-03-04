package org.apple.dto;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class SearchDTO {
	private int pageNo, recordCountPerPage;
	private String search, searchOption;
}
