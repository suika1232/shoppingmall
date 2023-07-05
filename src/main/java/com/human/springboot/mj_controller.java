package com.human.springboot;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class mj_controller {
	///////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////// MJ Controller	///////////////////////////////////
	///////////////////////////////////////////////////////////////////////////////////////////
	@Autowired
	private mj_DAO mjdao;
	@Autowired
	private IDAO idao;
	
	public static int stranger_cart_seq;
	public static ArrayList<mj_cartDTO> stranger_carts = new ArrayList<mj_cartDTO>();
	
	@GetMapping("/home")
	public String showHome() {
		return "home";
	}
	
	@GetMapping("/home2")
	public String showHome2() {
		return "home2";
	}
	
	
	
	@PostMapping("/showBestProducts")
	@ResponseBody
	public String showBestProducts() {
		
		ArrayList<mj_productDTO> products = mjdao.getBestProducts();
		JSONArray ja = new JSONArray();
		
		
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	
	
	
	@PostMapping("/showNewProducts")
	@ResponseBody
	public String showNewProducts() {
		
		ArrayList<mj_productDTO> products = mjdao.getNewProducts();
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	
	
	/////////////////////////////////////////// 여기까지가 home ///////////////////////////////////////////////
	
	/////////////////////////////////////////// 여기부터 상품list ////////////////////////////////////////
	
	@GetMapping("/goods_list")
	public String showGoods_list() {
		return "goods_list";
	}
	
	@PostMapping("/getProducts")
	@ResponseBody
	public String showGoods_list(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));
			ja.put(jo);
		}
		

		
		return ja.toString();
	}
	
	
	@GetMapping("/goods_list_kitchen")
	public String showGoods_list_kitchen(Model model) {
		return "goods_list_kitchen";
	}
	@PostMapping("/getKitchenProducts")
	@ResponseBody
	public String showGoods_list_kitchen(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getKitchenProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));
			
			ja.put(jo);
		}
		
	
		
		return ja.toString();
	}
	
	@GetMapping("/goods_list_home")
	public String showGoods_list_home(Model model) {
		return "goods_list_home";
	}
	@PostMapping("/getHomeProducts")
	@ResponseBody
	public String showGoods_list_Home(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getHomeProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));
		
			ja.put(jo);
		}
		
	
		
		return ja.toString();
	}
	
	
	@GetMapping("/goods_list_season")
	public String showGoods_list_season(Model model) {
		return "goods_list_season";
	}
	@PostMapping("/getSeasonalProducts")
	@ResponseBody
	public String showGoods_list_season(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getSeasonProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));
			
			ja.put(jo);
		}
		
	
		
		return ja.toString();
	}
	
	
	
	@GetMapping("/goods_list_best")
	public String showGoods_list_best() {
		return "goods_list_best";
	}
	@PostMapping("/getBestProducts")
	@ResponseBody
	public String showGoods_list_best(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getBestProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));
		
			ja.put(jo);
		}
		

		
		return ja.toString();
	}
	
	
	
	@GetMapping("/goods_list_new")
	public String showGoods_list_new(Model model) {
		ArrayList<mj_productDTO> products =  mjdao.getNewProducts();
		model.addAttribute("products",products);
		return "goods_list_new";
	}
	@PostMapping("/getNewProducts")
	@ResponseBody
	public String showGoods_list_New(HttpServletRequest req) {

		ArrayList<mj_productDTO> products = mjdao.getNewProducts();

		JSONArray ja = new JSONArray();
		
		for(int i=0;i<products.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", products.get(i).getProd_id());
			jo.put("prod_name", products.get(i).getProd_name());
			jo.put("prod_address", products.get(i).getProd_image());
			jo.put("prod_price", products.get(i).getProd_price());
			mj_reviewDTO review = mjdao.getReviewRate( products.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("prod_reviewRate", String.format("%.2f",reviewRate));

			ja.put(jo);
		}
		

		
		return ja.toString();
	}
	
	
	
	
	///////////////////////////////////// 여기까지 상품 list ////////////////////////////////////////////
	
	//////////////////////////////////// 여기부터 상품상세정보 ///////////////////////////////////////////
	
	@GetMapping("/goods_info/{seq}")
	public String show_good_info(@PathVariable("seq") int seq, Model model) {
			
		mj_productDTO product = mjdao.getProduct(seq);
		model.addAttribute("product",product);
		
		mj_reviewDTO review = mjdao.getReviewRate(product.getProd_id());
		float reviewRate = 0;
		if(review!=null) {reviewRate = review.getReview_rate();}
		model.addAttribute("review_rate",String.format("%.2f",reviewRate));
		
		
		ArrayList<mj_reviewDTO> reviews = mjdao.getReviews(seq);
		model.addAttribute("reviews",reviews);
		
		String leftover = "";
		if(product.getProd_amount()<=10 && product.getProd_amount()>0) {
			leftover = "<br><span id=leftover>남은수량 : " + product.getProd_amount() + "개" ;
		} else if(product.getProd_amount()<=0) {
			leftover = "<br><span id=leftover>매진됨</span>";
		}
		model.addAttribute("leftover",leftover);
		
		return "goods_info";
	}
	
	
	////////////////////////////////////// 구매하기 //////////////////////////////////////////
	
	
	// 바로구매시 
	@GetMapping("/doPurchase/{member_seq}/{prod_id}/{order_qty}/{order_price}")
	public String toOrder
	(@PathVariable("member_seq") int member_seq, 
	@PathVariable("prod_id") int prod_id, 
	@PathVariable("order_qty") int order_qty, 
	@PathVariable("order_price") int order_price, 
	Model model) {
	
		mj_productDTO product = mjdao.getProduct(prod_id);
		mj_memberDTO member = mjdao.getMember2(member_seq);
		
		model.addAttribute("member_seq", member_seq);
		model.addAttribute("prod_id", prod_id);
		model.addAttribute("prod_name",product.getProd_name());
		model.addAttribute("prod_image",product.getProd_image());
		model.addAttribute("order_qty", order_qty);
		model.addAttribute("order_price", order_price);
		
		model.addAttribute("member",member);
		
		String part1 = member.getMember_address().split(",")[0];
		String part2 = member.getMember_address().split(",")[1];
		String part3 = member.getMember_address().split(",")[2];
		
		model.addAttribute("part1",part1);
		model.addAttribute("part2",part2);
		model.addAttribute("part3",part3);
		
		return "order_info3";
	}
	
	
	
	@PostMapping("/addOrder")
	public String addOrder(HttpServletRequest req, Model model) {
		
		int cartFlag = 0;
		String[]cart_seqs = req.getParameterValues("cart_seq");
		if(cart_seqs!=null) {
			cartFlag = 1;
		}
		
		String[]prod_ids = req.getParameterValues("prod_id");
		String[]order_qtys = req.getParameterValues("order_qty");
		String[]order_prices = req.getParameterValues("order_price");
		
		int member_seq = Integer.parseInt( req.getParameter("member_seq") );
		String part1 = req.getParameter("part1");
		String part2 = req.getParameter("part2");
		String part3 = req.getParameter("part3");
		String order_address = part1+","+part2+","+part3; 
		
		String order_payment = req.getParameter("payment");
		String order_request = req.getParameter("order_request");
		String order_recipient = req.getParameter("order_recipient");
		String order_mobile = req.getParameter("order_mobile");
		
		
		
		// for문 돌리면서 만약에 주문수량이 상품재고보다 많으면 어떤상품이 재고가 몇개여서 주문실패했다고 안내하기
		String guide = "";
		String guide2 = "";
		int flag = 0;
		ArrayList<String> noMore = new ArrayList<String>(); 
		for(int i=0;i<prod_ids.length;i++) {	
												
			int prod_id = Integer.parseInt(prod_ids[i]);
			mj_productDTO product = mjdao.getProduct(prod_id);
			int order_qty = Integer.parseInt(order_qtys[i]);
			
			if(order_qty>product.getProd_amount()) {
				flag = 1;
				guide = guide + product.getProd_name() + " : " + product.getProd_amount() + "개 남음<br>";
			}
			
		}
	
		if(flag==1) {model.addAttribute("guide",guide) ;return "order_failed";}
		
		// 하나 더, for문 돌리면서 같은제품이 여러개 담겼을때, 그 제품의 총 합이 prod_amount 보다 크면 
		// 주문실패 
		
		   HashSet<String> hashSet = 
	                new HashSet<>(Arrays.asList(prod_ids));
		   String[]pids = hashSet.toArray(new String[0]);
		   
		   // pids 는 이제 중복이 제거된 product ids 
		   int[]pamounts = new int[pids.length];
		   
		   for(int i=0;i<pids.length;i++) { 
			   for(int j=0;j<prod_ids.length;j++) {
				  if(pids[i].equals(prod_ids[j])) {
					  pamounts[i] = pamounts[i] + Integer.parseInt( order_qtys[i] );
				  }
			   }
		   }
		   
		   System.out.println(Arrays.toString(pids));
		   System.out.println(Arrays.toString(pamounts));
		
		   int flag2 = 0;
		   for(int i=0;i<pids.length;i++) {
			   mj_productDTO product = mjdao.getProduct(Integer.parseInt( pids[i] ));
			   if(pamounts[i]>product.getProd_amount()) {
				   flag2=1;
				   guide2 = guide2 + product.getProd_name() + " : " + product.getProd_amount() + "개 남음<br>";
				   model.addAttribute("guide",guide2) ;return "order_failed";
			   }
		   }
		   
		   if(flag2==1) {model.addAttribute("guide",guide2) ;return "order_failed";}
		
		
		
		for(int i=0;i<prod_ids.length;i++) {
			
			int cart_seq = 0;
			if(cartFlag==1) {
				cart_seq = Integer.parseInt(cart_seqs[i]);
			}
			
			int prod_id = Integer.parseInt(prod_ids[i]);
			int order_qty = Integer.parseInt(order_qtys[i]);
			int order_price = Integer.parseInt(order_prices[i]);
					
			int reviewCount = mjdao.getReviews2(member_seq, prod_id);
			
			if(reviewCount==0) {
				mjdao.addOrder(member_seq, prod_id, order_qty, order_price, order_address,
						order_payment, order_request, order_recipient, order_mobile,"n");
			} else {
				mjdao.addOrder(member_seq, prod_id, order_qty, order_price, order_address,
						order_payment, order_request, order_recipient, order_mobile,"y");
			}
			
			mjdao.modifyInventory(prod_id, order_qty);
			
			if(cartFlag==1) {mjdao.deleteCart(cart_seq);}
	
		}
		
		
		return "order_complete";
	}
	
	@GetMapping("/addCart/{member_seq}/{prod_id}/{cart_qty}/{cart_price}")
	public String putIntoCart
	(@PathVariable("member_seq") int member_seq, 
	@PathVariable("prod_id") int prod_id, 
	@PathVariable("cart_qty") int cart_qty, 
	@PathVariable("cart_price") int cart_price,
	HttpServletResponse res,
	HttpServletRequest req) {
		
	if(member_seq!=-1) {
		mjdao.addCart(prod_id,cart_qty,cart_price,member_seq);
	}
		
	// 여기아래부터 비회원 카트담기. 수틀리면 그냥 나중에 아래만 지우면됨.
	 else {	// 비회원이 카트에 담을때 
		
		Cookie[]cookies = req.getCookies();	
		
		int cartflag = 0;
		for(int i=0;i<cookies.length;i++) { // for문이 돌면서 쿠키들의 이름을 검사함.
			
			if(cookies[i].getName().equals("cart")) {	
				
				// cart 라는 이름의 쿠키를 찾으면,
				// cartflag 를 1로 만듬(이전에 비회원으로 담은 cart쿠키가 있다는뜻)
				cartflag = 1;	
				
				String formerCart = cookies[i].getValue();
				String newCart = prod_id + "-" + cart_qty + "-" + cart_price;
				
				// 이전에 담아놓은 카트쿠키가 있으면 단순히 값을 추가하고, 다시 쿠키수명을 연장시킴 
				Cookie cookie = new Cookie("cart", formerCart + "and" + newCart);
				cookie.setMaxAge(60*60);	// 수명은 1시간 60*60
				cookie.setPath("/");	 // 모든 경로에서 접근가능
				res.addCookie(cookie);	// client 에게 쿠키 주기 
				
				
			}

		}
		// 검사했는데 cart 가 따로 없어서 cartflag==0 으로 return 되면,
		// 새로 cart cookie 를 만듬 
		
		if(cartflag==0) {
			
			String str = prod_id + "-" + cart_qty + "-" + cart_price;
			
			Cookie cookie = new Cookie("cart", str);	// 쿠키 이름/value 짓기
			cookie.setMaxAge(60*60);						// 쿠키수명설정
			cookie.setPath("/");						// 모든경로에서 접근가능
			res.addCookie(cookie);						// 쿠키 주기
			
		}
		
		
		
		// 그 다음에, 쿠키의 값을 꺼내서, client 에 출력함. 
		
		return "redirect:/cart2";
		
	}	// 여기까지 비회원 카트담기 
	
	/*
		String cookiename = req.getParameter("cookiename");
		int cookie_lifespan = Integer.parseInt(req.getParameter("cookie_lifespan"));
		
		
		Cookie cookie = new Cookie("mycookie", cookiename);
		cookie.setMaxAge(60*cookie_lifespan);
		res.addCookie(cookie);
		
		return "";
	
	*/
		return "cart";
	}
	
	
	@PostMapping("/addReview")
	@ResponseBody
	public String addReview(HttpServletRequest req) {

		int member_seq = Integer.parseInt(req.getParameter("member_seq") );
		int prod_id = Integer.parseInt( req.getParameter("prod_id") );
		int review_rate = Integer.parseInt(req.getParameter("review_rate") );
		String review_content = req.getParameter("review_content");
		
		// 리뷰먼저남겼는지 검증
		ArrayList<mj_reviewDTO> reviews = mjdao.getReviews(prod_id);
		for(int i=0;i<reviews.size();i++) {
			if(member_seq==reviews.get(i).getMseq()) {
				return "이미 리뷰가 작성된 제품입니다. 한 사람당 한 개의 리뷰를 쓸 수 있습니다.";
			}
		}
		// 여기까지 
		
		ArrayList<mj_orderDTO> orders = mjdao.findOrder(member_seq, prod_id);
		
		if(orders.size()==0) {
			return "구매기록이 존재하지 않습니다. 리뷰를 작성하기위해서는 먼저 물건을 구매하셔야 합니다.";
		} else {
			for(int i=0;i<orders.size();i++) {
				if(orders.get(i).getOrder_status().equals("y")) {
					int order_id = orders.get(i).getOrder_seq();
					mjdao.addReview(member_seq, prod_id, review_rate, review_content, order_id);
					mjdao.reviewRegister(member_seq, prod_id);
					return "";
				}
			}
		}
		
		// 근데 구매기록이 존재해도, order_status 가 y가 아니면 review 할 수 없음.
		// 같은 제품에 대한 여러가지 주문중에 order_status 가 하나라도 y 이어야 함.

		return "배송받으신 물건에 대해서만 리뷰를 작성할 수 있습니다. 아직 상품이 배송중입니다.";
	}
	
	@PostMapping("/refreshReviews")
	@ResponseBody
	public String refreshReviews(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		
		int prod_id = Integer.parseInt(req.getParameter("prod_id"));
		ArrayList<mj_reviewDTO> reviews = mjdao.getReviews(prod_id);
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<reviews.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			int review_seq = reviews.get(i).getReview_seq();
			
			String mid = reviews.get(i).getMid();
			String userid = (String)session.getAttribute("member_id");
			
			String buttonStr = "";
			
			jo.put("review_seq", reviews.get(i).getReview_seq());
			jo.put("member_id", mid);	
			jo.put("review_rate", reviews.get(i).getReview_rate());
			jo.put("review_content", reviews.get(i).getReview_content());	
			
			if(mid.equals(userid)) {
				buttonStr = "<button class=reviewDelete name="+ review_seq +">리뷰삭제</button>";
			}
			
			jo.put("buttonStr", buttonStr);		// review 가 현재 접속중인 유저의 review면 삭제버튼을 넣어줌
			
			ja.put(jo);
			
		}
	
		return ja.toString();
	}
	
	
	
	
	@PostMapping("/refreshReviews2")
	@ResponseBody
	public String refreshReviews2(HttpServletRequest req) {
		HttpSession session = req.getSession();
		
		int prod_id = Integer.parseInt( req.getParameter("prod_id") );
		// 제품번호 입력됨 
		int pageNum = Integer.parseInt( req.getParameter("pageNum") );
		// 사용자가 페이지 번호 클릭

		// 1번 페이지가 들어오면 그 제품에 대한 1~5 번 리뷰를 보여줘야함 
		// 2번 페이지가 들어오면 그 제품에 대한 6~10 번 리뷰를 보여줘야함 
		// 3번 페이지가 들어오면 그 제품에 대한 11~15 번 리뷰를 보여줘야함.
		
		ArrayList<mj_reviewDTO> reviews  = mjdao.getReviews(prod_id);
		
		
		
	
		// 이렇게하면 그 제품에 대한 리뷰를 모두 가져옴.
		
		// pageNum = 1 이면 1~5 번 리뷰 가져옴
		// pageNum = 2 이면 6~10 번 리뷰 가져옴 
		// pageNum = 3 이면 11~15 번 리뷰 가져옴 
		
		// 근데이건 DB rownum 기준이고, 우리가 arraylist 로 가져오면
		
		// pageNum = 1 이면 0~4번 review,
		// pageNum = 2 이면 5~9번 review 임.
		// pageNum = 3 이면 10~14번 review 임.
		
		// (pageNum-1)*5 번부터pageNum*5-1 번 리뷰까지 가져옴,
		
		int start = (pageNum-1)*10;
		int end = (pageNum*10)-1;

		JSONArray ja = new JSONArray();
		
		try {
		for(int i=start;i<=end;i++) {
			
			if(i>=start && i<=end) {
				
				JSONObject jo = new JSONObject();
				
				int review_seq = reviews.get(i).getReview_seq();
				
				String mid = reviews.get(i).getMid();
				String userid = (String)session.getAttribute("member_id");
				
				String buttonStr = "";
				
				jo.put("review_seq", reviews.get(i).getReview_seq());
				jo.put("member_id", mid);	
				jo.put("review_rate", reviews.get(i).getReview_rate());
				jo.put("review_content", reviews.get(i).getReview_content());	
				
				if(mid.equals(userid)) {
					buttonStr = "<button class=reviewDelete name="+ review_seq +">x</button>";
				}
				
				jo.put("buttonStr", buttonStr);		// review 가 현재 접속중인 유저의 review면 삭제버튼을 넣어줌
				
				ja.put(jo);
				
			}
	
		}
		} catch(Exception e) {
			
		}
	
		return ja.toString();
	}
	
	@PostMapping("/refreshPage")
	@ResponseBody
	public String refreshPage(HttpServletRequest req) {
		
		int prod_id = Integer.parseInt(req.getParameter("prod_id"));
		ArrayList<mj_reviewDTO> reviews  = mjdao.getReviews(prod_id);
		
		int howmanyReviews = reviews.size();
		int howmanyPages = (howmanyReviews/10)+1;
		if(howmanyReviews%10==0) {howmanyPages = howmanyPages-1;}
		
		return howmanyPages+"";
	}
	
	@PostMapping("/refreshReviewButton")
	@ResponseBody
	public String refreshReivewButton(HttpServletRequest req) {
		
		String result = "yesButton";
		
		
		HttpSession session = req.getSession();
		String userid = (String)session.getAttribute("member_id");
		
		int prod_id = Integer.parseInt(req.getParameter("prod_id"));
		ArrayList<mj_reviewDTO> reviews  = mjdao.getReviews(prod_id);
		
		for(int i=0;i<reviews.size();i++) {
			String reviewer = reviews.get(i).getMid();
			if(reviewer.equals(userid)) {
				result = "notButton"; break;	
				// 그 제품에대한 리뷰를 현재 접속중인유저가 하나라도 썼으면 리뷰작성창 안만들어줌
				// 한번도 안 썼으면 만들어줌 
			}
		}
		
		return result;
	}
	
	
	
	
	@PostMapping("/deleteReview")
	@ResponseBody
	public void deleteReview(HttpServletRequest req) {
		
		int review_seq = Integer.parseInt(req.getParameter("review_seq"));
		int member_seq = Integer.parseInt(req.getParameter("member_seq"));
		int prod_id = Integer.parseInt(req.getParameter("prod_id"));
		mjdao.deleteReview(review_seq);
		
		mjdao.reviewUnRegister(member_seq, prod_id);
	}
	
	
	
	
	@GetMapping("/order_info2/{cart_seqs}")
	public String doPurchase2
	(@PathVariable("cart_seqs") String cart_seqs, Model model,
			HttpServletRequest req) 
	{
		
		ArrayList<mj_cartDTO> carts = new ArrayList<mj_cartDTO>();
		
		String[]cart_seqs_str = cart_seqs.split(",");
		int[]cart_seqs_int = new int[cart_seqs_str.length];
		
		for(int i=0;i<cart_seqs_str.length;i++) {
			int seq = Integer.parseInt(cart_seqs_str[i]);
			cart_seqs_int[i] = seq; 
		}
		
		for(int i=0;i<cart_seqs_int.length;i++) {
			mj_cartDTO cart = mjdao.getCart(cart_seqs_int[i]);
			carts.add(cart);
		}

		model.addAttribute("carts",carts);
		System.out.println(carts);
		// 여기 위부분은 carts 에 있는 정보 database 에서 뒤져서 jsp 로 보내는 부분 
		// 여기부터는 접속중인 유저의 정보를 보내는  부분 
		
		HttpSession session = req.getSession();
		String userid = (String)session.getAttribute("member_id");
		System.out.println(userid);
		mj_memberDTO member = mjdao.getMember(userid);
		model.addAttribute("member",member);
		
		String part1 = member.getMember_address().split(",")[0];
		String part2 = member.getMember_address().split(",")[1];
		String part3 = member.getMember_address().split(",")[2];
		
		model.addAttribute("part1",part1);
		model.addAttribute("part2",part2);
		model.addAttribute("part3",part3);
		
		// order_price 도 보내야함 
		
		int order_price = 0;
		
		for(int i=0;i<carts.size();i++) {
			order_price = order_price + carts.get(i).getCart_price();
		}
		
		model.addAttribute("order_price",order_price);
		
		return "order_info2";
	}
	
