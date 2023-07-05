package com.human.springboot;

import lombok.Data;

@Data
public class JA_memberDTO {
	int member_seq;
	String member_id;
	String member_name;
	String member_pw;
	String member_mobile;
	String member_email;
	String member_address;
	String member_class;
	String member_created;
	
	//test_post
	int post_seq;
	String post_category;
	int prod_category_code;
	//int member_seq; 중복되는 건 안 써도 됨
	String post_created;
	String post_title;
	String post_content;
	String post_answer;
	String post_img;
	String post_comment;
	
	//test_category
	int categoty_code;
	String category_name;
	
	//페이징
	int pageNo;
	int amount;
	
	
	String type; //외부에서 사용자가 선택한 카테고리를 대표하는 문자열을 type으로 전달받는다(페이지에서 제목 또는 내용 선택 시 "TC" 전달됨)
	String keyword;  //사용자가 검색하고 싶은 키워드를 keyword로 전달받는다.
	
	
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
	public String getMember_name() {
		return member_name;
	}
	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}
	public String getMember_pw() {
		return member_pw;
	}
	public void setMember_pw(String member_pw) {
		this.member_pw = member_pw;
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
	public int getProd_category_code() {
		return prod_category_code;
	}
	public void setProd_category_code(int prod_category_code) {
		this.prod_category_code = prod_category_code;
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
	public String getPost_comment() {
		return post_comment;
	}
	public void setPost_comment(String post_comment) {
		this.post_comment = post_comment;
	}
	public int getCategoty_code() {
		return categoty_code;
	}
	public void setCategoty_code(int categoty_code) {
		this.categoty_code = categoty_code;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	

	}
	
	

