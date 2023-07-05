package com.human.springboot;

import lombok.Data;

@Data
public class jh_pagination {

	private int pageNum;
	private int amount;
	
	public jh_pagination() {
		this.pageNum = 1;
		this.amount = 10;
	}
	public jh_pagination (int pageNo,int amount) {
		this.pageNum = pageNo;
		this.amount = amount;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	
	
}