/*
	@PostMapping("/addOrder2")
	public String addOrder2(HttpServletRequest req) {
		
	
		String[]prod_ids = req.getParameterValues("prod_id");
		String[]order_qtys = req.getParameterValues("order_qty");
		String[]order_prices = req.getParameterValues("order_price");
		
		int member_seq = Integer.parseInt( req.getParameter("member_seq") );
		String part1 = req.getParameter("part1");
		String part2 = req.getParameter("part2");
		String part3 = req.getParameter("part3");
		String order_address = part1+","+part2+","+part3; 
		
		String order_payment = req.getParameter("payment");
		String order_request = req.getParameter("order_request");
		String order_recipient = req.getParameter("order_recipient");
		String order_mobile = req.getParameter("order_mobile");
		
		for(int i=0;i<prod_ids.length;i++) {
			
			
			int prod_id = Integer.parseInt(prod_ids[i]);
			int order_qty = Integer.parseInt(order_qtys[i]);
			int order_price = Integer.parseInt(order_prices[i]);
					
			mjdao.addOrder(member_seq, prod_id, order_qty, order_price, order_address, 
					order_payment, order_request, order_recipient, order_mobile);
	
		}
	
		return "order_complete";
	}
*/	
	
	
	// 관리자에서 확인시 주문서 
	@GetMapping("order_info/{order_seq}")
	public String showOrderInfo(@PathVariable("order_seq") int order_seq, Model model) {
		
		//필요한거 : order_seq/member_seq/prod_id/order_qty/order_price 
		//		  prod_id 를 통해 prod_name/prod_image
		//		  member_seq 를 통해 member_name/member_mobile/member_eamil		>> 
		//		  order_address	> 3개로 쪼개서 각각 input 에 넣으면됨
		// 		  order_recipient, order_recipient_mobile, order_request
		// 		  order_payment 
		// 		  들이 필요함
		
		mj_orderDTO order = mjdao.getOrder(order_seq);
		mj_productDTO product = mjdao.getProduct(order.getProd_id());
		mj_memberDTO member = mjdao.getMember2(order.getMember_seq());
		
		System.out.println(order);
		System.out.println(product);
		System.out.println(member);
		
		model.addAttribute("order",order);
		model.addAttribute("product",product);
		model.addAttribute("member",member);
		
		String address = order.getOrder_address();
		String part1 = address.split(",")[0];model.addAttribute("part1",part1);
		String part2 = address.split(",")[1];model.addAttribute("part2",part2);
		String part3 = address.split(",")[2];model.addAttribute("part3",part3);

		
		return "order_info";
	}
	
	
	@PostMapping("/loadtop3")
	@ResponseBody
	public String getTop3() {
		
		ArrayList<mj_productDTO> top3 =  mjdao.getTop3();
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<top3.size();i++) {
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", top3.get(i).getProd_id());
			jo.put("prod_image", top3.get(i).getProd_image());
			jo.put("prod_name", top3.get(i).getProd_name());
			jo.put("prod_price", top3.get(i).getProd_price());
			
			mj_reviewDTO review = mjdao.getReviewRate( top3.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("review_rate", String.format("%.2f",reviewRate));
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	
	@PostMapping("/loadnew3")
	@ResponseBody
	public String getNew3() {
		
		ArrayList<mj_productDTO> new3 =  mjdao.getNew3();
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<new3.size();i++) {
			JSONObject jo = new JSONObject();
			
			jo.put("prod_id", new3.get(i).getProd_id());
			jo.put("prod_image", new3.get(i).getProd_image());
			jo.put("prod_name", new3.get(i).getProd_name());
			jo.put("prod_price", new3.get(i).getProd_price());
			
			mj_reviewDTO review = mjdao.getReviewRate( new3.get(i).getProd_id() );
			float reviewRate=0;
			if(review!=null) {reviewRate = review.getReview_rate();}
			jo.put("review_rate", String.format("%.2f",reviewRate));
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	
	
	@GetMapping("/cart2")
	public String howCart2(HttpServletRequest req, HttpServletResponse res, Model model) {
		
		Cookie[]cookies = req.getCookies();
		
		ArrayList<mj_cartDTO> stranger_carts = new ArrayList<mj_cartDTO>();
		
		for(int i=0;i<cookies.length;i++) {
			
			if(cookies[i].getName().equals("cart")) {
				
				
				String[]carts = cookies[i].getValue().split("and"); 
				
	
				for(int j=0;j<carts.length;j++) {
					
					mj_cartDTO aCart = new mj_cartDTO();
					
					int prod_id = Integer.parseInt( carts[j].split("-")[0] );
					int cart_qty = Integer.parseInt( carts[j].split("-")[1] );
					int cart_price = Integer.parseInt( carts[j].split("-")[2] );
					
					mj_productDTO product = mjdao.getProduct(prod_id);
					String prod_name = product.getProd_name();
					String prod_image = product.getProd_image();
					
					aCart.setCart_seq(j);
					aCart.setPid(prod_id);
					aCart.setCart_qty(cart_qty);
					aCart.setCart_price(cart_price);
					aCart.setProd_name(prod_name);
					aCart.setProd_image(prod_image);
					
					stranger_carts.add(aCart);
				}

				
				break;
			}
			
			
		}

		model.addAttribute("carts", stranger_carts);
		
		return "cart2";
	}
	
	
	@PostMapping("/deleteCookie")
	@ResponseBody
	public String deleteCookie(HttpServletRequest req, HttpServletResponse res) {
		
		String pid = req.getParameter("pid");
		String qty = req.getParameter("qty");
		String price = req.getParameter("price");
		
		String str = pid + "-" + qty + "-" + price;
		
		Cookie[]cookies = req.getCookies();
		
		Cookie cartCookie;
		
		String newCookie = "";
		
		for(int i=0;i<cookies.length;i++) {
			
			if(cookies[i].getName().equals("cart")) {
				cartCookie = cookies[i];
				String[]carts = cartCookie.getValue().split("and");
				
				ArrayList<String> mycarts = new ArrayList<String>();
				
				for(int j=0;j<carts.length;j++) {
					mycarts.add(carts[j]);
				}
				
				for(int j=0;j<mycarts.size();j++) {
					if(mycarts.get(j).equals(str)) {
						mycarts.remove(j);break;
					}
				}
				
				
				for(int j=0;j<mycarts.size();j++) {
					newCookie = newCookie + "and" + mycarts.get(j); 
				}
				
				newCookie = newCookie.replaceFirst("and", "");
				
				if(newCookie.length()>0) {
					Cookie cookie = new Cookie("cart", newCookie);	// 쿠키 이름/value 짓기
					cookie.setMaxAge(60*60);						// 쿠키수명설정
					cookie.setPath("/");						// 모든경로에서 접근가능
					res.addCookie(cookie);
					break;
				} else {
					Cookie cookie = new Cookie("cart", newCookie);	// 쿠키 이름/value 짓기
					cookie.setMaxAge(0);						// 쿠키수명설정
					cookie.setPath("/");						// 모든경로에서 접근가능
					res.addCookie(cookie);
					break;
				}
			
				

			}
		}
		
		
		return "";
	}
	
	@PostMapping("/deleteCookie2")
	@ResponseBody
	public String deleteCookie2(HttpServletRequest req, HttpServletResponse res) {
		
		Cookie[]currentCookies = req.getCookies();
		String cartCookiestr = "";
		for(int i=0;i<currentCookies.length;i++) {
			if(currentCookies[i].getName().equals("cart")) {
				cartCookiestr = currentCookies[i].getValue();break;
			}
		}
		
		ArrayList<String> cartcookies = new ArrayList<String>();
		for(int i=0;i<cartCookiestr.split("and").length;i++) {
			cartcookies.add(cartCookiestr.split("and")[i]);
		}
		
		// 여기까지 현재있는 쿠키를 arraylist에 담음.
		
		
		
		// 이제 받은 문자열을 array 로 나눠담음
		
		String deleteCartstr = req.getParameter("cartsToDelete");
		String[]cartsToDelete = deleteCartstr.split("and");
		
		for(int i=0;i<cartsToDelete.length;i++) {
			for(int j=0;j<cartcookies.size();j++) {
				if(cartcookies.get(j).equals(cartsToDelete[i])){
					cartcookies.remove(j);break;
				}
			}
		}
		
		String newCookiestr = "";
		for(int i=0;i<cartcookies.size();i++) {
			// 없으면 newCookiestr 는 빈문자열
			// 있으면 알아서 문자열만듬
			
			newCookiestr = newCookiestr + "and" + cartcookies.get(i);
		}
		newCookiestr = newCookiestr.replaceFirst("and", "");
		
		if(newCookiestr.length()==0) {
			Cookie cookie = new Cookie("cart",newCookiestr);
			cookie.setMaxAge(0);						
			cookie.setPath("/");						
			res.addCookie(cookie);
		} else {
			Cookie cookie = new Cookie("cart",newCookiestr);
			cookie.setMaxAge(60*60);						
			cookie.setPath("/");						
			res.addCookie(cookie);
		}
		
		return "";
	}
	
	
	
	
	
	
	
	
	
	@GetMapping("/chatting")
	public String showChatting(){
		return "chatting";
	}
	
	
	@PostMapping("/addChat")
	@ResponseBody
	public String doChatting(HttpServletRequest req) {
		
		String id = req.getParameter("id");
		String content = req.getParameter("content");
		mjdao.addChat(id, content);
		
		ArrayList<mj_chatDTO> chats = mjdao.showChat();
		if(chats.size()>=35) {
			int last = chats.get(chats.size()-1).getSeq();
			mjdao.deleteChat(last);
		}
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<chats.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("id", chats.get(i).getId());
			jo.put("content", chats.get(i).getContent());
			
			ja.put(jo);
		}
		
		return ja.toString();
	}
	

	@PostMapping("/loadChat")
	@ResponseBody
	public String loadChat(HttpServletRequest req) {
		
		ArrayList<mj_chatDTO> chats = mjdao.showChat();
		
		JSONArray ja = new JSONArray();
		
		for(int i=0;i<chats.size();i++) {
			
			JSONObject jo = new JSONObject();
			
			jo.put("id", chats.get(i).getId());
			jo.put("content", chats.get(i).getContent());
			
			ja.put(jo);
		}
		
		
		return ja.toString();
	}
	
	
	@PostMapping("/makeCookie")
	@ResponseBody
	public String makeCookie(HttpServletRequest req, HttpServletResponse res) {
		
		String cookiename = req.getParameter("cookiename");
		int cookie_lifespan = Integer.parseInt(req.getParameter("cookie_lifespan"));
		
		
		Cookie cookie = new Cookie("mycookie", cookiename);
		cookie.setMaxAge(60*cookie_lifespan);
		res.addCookie(cookie);
		
		Cookie[] cookies = req.getCookies();
		for(int i=0;i<cookies.length;i++) {
			String name = cookies[i].getName();
			System.out.println(name);
		}
		
		return "";
	}
	
	
	
	@GetMapping("/chatting2")
	public String showChatting2(){
		return "chatting2";
	}
	
	
	
	
	@GetMapping("/summernote")
	public String summerNote() {
		return "summernote";
	}
	
	@GetMapping("/pagenation")
	public String pagenation() {
		return "pagenation";
	}
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////////////////////
	
	
	@GetMapping("/addresspractice")
	public String showAddressPractice() {
		return "addresspractice";
	}
	
	@PostMapping("/sendAddress")
	public String getAddress(HttpServletRequest req) {
		String a = req.getParameter("part1");
		String b = req.getParameter("part2");
		String c = req.getParameter("part3");
		String d = req.getParameter("part4");

		return "";
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////
	

	
	@GetMapping("/form")
	public String showForm() {
		return "./parts/form_together";
	}
	
}
