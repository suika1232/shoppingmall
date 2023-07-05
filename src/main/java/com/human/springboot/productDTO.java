package com.human.springboot;

import lombok.Data;

@Data
public class productDTO {

	int prod_id;
	String prod_address;
	
	
	public int getProd_id() {
		return prod_id;
	}
	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}
	public String getProd_address() {
		return prod_address;
	}
	public void setProd_address(String prod_address) {
		this.prod_address = prod_address;
	}
	
	
	
}
