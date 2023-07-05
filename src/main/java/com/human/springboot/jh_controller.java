package com.human.springboot;

import java.util.ArrayList;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class jh_controller {
	@Autowired
	private jh_DAO jhdao;

//user_update//
	@GetMapping("/member_update")
	public String member_update() {
		return "member_update";
	}
	@GetMapping("/mypage")
	public String mypage() {
		return "mypage";
	}
	@PostMapping("/update_member")
	@ResponseBody
	public String update_member (HttpServletRequest req) {
		String check="ok";
		try {
			String id=req.getParameter("uid");

			String pw=req.getParameter("upw");
			String name=req.getParameter("unm");
			String mobile=req.getParameter("umb");
			String email=req.getParameter("uem");
			String pc=req.getParameter("upc");
			String ad=req.getParameter("uad");
			String dAd=req.getParameter("udad");
			String totlaAd=pc+','+ad+','+dAd; //주소지 총합
			jhdao.update_member(id, pw, name, mobile, email, totlaAd);
		}catch(Exception e) {
			
			return "fail";
		}
		return check;
	}
	@PostMapping("/select_member")
	@ResponseBody
	public String select_member (HttpServletRequest req) {
		String memberID=req.getParameter("memberID");
		jhdao.select_memberInfo(memberID);
		ArrayList<jh_memberDTO>dto=jhdao.select_memberInfo(memberID);
		JSONArray ja= new JSONArray ();
	
		for(int i=0; i<dto.size(); i++) {	
			
			JSONObject jo=new JSONObject();
			jh_memberDTO mo=new jh_memberDTO();
			mo=dto.get(i);
			jo.put("member_id",mo.member_id);
			jo.put("member_pw",mo.member_pw);
			jo.put("member_name",mo.member_name);
			jo.put("member_mobile",mo.member_mobile);
			jo.put("member_email",mo.member_email);
			jo.put("member_address",mo.member_address);
			
			ja.put(jo);
		}
		return ja.toString();	
	}	
	///////////////////////////////////// 여기까지 상품 list ////////////////////////////////////////////
	@GetMapping("/order_list")
	public String orderlist() {
		return "order_list";
	}
	@PostMapping("/select_order")
	@ResponseBody
	public String select_order(HttpServletRequest req) {
		String member_id=req.getParameter("member_id");
		
	
		int total = jhdao.getOrderTotal(member_id);
		jh_pagination paging = new jh_pagination();
//		paging.setAmount(20);
//		paging.setPageNum(2);
		paging.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		int pageNum = paging.getPageNum();
		int amount = paging.getAmount();
	      
	    int totalPage = (int)Math.ceil(total*1.0/amount);
	    
//	    jhdao.select_orderList(member_id, pageNum, amount);
		ArrayList<jh_slectorderDTO>dto=jhdao.select_orderList(member_id, pageNum, amount);

		JSONArray ja=new JSONArray();
		for(int i=0; i<dto.size(); i++) {
			JSONObject jo=new JSONObject();
			jh_slectorderDTO to=new jh_slectorderDTO();
			to=dto.get(i);
			jo.put("prod_img",to.prod_image);
			jo.put("prod_name",to.prod_name);
			jo.put("order_created",to.order_created);
			jo.put("order_status",to.order_status);
			jo.put("order_payment",to.order_payment);
			jo.put("totalPage", totalPage);
			ja.put(jo);
			
		}		
		return ja.toString();
	}

	
	
	/////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////// jhController///////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////
	@GetMapping("/review")
	public String review() {
		return "review";
	}
	@PostMapping("/select_reviewY") //리뷰가능 
	@ResponseBody
	public String select_review(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		int member_seq = (int) session.getAttribute("member_seq");
		
		int total = jhdao.getReviewTotal(member_seq);
		System.out.println("member_Seq: "+member_seq+" Total: "+total);
	
		jh_pagination paging = new jh_pagination();
		paging.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		int pageNum = paging.getPageNum();
		int amount = paging.getAmount();
	    System.out.println(pageNum +" " +amount);
	    
	    int totalPage = (int)Math.ceil(total*1.0/amount);
	    
	    System.out.println("total page: "+totalPage);
	    System.out.println("total:"+total);
	    
		ArrayList<jh_selectreviewDTO> reviewprods = jhdao.select_reviewInfo(member_seq, pageNum, amount);
		JSONArray ja=new JSONArray();
		
		for(int i=0; i<reviewprods.size(); i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("oid", reviewprods.get(i).getOid());
			jo.put("mseq", reviewprods.get(i).getMseq());
			jo.put("pid", reviewprods.get(i).getPid());
			jo.put("pname", reviewprods.get(i).getPname());
			jo.put("pimg", reviewprods.get(i).getPimg());
			jo.put("lastorder", reviewprods.get(i).getLastorder());
			jo.put("firstorder", reviewprods.get(i).getFirstorder());

			jo.put("totalPage", totalPage);
			
			ja.put(jo);
			}
		
		return ja.toString();	
	}
	@PostMapping("/select_reviewDone") //작성한 리뷰 
	@ResponseBody
	public String select_reviewY(HttpServletRequest req) {
		String member_id=req.getParameter("member_id");
		int total=jhdao.getDoneTotal(member_id);
		
		jh_pagination paging = new jh_pagination();
		
		paging.setPageNum(Integer.parseInt(req.getParameter("pageNum")));
		
		int pageNum=paging.getPageNum();
		int amount =paging.getAmount();
		
		int totalPage=(int)Math.ceil(total*1.0/amount);
		
		ArrayList<jh_selectreviewsDTO> dto = jhdao.select_reviewInfos(member_id ,pageNum ,amount);
		
		JSONArray ja=new JSONArray();
		for(int i=0; i<dto.size(); i++) {
			
			JSONObject jo=new JSONObject();
				// 리뷰번호, 제품이름, 제품사진, 평점, 리뷰내용 출력할거임
			
				
				jo.put("review_seq",dto.get(i).getReview_seq());
				
				jo.put("order_id",dto.get(i).getOrder_id());
				
				jo.put("prod_name",dto.get(i).getProd_name());
				
				jo.put("prod_img",dto.get(i).getProd_image());
				
				jo.put("review_rate",dto.get(i).getReview_rate());
				
				jo.put("review_content",dto.get(i).getReview_content());
				
				
				jo.put("totalPage", totalPage);
				
				ja.put(jo);			
		}
		return ja.toString();
	
	}
	@PostMapping("/insert_review")
	@ResponseBody
	public String insert_review(HttpServletRequest req) {
		String check="ok";
		try {
			int order_id=Integer.parseInt(req.getParameter("order_seq"));
			
			int member_seq=Integer.parseInt(req.getParameter("member_seq"));
			
			int prod_id=Integer.parseInt(req.getParameter("prod_id"));
			
			int review_rate=Integer.parseInt(req.getParameter("review_rate"));
			
			String review_content=req.getParameter("review_content");
			
//			int order_seq=Integer.parseInt(req.getParameter("order_seq"));
			jhdao.insert_review(member_seq,prod_id,review_rate,review_content,order_id);
			jhdao.update_status(member_seq, prod_id);
			
		}catch(Exception e) {
			return "fail";
		}
		return check;
	}
	@PostMapping("/update_review")
	@ResponseBody
	public String update_review(HttpServletRequest req) {
		String check="ok";
//		try {
			
			String review_content=req.getParameter("review_content");
			System.out.println(review_content);
			int review_rate=Integer.parseInt(req.getParameter("review_rate"));
			
			int review_seq=Integer.parseInt(req.getParameter("review_seq"));
			
			jhdao.update_review(review_rate,review_content,review_seq);
			
//		}catch(Exception e) {
//			return "fail";
//		}
		return check;
	}
	@PostMapping("/delete_review")
	@ResponseBody
	public String delete_review(HttpServletRequest req) {
		String check="ok";
		try {
			int order_id=Integer.parseInt(req.getParameter("order_id"));
			int review_seq=Integer.parseInt(req.getParameter("review_seq"));
			jhdao.update_refresh_review(order_id);
			jhdao.delete_review(review_seq);
		}catch(Exception e) {
			return "fail";
		}
		return check;
	}
	@GetMapping("/cart")
	public String cart() {
		return "cart";
	}
	@PostMapping("/select_cart")
	@ResponseBody
	public String select_cart(HttpServletRequest req) {
		String member_id=req.getParameter("member_id");
		System.out.println(member_id);
		int pageNum=Integer.parseInt(req.getParameter("pageNum"));
		System.out.println(pageNum);
		int amount=Integer.parseInt(req.getParameter("count"));
		System.out.println(amount);
		jh_pagination paging=new jh_pagination();
		
		paging.setPageNum(pageNum);
		paging.setAmount(amount);
		int total= jhdao.selectCart(member_id);	
		System.out.println(total);
	
		pageNum = paging.getPageNum();
		System.out.println(pageNum);
 		amount =paging.getAmount();
 		System.out.println(amount);
 		int totalPage=(int)Math.ceil(total*1.0/amount);
 		System.out.println(totalPage);

		ArrayList<jh_selectcartDTO>dto=jhdao.select_cart(member_id,pageNum,amount);
		
	
		
		JSONArray ja=new JSONArray();
		for(int i=0; i<dto.size(); i++) {
			JSONObject jo= new JSONObject();
			
			jo.put("cart_seq", dto.get(i).getCart_seq());
			jo.put("prod_image",dto.get(i).getProd_image());
			jo.put("cart_price",dto.get(i).getCart_price());
			jo.put("cart_qty",dto.get(i).getCart_qty());
			jo.put("totalPage", totalPage);
			
			ja.put(jo);
		}
		return ja.toString();
	}
	@PostMapping("/delete_cart")
	@ResponseBody
	public String delete_cart(HttpServletRequest req) {
//		String[] cart_seq ;
//		
		String check="ok";
//		try {
//			cart_seq=req.getParameterValues("seq");
//			for(int i=0; i<cart_seq.length; i++) {
//				jhdao.delete_cart(cart_seq);
//			}
//			
//		}catch(Exception e) {
//			return "fail";
//		}
//		return check;
		try {
			int cart_seq = Integer.parseInt(req.getParameter("cart_seq"));
			
			jhdao.delete_cart(cart_seq);
		} catch(Exception e) {
			check = "fail";
		}
		
		
		
		return check;
	}
}