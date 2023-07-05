package com.human.springboot;

import lombok.Data;

@Data
public class mj_orderDTO {

	int order_seq;
	int member_seq;
	int prod_id;
	int order_qty;
	int order_price;
	String order_address;
	String order_date;
	String order_status;
	String order_payment;
	String order_created;
	String order_request;
	String order_recipient;
	String order_recipient_mobile;
	
	
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public int getProd_id() {
		return prod_id;
	}
	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}
	public int getOrder_qty() {
		return order_qty;
	}
	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}
	public int getOrder_price() {
		return order_price;
	}
	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}
	public String getOrder_address() {
		return order_address;
	}
	public void setOrder_address(String order_address) {
		this.order_address = order_address;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
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
	public String getOrder_created() {
		return order_created;
	}
	public void setOrder_created(String order_created) {
		this.order_created = order_created;
	}
	public String getOrder_request() {
		return order_request;
	}
	public void setOrder_request(String order_request) {
		this.order_request = order_request;
	}
	public String getOrder_recipient() {
		return order_recipient;
	}
	public void setOrder_recipient(String order_recipient) {
		this.order_recipient = order_recipient;
	}
	public String getOrder_recipient_mobile() {
		return order_recipient_mobile;
	}
	public void setOrder_recipient_mobile(String order_recipient_mobile) {
		this.order_recipient_mobile = order_recipient_mobile;
	}
	
	
	
	
	
	
}
