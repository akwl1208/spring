package kr.green.springtest.pagination;

import lombok.Data;

@Data
public class Criteria {
	private int page; 
	private int perPageNum;
	private String searchType;
	private String search;
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
		this.search = "";
		this.searchType = "all";
	}
	
	public int getPageStart() {
		return (this.page -1) * perPageNum;
	}
}
