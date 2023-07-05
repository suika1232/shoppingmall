package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface mj_DAO {

	ArrayList<mj_productDTO> getProducts();
	ArrayList<mj_productDTO> getBestProducts();
	ArrayList<mj_productDTO> getTop3();
	ArrayList<mj_productDTO> getNew3();
	ArrayList<mj_productDTO> getNewProducts();	
	ArrayList<mj_productDTO> getKitchenProducts();
	ArrayList<mj_productDTO> getHomeProducts();
	ArrayList<mj_productDTO> getSeasonProducts();
	
	mj_productDTO getProduct(int seq);
	ArrayList<mj_reviewDTO> getReviews(int prod_id);
	int getReviews2(int member_seq, int prod_id);
	
	
	mj_memberDTO getMember(String id);
	mj_memberDTO getMember2(int member_seq);
	
	void addOrder(
			int member_seq, 
			int prod_id, 
			int order_qty, 
			int order_price, 
			String order_address, 
			String order_review,
			String order_payment,
			String order_request,
			String order_recipient,
			String order_recipient_mobile
			);
	void modifyInventory(int prod_id, int order_qty);
	
	void addCart(int prod_id, int cart_qty, int cart_price, int member_seq);
	void deleteCart(int cart_seq);
	mj_cartDTO getCart(int cart_seq);
	
	ArrayList<mj_orderDTO> findOrder(int member_seq, int prod_id);
	mj_orderDTO getOrder(int order_seq);
	
	void addReview(int member_seq, int prod_id, int review_rate, String review_content, int order_id);
	void deleteReview(int review_seq);
	mj_reviewDTO getReviewRate(int prod_id);
	
	void reviewRegister(int member_seq, int prod_id);
	void reviewUnRegister(int member_seq, int prod_id);
	
	
	
	
	
	void addChat(String id, String content);
	void deleteChat(int seq);
	ArrayList<mj_chatDTO> showChat();
	
}
