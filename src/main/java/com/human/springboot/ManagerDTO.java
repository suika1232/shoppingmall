package com.human.springboot;

import lombok.Data;

@Data
public class ManagerDTO {
	//member
	int member_seq;
	String member_id;
	String member_pw;
	String member_name;
	String member_mobile;
	String member_email;
	String member_address;
	String member_class;
	String member_created;
	
	//order
	int order_seq;
	int order_qty;
	int order_price;
	String order_address;
	String order_date;
	String order_status;
	String order_payment;
	String order_created;
	String order_request;
	
	//product
	int prod_id;
	String prod_code;
	int prod_category_code;
	String prod_name;
	int prod_price;
	String prod_image;
	int prod_amount_sold;
	String prod_created;
	String prod_desc;
	int prod_amount;
	
	//category
	int category_code;
	String category_name;
	
	//post
	int post_seq;
	String post_category;
	String post_created;
	String post_title;
	String post_content;
	String post_answer;
	String post_img;
	
	
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
	}
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_mobile() {
		return member_mobile;
	}
	public void setMember_mobile(String member_mobile) {
		this.member_mobile = member_mobile;
	}
	public String getMember_email() {
		return member_email;
	}
	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}
	public String getMember_address() {
		return member_address;
	}
	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}
	public String getMember_class() {
		return member_class;
	}
	public void setMember_class(String member_class) {
		this.member_class = member_class;
	}
	public String getMember_created() {
		return member_created;
	}
	public void setMember_created(String member_created) {
		this.member_created = member_created;
	}
	public int getOrder_seq() {
		return order_seq;
	}
	public void setOrder_seq(int order_seq) {
		this.order_seq = order_seq;
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
	public int getProd_id() {
		return prod_id;
	}
	public void setProd_id(int prod_id) {
		this.prod_id = prod_id;
	}
	public String getProd_code() {
		return prod_code;
	}
	public void setProd_code(String prod_code) {
		this.prod_code = prod_code;
	}
	public int getProd_category_code() {
		return prod_category_code;
	}
	public void setProd_category_code(int prod_category_code) {
		this.prod_category_code = prod_category_code;
	}
	public String getProd_name() {
		return prod_name;
	}
	public void setProd_name(String prod_name) {
		this.prod_name = prod_name;
	}
	public int getProd_price() {
		return prod_price;
	}
	public void setProd_price(int prod_price) {
		this.prod_price = prod_price;
	}
	public String getProd_image() {
		return prod_image;
	}
	public void setProd_image(String prod_image) {
		this.prod_image = prod_image;
	}
	public int getProd_amount_sold() {
		return prod_amount_sold;
	}
	public void setProd_amount_sold(int prod_amount_sold) {
		this.prod_amount_sold = prod_amount_sold;
	}
	public String getProd_created() {
		return prod_created;
	}
	public void setProd_created(String prod_created) {
		this.prod_created = prod_created;
	}
	public String getProd_desc() {
		return prod_desc;
	}
	public void setProd_desc(String prod_desc) {
		this.prod_desc = prod_desc;
	}
	public int getProd_amount() {
		return prod_amount;
	}
	public void setProd_amount(int prod_amount) {
		this.prod_amount = prod_amount;
	}
	public int getCategory_code() {
		return category_code;
	}
	public void setCategory_code(int category_code) {
		this.category_code = category_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public int getPost_seq() {
		return post_seq;
	}
	public void setPost_seq(int post_seq) {
		this.post_seq = post_seq;
	}
	public String getPost_category() {
		return post_category;
	}
	public void setPost_category(String post_category) {
		this.post_category = post_category;
	}
	public String getPost_created() {
		return post_created;
	}
	public void setPost_created(String post_created) {
		this.post_created = post_created;
	}
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_content() {
		return post_content;
	}
	public void setPost_content(String post_content) {
		this.post_content = post_content;
	}
	public String getPost_answer() {
		return post_answer;
	}
	public void setPost_answer(String post_answer) {
		this.post_answer = post_answer;
	}
	public String getPost_img() {
		return post_img;
	}
	public void setPost_img(String post_img) {
		this.post_img = post_img;
	}
	
	
	
	
	
	
	
	
	
}
