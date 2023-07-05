package com.human.springboot;


import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class JAController {
	@Autowired	
	private IDAO idao;

    ///로그인 회원가입 관련///////////////////	
	@GetMapping("/login")
	public String login() {
		return "login";	
	}
	@GetMapping("/signin")
	public String signin() {
		return "signin";	
	}
	@GetMapping("/logout")
	public String dologout(HttpServletRequest req) {
		HttpSession session =req.getSession();
		session.invalidate();//모든 세션정보를 remove all
		return "redirect:/home";	
	}

    ///회원가입정보 DB에 넣기////////////////////
	@PostMapping("/member_signin")
	@ResponseBody
	public String doinsert(HttpServletRequest req, Model model) {
		String check="ok";
		String member_id=req.getParameter("loginid");
		String member_pw=req.getParameter("password");
		String member_name=req.getParameter("name");
		String member_mobile=req.getParameter("mobile");
		String member_email=req.getParameter("email");
		String member_class=req.getParameter("class");
		String postcode=req.getParameter("postcode");
		String address=req.getParameter("address");
		String detailAddress=req.getParameter("detailAddress");
		
		String member_address = postcode + "," + address + "," + detailAddress;
	
	
		idao.member_insert(member_id,member_pw,member_name,member_mobile,member_email,member_address,member_class);
		return check;
	}	
	///아이디 중복체크//////////////
	@PostMapping("/idChek")
	@ResponseBody
	public String idchek(HttpServletRequest req) {
		
		String member_id=req.getParameter("loginid");
		int result= idao.idChek(member_id);
			
		return Integer.toString(result); //int -> String (숫자를 문자열로)
	}
	
	////로그인 아이디랑 비번 DB랑 비교 /////////////////////
	@PostMapping("/doLogin")
	public String doLogin
	(HttpServletRequest req, 
	HttpSession session,
	Model model,
	HttpServletResponse res
			) {
		
		int member_seq = -1;
		
		String member_id = req.getParameter("loginid");
		String member_pw = req.getParameter("password");
		int n = idao.login(member_id, member_pw); 
		if (n == 0) {
			// 로그인 실패
			model.addAttribute("errorMessage1","아이디와 비밀번호를 확인해주세요.");
			return "login";
		} else {
			// 로그인 성공
			session.setAttribute("member_id",member_id);
			
			JA_memberDTO user = idao.getUserInfo(member_id, member_pw);
			String level = user.getMember_class();
			String name = user.getMember_name();
			int seq =  user.getMember_seq();
			session.setAttribute("member_class", level);
			session.setAttribute("member_seq", seq);
			session.setAttribute("member_name", name);
			
			member_seq = seq;
		}
		
		
		// 강민재 추가부분(비회원장바구니 -> 회원장바구니 카트쿠키 옮기기)
		
		Cookie[]cookies = req.getCookies();
		System.out.println(Arrays.toString(cookies));
		
		String cartCookieStr = "";
		for(int i=0;i<cookies.length;i++) {
			if(cookies[i].getName().equals("cart")) {
				cartCookieStr = cookies[i].getValue(); break;
			}
		}
		
		if(cartCookieStr.length()>0) {
		
			String[]carts = cartCookieStr.split("and");
			for(int i=0;i<carts.length;i++) {
				member_seq = member_seq;
				int prod_id =	Integer.parseInt( carts[i].split("-")[0] );
				int cart_qty =	Integer.parseInt( carts[i].split("-")[1] );
				int cart_price = Integer.parseInt( carts[i].split("-")[2] );
				
				idao.addCart(prod_id, cart_qty, cart_price, member_seq);
			}
			
			
		}
			
		Cookie cookie = new Cookie("cart","");
		cookie.setMaxAge(0);
		cookie.setPath("/");
		res.addCookie(cookie);
		//
		return "redirect:/home";
	}	
	///아이디 찾기////////
	@PostMapping("/idFind")
	@ResponseBody
	public String idFind(HttpServletRequest req) {
		String member_name=req.getParameter("name");
		String member_mobile=req.getParameter("mobile");
		String member_email=req.getParameter("email");
		
		String result= idao.idFind(member_name,member_mobile,member_email);
			
		return result; 
	}

		
	///////포스팅 관련//////////////////	
	//문의글 보기, 페이징
	@GetMapping("/post")
	public String doPost(@RequestParam(defaultValue = "1") int pageNo,
						 @RequestParam(defaultValue = "6") int amount, Model model) {
		ArrayList<JA_memberDTO> alNotice = idao.notice_view(); //공지는 고정
		model.addAttribute("notice",alNotice);
		
		ArrayList<JA_memberDTO> alpost = idao.paging(pageNo, amount); //문의글만 페이징 
		model.addAttribute("board",alpost);	
		
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("amount", amount);
		int totalCount = idao.getTotalCount();
		model.addAttribute("totalCount", totalCount);
		int endPage = (int) (Math.ceil((double) totalCount / amount));
		model.addAttribute("endPage", endPage);
		return "post";	
	}	
	//검색///////
	   @GetMapping("/post/search")
	   public String doSearch(@RequestParam(defaultValue = "1") int pageNo,
	                     @RequestParam(defaultValue = "6") int amount, 
	                        Model model, HttpServletRequest req, HttpSession session) {

	      ArrayList<JA_memberDTO> alNotice = idao.notice_view(); //공지는 고정
	      model.addAttribute("notice",alNotice);

	      
	      String keyword = req.getParameter("keyword"); //여기부터 검색 페이징
	      String type = req.getParameter("type");


	      if (keyword != null && type != null) {
	         session.setAttribute("keyword", keyword);
	         session.setAttribute("type", type);
	      }
	      else {
	         keyword = (String) session.getAttribute("keyword");
	         type = (String) session.getAttribute("type");
	      }

	      ArrayList<JA_memberDTO> alpost = new ArrayList<JA_memberDTO>();
	      int totalCount = 0;	    
	      if(!type.equals("")){
	    	  alpost = idao.searchPaging(pageNo, amount, type, keyword);
	    	  totalCount = idao.getTotalCount_search(type, keyword);    
	      }
	      
	      if(totalCount ==0) {
	    	  model.addAttribute("errorMessage","일치하는 검색 결과가 없습니다.");
	    	  return "post";
	      }

	      model.addAttribute("board",alpost);    
	      model.addAttribute("pageNo", pageNo);
	      model.addAttribute("amount", amount);
	      model.addAttribute("totalCount", totalCount);
	      int endPage = (int) (Math.ceil((double) totalCount / amount));
	      model.addAttribute("endPage", endPage);    

	      return "post";
	   }
	
	@GetMapping("/post_view")
	public String postView() {
		return "post_view";	
	}
	@GetMapping("/post_insert")
	public String postInsert() {
		return "post_insert";	
	}	
	
	///포스팅 업로드/////////
	@PostMapping("/post_upload")
	@ResponseBody
	public String post_upload(HttpServletRequest req) {
		
		String check="ok";
		String post_category=req.getParameter("post_category");
		int prod_category_code =Integer.parseInt(req.getParameter("prod_category_code"));
		int member_seq =Integer.parseInt(req.getParameter("member_seq"));
		String post_title=req.getParameter("title");
		String post_content=req.getParameter("summernote");
		System.out.println(post_content);
		String post_answer=req.getParameter("post_answer");
		String post_img=req.getParameter("post_img");		
		String post_comment=req.getParameter("post_comment");
		
		Pattern pa = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher match = pa.matcher(post_content);
		String fileName="";
		if(match.find()) {
			String str = match.group(0);
			System.out.println(str);
			str = str.substring(str.indexOf("\"")+1,str.length());
			str = str.replace("/imageTemp/", "");
			fileName = str.substring(0,str.indexOf("\""));
			System.out.println(fileName);
		}
		
		String path = 
				"C:/Users/admin/eclipse-workspace/ShoppingMall2/src/main/resources/static/post_img";
		
		try {
			Path oldPath = Paths.get("C:/imageTemp"+"/"+fileName); 
			Path newPath = Paths.get(path+"/"+fileName);
			Files.move(oldPath, newPath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("file move failed");
		}
		File tempFile = new File("C:/imageTemp");
		if(tempFile.isDirectory()) {
			File[] tempFiles = tempFile.listFiles();
			if(tempFiles.length>0) {
				for(int i=0; i<tempFiles.length; i++) {
					tempFiles[i].delete();
				}
			}
		}
		post_content = post_content.replace("/imageTemp/", "/post_img/");
		
		idao.post_upload(post_category,prod_category_code,member_seq, post_title,post_content,post_answer,post_img,post_comment);
		return check;
	}
	////서머노트 이미지
	@PostMapping("/post_summernote_image")
	@ResponseBody
	public String postSummernoteImage(@RequestParam(value="file")MultipartFile multi) {
		String imagePath = "";
		try {
			String path = "C:/imageTemp";
			File imageFile = new File( path, multi.getOriginalFilename() );
			multi.transferTo(imageFile);
			imagePath = "/imageTemp/"+multi.getOriginalFilename();
			System.out.println(imagePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return imagePath;
	}

	
	////포스팅 내용 확인,수정,삭제 & 관리자 답변달기
	@PostMapping("/doView")
	public String doUpdate(HttpServletRequest req,Model model) {
		String title=req.getParameter("title");
		String summernote=req.getParameter("summernote");
		String writer=req.getParameter("writer");
		model.addAttribute("post_seq",req.getParameter("post_seq"));
		model.addAttribute("title",title);
		model.addAttribute("writer",writer);
		model.addAttribute("summernote",summernote);
		
		return "post_update";
	}	
	//클릭한 글 보기 
	@GetMapping("/post_view/{post_seq}")
	public String doview(@PathVariable("post_seq") int post_seq,Model model) {
		model.addAttribute("board",idao.read_post(post_seq));
		return"post_view";
	}
	//포스팅 삭제
	@GetMapping("/delete_post/{post_seq}")
	public String doDelete(@PathVariable("post_seq") int post_seq) {
		idao.delete_post(post_seq);
		return "redirect:/post";
	}
	@PostMapping("/post_update")
	public String post_update() {
		return "post_update";
	}
	//포스팅 수정 
	@PostMapping("/update_post")
	@ResponseBody
	public String doUpdate(HttpServletRequest req) {
		String check="ok";
		int prod_category_code =Integer.parseInt(req.getParameter("prod_category_code"));
		String post_title=req.getParameter("title");
		String post_content=req.getParameter("summernote");
		int post_seq=Integer.parseInt(req.getParameter("post_seq")); 
		
		Pattern pa = Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher match = pa.matcher(post_content);
		String fileName="";
		if(match.find()) {
			String str = match.group(0);
			System.out.println(str);
			str = str.substring(str.indexOf("\"")+1,str.length());
			str = str.replace("/imageTemp/", "");
			fileName = str.substring(0,str.indexOf("\""));
			System.out.println(fileName);
		}
		
		String path = 
				"C:/Users/admin/eclipse-workspace/ShoppingMall2/src/main/resources/static/post_img";
		
		try {
			Path oldPath = Paths.get("C:/imageTemp"+"/"+fileName); 
			Path newPath = Paths.get(path+"/"+fileName);
			Files.move(oldPath, newPath, StandardCopyOption.REPLACE_EXISTING);
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("file move failed");
		}
		File tempFile = new File("C:/imageTemp");
		if(tempFile.isDirectory()) {
			File[] tempFiles = tempFile.listFiles();
			if(tempFiles.length>0) {
				for(int i=0; i<tempFiles.length; i++) {
					tempFiles[i].delete();
				}
			}
		}
		post_content = post_content.replace("/imageTemp/", "/post_img/");
		
		idao.update_post(prod_category_code,post_title,post_content,post_seq);
		return check;
		
	}
	//관리자 답변달기& 답변완료로 변경 & 답변 수정도 같이~ 
	@PostMapping("/comment_upload")
	@ResponseBody
	public String comment_upload(HttpServletRequest req) {
		String check="ok";
		String post_answer=req.getParameter("post_answer1");	
		String post_comment=req.getParameter("comment");	
		int post_seq=Integer.parseInt(req.getParameter("post_seq")); 
//		System.out.println(post_answer);
//		System.out.println(post_comment);
//		System.out.println(post_seq);
		idao.comment_upload(post_answer,post_comment,post_seq);
		return check;
	}

	//관리자 삭제 & 다시 답변대기로 변경
		@PostMapping("/delete_comment")
		@ResponseBody
		public String delete_comment(HttpServletRequest req) {
			String check="ok";
			String post_answer=req.getParameter("post_answer2");	
			String post_comment=req.getParameter("comment");	
			int post_seq=Integer.parseInt(req.getParameter("post_seq")); 
			System.out.println(post_answer);
			System.out.println(post_comment);
			System.out.println(post_seq);
			idao.delete_comment(post_answer,post_comment,post_seq);
			return check;
		}
	
	
	
	
	
	
}
