package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface IDAO {
	ArrayList<JA_memberDTO> member_select();
	void member_insert(String a, String b, String c, String d, String e, String f, String g);
	int idChek(String a);
	int login(String a, String b);
	JA_memberDTO getUserInfo(String a,String b);
	String idFind(String a, String b, String c);
	
	
	ArrayList<JA_memberDTO> notice_view();
	ArrayList<JA_memberDTO> paging(@Param("pageNo") int pageNo, @Param("amount") int amount);
	ArrayList<JA_memberDTO> searchPaging(@Param("pageNo") int pageNo, @Param("amount") int amount,String type, String keyword);
	int getTotalCount();
	int getTotalCount_search(String type, String keyword);


	JA_memberDTO read_post(int a);
	void post_upload(String a, int b, int c, String d, String e, String f, String g, String h);
	void update_post(int a, String b, String c, int d); 
	void delete_post(int a);
	
	
	void comment_upload(String a,String b,int c);
	void delete_comment(String a,String b,int c);
	
	
	void addCart(int prod_id, int cart_qty, int cart_price, int member_seq);
}