package com.human.springboot;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ManagerDAO {
	// member
	ArrayList<ManagerDTO> memberList();
	
	// product
	ArrayList<ManagerDTO> prodList();
	void prodDelete(int prod_id);
	ArrayList<ManagerDTO> prodCategoryList();
	void prodInsert(String code, int category, String name, int price, String prodImg, String desc,  int qty);
	ManagerDTO prodInfo(int prod_id);
	void prodUpdate(int prod_id, String code, int category, String name, 
					int price, String prodImg, String desc, int qty);
	void prodImgUpdate(int prod_id, String imgPath);
	ManagerDTO getProdAmount(int prod_id);
	void updateProdAmount(int prod_id, int qty);
	void emptyProdAmount(int prod_id);
	
	// order
	ArrayList<ManagerDTO> orderList();
	void orderStatusUpdate(int order_seq);
	void orderCancel(int order_seq);
	ManagerDTO orderProdQty(int order_seq);
	void refillProdQty(int prod_id, int order_qty);
	
	// customer service
	ArrayList<ManagerDTO> csList();
	ManagerDTO csPost(int post_seq);
	void csCommentUpdate(int post_seq, String post_comment);
	
	// pagination
	ArrayList<ManagerDTO> orderListPaging(ManagerPagination mp);
	int getOrderCount();
	ArrayList<ManagerDTO> prodListPaging(ManagerPagination mp);
	int getProdCount();
	ArrayList<ManagerDTO> memberListPaging(ManagerPagination mp);
	int getMemberCount();
	ArrayList<ManagerDTO> csListPaging(ManagerPagination mp);
	int getCsCount();

	

	
}


