package com.human.springboot;


import lombok.Data;

@Data
public class ManagerPagination {
	
	// page 번호
	private int pageNo;
	// page 데이터 수
	private int amount;
	
	// 생성자, 객체 생성시 page번호 1, page 개수 10으로 초기화 
	public ManagerPagination() {
		this.pageNo = 1;
		this.amount = 10;
	}
	// page 조회 조건 (page 번호, page당 데이터 수)
	public ManagerPagination(int pageNo, int amount) {
		this.pageNo = pageNo;
		this.amount = amount;
	}
	// total page
	public int getTotalPage(int total) {
		int totalPage = (int)Math.ceil(total*1.0/this.amount);
		return totalPage;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
	
	
}
