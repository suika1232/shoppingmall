package com.human.springboot;

import lombok.Data;

@Data
public class jh_slectorderDTO {
	int order_seq;
	String prod_image;
	String prod_name;
	String order_created;
	String order_status;
	String order_payment;
	
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public String getOrder_created() {
		return order_created;
	}
	public void setOrder_created(String order_created) {
		this.order_created = order_created;
	}
	public String getOrder_status() {
		return order_status;
	}
	public void setOrder_status(String order_status) {
		this.order_status = order_status;
	}
	public String getOrder_payment() {
		return order_payment;
	}
	public void setOrder_payment(String order_payment) {
		this.order_payment = order_payment;
	}
	
	
}
