package com.human.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface jh_DAO {
	void insertMember();
	ArrayList<jh_memberDTO> selecetMemSeq();
	
	//회원정보 불러오기//
	ArrayList<jh_memberDTO>select_memberInfo(String member_id);
	//회원정보 수정하기//
	void update_member(String member_id,String member_pw,String member_name,
			String member_mobile,String member_email,String member_address);
	ArrayList<JA_memberDTO> member_select();
	void member_insert(String a, String b, String c, String d, String e, String f, String g);
	int login(String a, String b);
	int idChek(String a);
	JA_memberDTO getUserInfo(String a,String b);
	
	ArrayList<jh_productDTO> getProducts();
	ArrayList<jh_productDTO> getBestProducts();
	ArrayList<jh_productDTO> getNewProducts();	
	ArrayList<jh_productDTO> getKitchenProducts();
	ArrayList<jh_productDTO> getHomeProducts();
	ArrayList<jh_productDTO> getSeasonProducts();
	
	jh_memberDTO getMember(String id);
	void addOrder(
			int member_seq, 
			int prod_id, 
			int order_qty, 
			int order_price, 
			String order_address, 
			String order_payment,
			String order_request,
			String order_recipient,
			String order_mobile
			);
	//주문목록 관련//
	//주문목록
	ArrayList<jh_slectorderDTO>select_orderList(String member_id, int page, int total);
	
	int getOrderTotal(String member_id);	
	
	jh_productDTO getProduct(int seq);
	
	jh_memberDTO getMember2(int member_seq);
	
	
	
	// 리뷰 관련 //
		ArrayList<jh_reviewDTO> getReviews(int prod_id);//리뷰목록 불러오기
		ArrayList<jh_selectreviewDTO> select_reviewInfo(int member_seq, int pageNum, int amount );//작성가능한 리뷰 목록
		int getReviewTotal(int member_seq); //작성가능한 목록 총 개수
		
		ArrayList<jh_selectreviewsDTO>select_reviewInfos(String member_id, int pageNum, int amount);//작성한 리뷰 목록
		int getDoneTotal(String member_id);
		jh_productDTO select_product(int seq);// 작성가능한 리뷰 목록 클릭시 주문상품의 상품번호 
	//리뷰업데이트//
		void insert_review(int member_seq,int prod_id,int review_rate,String review_content,int order_id);// 작성가능한 리뷰 인설트
		void update_status(int member_seq, int prod_id);//리뷰작성시 오더테이블 리뷰여부 업데이트
		void update_review(int review_rate, String review_content,int review_seq);//리뷰 수정
		void update_refresh_review(int order_id);//리뷰삭제시 작성가능한 리뷰로 전환
		void delete_review(int review_seq);//리뷰삭제
	//장바구니//
		void addCart(int prod_id, int cart_qty, int cart_price, int member_seq);
		ArrayList<jh_selectcartDTO>select_cart(String member_id,int pageNum, int amount);//장바구니 목록 
		int selectCart(String member_id);
		void delete_cart(int cart_seq);//체크한 장바구니 목록 삭제
		ArrayList<jh_orderDTO> findOrder(int member_seq, int prod_id);
		void addReview(int member_seq, int prod_id, int review_rate, String review_content, int order_id);
		jh_reviewDTO getReviewRate(int prod_id);
		jh_cartDTO getCart(int cart_seq);
}

