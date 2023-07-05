package com.human.springboot;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class Sw_ManagerController {
	
	@Autowired
	private ManagerDAO mdao;
	
	// 이미지 저장 경로
	private String path =
			"C:\\Users\\admin\\eclipse-workspace\\ShoppingMall2\\src\\main\\resources\\static\\img\\prod_img";
	// desc 이미지 저장 경로
	private String descPath =
			"C:\\Users\\admin\\eclipse-workspace\\ShoppingMall2\\src\\main\\resources\\static\\img\\prod_desc_img";
	// 임시파일 저장 경로
	private String tempPath = "D:\\imgPath";
	// 관리자모드 메인
	@GetMapping("/manager_home")
	public String managerHome(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_home";
	}
	// 관리자모드 회원관리
	@GetMapping("/manager_user")
	public String managerUser(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_user";
	}
	// 회원리스트 불러오기
	@PostMapping("/loadMemberList")
	@ResponseBody
	public String loadMemberList(
			@RequestParam(value="no", required = false, defaultValue = "1")String no, 
			@RequestParam(value="amount", required = false, defaultValue = "10")String amount) {
		ManagerPagination mp = new ManagerPagination();
		
		mp.setPageNo(Integer.parseInt(no));
		mp.setAmount(Integer.parseInt(amount));
		
		int total = mdao.getMemberCount();
		int totalPage = mp.getTotalPage(total);
		ArrayList<ManagerDTO> mList = mdao.memberListPaging(mp);
		
		JSONArray ja = new JSONArray();
		for(int i=0; i<mList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("member_id", mList.get(i).getMember_id());
			jo.put("member_name", mList.get(i).getMember_name());
			jo.put("member_email", mList.get(i).getMember_email());
			jo.put("member_mobile", mList.get(i).getMember_mobile());
			jo.put("member_created", mList.get(i).getMember_created());
			jo.put("total", totalPage);
			ja.put(jo);
		}
		return ja.toString();
	}
	// 관리자모드 주문관리
	@GetMapping("/manager_order")
	public String managerOrder(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_order";
	}
	// 주문리스트 불러오기
	@PostMapping("/loadOrderList")
	@ResponseBody
	public String managerOrderList(
			@RequestParam(value="no", required = false, defaultValue = "1")String no, 
			@RequestParam(value="amount", required = false, defaultValue = "10")String amount) {
		ManagerPagination mp = new ManagerPagination();
		
		mp.setPageNo(Integer.parseInt(no));
		mp.setAmount(Integer.parseInt(amount));

		System.out.println("CurrPage: "+mp.getPageNo());
		System.out.println("viewAmount: "+mp.getAmount());
		
		int total = mdao.getOrderCount();
		System.out.println("order list count: "+total);
		
		int totalPage = mp.getTotalPage(total);
		System.out.println("total page: "+totalPage);
		
		ArrayList<ManagerDTO> list = mdao.orderListPaging(mp);
		
		JSONArray ja = new JSONArray();
		for(int i=0; i<list.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("order_seq", list.get(i).getOrder_seq());
			jo.put("order_date", list.get(i).getOrder_date());
			if(list.get(i).getOrder_status().equals("y")) {
				jo.put("order_status", "배송완료");
			}else if(list.get(i).getOrder_status().equals("n")){
				jo.put("order_status", "결제완료");
			}else {
				jo.put("order_status", "확인실패");
			}
			jo.put("prod_id", list.get(i).getProd_id());
			jo.put("total", totalPage);
			ja.put(jo);
		}
		return ja.toString();
	}
	// 주문상태 변경
	@PostMapping("/orderStatusUpdate")
	@ResponseBody
	public String orderStatusUpdate(@RequestParam(value="orderSeqList")String[] seqList) {
		String result = "Complete";
		try {
			System.out.println("orderSeqList: "+Arrays.toString(seqList));
			for(int i=0; i<seqList.length; i++) {
				int seq = Integer.parseInt(seqList[i]);
				mdao.orderStatusUpdate(seq);
			}
		}catch(Exception e) {
			result = "Fail";
		}
		return result;
	}
	// 주문취소
	@PostMapping("/orderCancel")
	@ResponseBody
	public String orderCancel(@RequestParam(value="orderSeqList")String[] seqList) {
		String result = "Complete";
//		try {
			for(int i=0; i<seqList.length; i++) {
				int seq = Integer.parseInt(seqList[i]);
				ManagerDTO orderInfo = mdao.orderProdQty(seq);
				mdao.orderCancel(seq);
				mdao.refillProdQty(orderInfo.getProd_id(), orderInfo.getOrder_qty());
				System.out.println("order :"+seq+" cancel");
			}
//		}catch(Exception e) {
//			result = "Fail";
//		}
		return result;
	}
	// 관리자모드 제품관리 페이지
	@GetMapping("/manager_product")
	public String managerProd(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_product";
	}
	// 제품리스트 불러오기
	@PostMapping("/loadProdList")
	@ResponseBody
	public String loadProdList(
			@RequestParam(value="no", required = false, defaultValue = "1")String no, 
			@RequestParam(value="amount", required = false, defaultValue = "10")String amount) {
		ManagerPagination mp = new ManagerPagination();
		
		mp.setPageNo(Integer.parseInt(no));
		mp.setAmount(Integer.parseInt(amount));

		System.out.println("prod currPage: "+mp.getPageNo());
		System.out.println("prod viewAmount: "+mp.getAmount());
		
		int total = mdao.getProdCount();
		System.out.println("prod list count: "+total);
		
		int totalPage = mp.getTotalPage(total);
		System.out.println("prod total page: "+totalPage);
		
		ArrayList<ManagerDTO> mList = mdao.prodListPaging(mp);
		JSONArray ja = new JSONArray();
		for(int i=0; i<mList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("prod_id", mList.get(i).getProd_id());
			jo.put("prod_category", mList.get(i).getCategory_name());
			jo.put("prod_code", mList.get(i).getProd_code());
			jo.put("prod_name", mList.get(i).getProd_name());
			jo.put("prod_price", mList.get(i).getProd_price());
			jo.put("prod_amount", mList.get(i).getProd_amount());
			jo.put("total", totalPage);
			ja.put(jo);
		}
		return ja.toString();
	}
	// 관리자모드 제품등록 페이지
	@GetMapping("/manager_product_insert")
	public String managerProdInsert(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_product_insert";
	}
	// 제품수정 페이지
	@GetMapping("/manager_product_update/{id}")
	public String managerProdInsert(@PathVariable("id")String id, HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		
		int prodId = Integer.parseInt(id);
		ManagerDTO prodInfo = mdao.prodInfo(prodId);
		model.addAttribute("prod_id", prodId);
		prodInfo.prod_desc = prodInfo.prod_desc.replace("\"", "");
		System.out.println("update page desc "+prodInfo.prod_desc);
		model.addAttribute("prod_info", prodInfo);
		model.addAttribute("updateFlag", "y");
		
		return "manager_product_insert";
	}
	// 제품 카테고리 불러오기
	@PostMapping("/loadProdCategory")
	@ResponseBody
	public String loadProdCategory() {
		ArrayList<ManagerDTO> mList = mdao.prodCategoryList();
		JSONArray ja = new JSONArray();
		for(int i=0; i<mList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("category_code", mList.get(i).getCategory_code());
			jo.put("category_name", mList.get(i).getCategory_name());
			ja.put(jo);
		}
		return ja.toString();
	}
	// 제품등록 및 이미지 업로드
	@PostMapping("/insertProduct")
	@ResponseBody
	public String insertProduct(@RequestParam(value="code")String code,
								@RequestParam(value="category")String category,
								@RequestParam(value="name")String name,
								@RequestParam(value="price")String price,
								@RequestParam(value="desc")String desc,
								@RequestParam(value="qty")String qty,
								@RequestParam(value="imgFile")MultipartFile multi) {
		String result = "Complete";
		try {
			System.out.println("new file name:"+multi.getName());
			System.out.println("new file size: "+multi.getSize());
			System.out.println("new file origianl name: "+multi.getOriginalFilename());
			String originalName = multi.getOriginalFilename();
			String extension = originalName.substring(originalName.length()-4, originalName.length());
			String newFileName = code+name+extension;
			File file = new File(path, newFileName);
			multi.transferTo(file);
			String prodImg = "/img/prod_img/"+newFileName;
			mdao.prodInsert(code, Integer.parseInt(category), name, Integer.parseInt(price),
					        prodImg, desc, Integer.parseInt(qty));
			String descImage = extractImg(desc);
			tempFileReplace(descImage);
			tempFileDelete();
		}catch(Exception e) {
			result = "Fail";
		}
		return result;
	}
	// 제품수정 및 이미지 업로드
	@PostMapping("/updateProduct")
	@ResponseBody
	public String updateProduct(@RequestParam(value="id")String id,
								@RequestParam(value="code")String code,
								@RequestParam(value="category")String category,
								@RequestParam(value="name")String name,
								@RequestParam(value="price")String price,
								@RequestParam(value="desc")String desc,
								@RequestParam(value="qty")String qty,
								@RequestParam(value="imgFile")MultipartFile multi) {
		String result = "Complete";
		try {
			System.out.println("update file name:"+multi.getName());
			System.out.println("update file size: "+multi.getSize());
			System.out.println("update file origianl name: "+multi.getOriginalFilename());
			String originalName = multi.getOriginalFilename();
			String extension = originalName.substring(originalName.length()-4, originalName.length());
			String newFileName = code+name+extension;
			File file = new File(path, newFileName);
			multi.transferTo(file);
			String prodImg = "/img/prod_img/"+newFileName;
			int prodId = Integer.parseInt(id);
			ManagerDTO prodInfo = mdao.prodInfo(prodId);
			String oldProdImage = prodInfo.prod_image.replace("/img/prod_img/", ""); 
			String oldDescImage = extractImg(prodInfo.prod_desc);
			mdao.prodUpdate(prodId ,code, Integer.parseInt(category), name, 
							Integer.parseInt(price), prodImg, desc, Integer.parseInt(qty));
			String descImage = extractImg(desc);
			tempFileReplace(descImage);
			tempFileDelete();
			System.out.println("oldProd: "+oldProdImage+", "+"newProd: "+prodImg);
			System.out.println("oldDesc: "+oldDescImage+", "+"newDesc: "+descImage);
			if(!newFileName.equals(oldProdImage)) {
				imageFileDelete(oldProdImage);
			}
			if(!descImage.equals(oldDescImage)) {
				descImageFileDelete(oldDescImage);
			}
		}catch(Exception e) {
			result = "Fail";
		}
		return result;
	}
	// img tag 추출
	public String extractImg(String str) {
		Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher matcher = pattern.matcher(str);
		String imgName = "";
		if(matcher.find()) {
			imgName = matcher.group(0);
			imgName = imgName.substring(imgName.indexOf("/")+1);
			imgName = imgName.substring(imgName.indexOf("/")+1);
			imgName = imgName.substring(0,imgName.indexOf("\""));
			System.out.println(str+" to "+imgName);
		}
		return imgName;
	}
	// summernote 이미지 업로드
	@PostMapping("/summernote_img")
	@ResponseBody
	public String summerImg(@RequestParam(value="summerImg")MultipartFile multi) {
		String imgPath ="";
		try {
			String uploadedName = multi.getOriginalFilename();
			System.out.println("uploaded name: "+uploadedName);
			String extension = uploadedName.substring(uploadedName.length()-4, uploadedName.length());
			String savedName = UUID.randomUUID().toString().replace("-", "")+extension;
			System.out.println("saved name: "+savedName);
			
			File saveFile = new File(tempPath, savedName);
			multi.transferTo(saveFile);
			
			imgPath = "/tempPath/"+savedName;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return imgPath;
	}
	// 임시파일 이동
	public void tempFileReplace(String fileName) {
		try {
			Path oldFile = Paths.get(tempPath+"/"+fileName);
			Path newFile = Paths.get(descPath+"/"+fileName);
			Files.move(oldFile, newFile, StandardCopyOption.REPLACE_EXISTING);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	// 임시파일 삭제
	public void tempFileDelete() {
		try {
			File tempFolder = new File(tempPath);
			if(tempFolder.isDirectory()) {
				File[] tempFiles = tempFolder.listFiles();
				for(int i=0; i<tempFiles.length; i++) {
					System.out.println("found file: "+tempFiles[i].getName());
					if(tempFiles[i].delete()) {
						System.out.println("file delete success");
					}else {
						System.out.println("file delete failed");
					}
				}
			}
		}catch(Exception e) {
			System.out.println("file delete fail");
		}
	}
	// 제품삭제
	@PostMapping("/deleteProd")
	@ResponseBody
	public String deleteProd(@RequestParam(value="prodIdList")String[] prodIdList) {
		String result = "Complete";
		try {
			System.out.println("prodIdList: "+Arrays.toString(prodIdList));
			for(int i=0; i<prodIdList.length; i++) {
				int prodId = Integer.parseInt(prodIdList[i]);
				ManagerDTO prodInfo = mdao.prodInfo(prodId);
				String image = prodInfo.prod_image.replace("/img/prod_img/", "");
				String descImage = extractImg(prodInfo.prod_desc);
				imageFileDelete(image);
				descImageFileDelete(descImage);
				mdao.prodDelete(prodId);
			}
		}catch(Exception e) {
			result = "Fail";
		}
		return result;
	}
	// 제품 이미지파일 삭제
	public void imageFileDelete(String image) {
		try {
			File imageFile = new File(path+"/"+image);
			if(imageFile.delete()) {
				System.out.println("image delete success: "+image);
			}
		}catch(Exception e) {
			System.out.println("image delete fail: "+image);
		}
	}
	// 제품상세 이미지파일 삭제
	public void descImageFileDelete(String descImage) {
		try {
			File descImageFile = new File(descPath+"/"+descImage);
			if(descImageFile.delete()) {
				System.out.println("desc image delete success: "+descImage);
			}
		}catch(Exception e) {
			System.out.println("desc image delete fail: "+descImage);
		}
	}
	// 제품 재고 조회
	@PostMapping("/getProdAmount")
	@ResponseBody
	public String getProdAmount(@RequestParam(value="prodId")String prodId) {
		ManagerDTO prodInfo = mdao.getProdAmount(Integer.parseInt(prodId));
		System.out.println(prodInfo.getProd_id()+" "+prodInfo.getProd_name()+" "+prodInfo.getProd_amount());
		JSONObject jo = new JSONObject();
		jo.put("prod_id", prodId);
		jo.put("prod_name", prodInfo.getProd_name());
		jo.put("prod_amount", prodInfo.getProd_amount());
		return jo.toString(); 
	}
	// 제품 재고 수정
	@PostMapping("/updateProdAmount")
	@ResponseBody
	public void updateProdAmount(@RequestParam(value="prodId")String prodId,
								   @RequestParam(value="addAmount")String addAmount) {
		try {
			mdao.updateProdAmount(Integer.parseInt(prodId), Integer.parseInt(addAmount));
			System.out.println(prodId+" amount updated");
		}catch(Exception e) {
			System.out.println("amount update fail");
		}
	}
	// 제품 재고 비우기
	@PostMapping("/emptyProdAmount")
	@ResponseBody
	public void emptyProdAmount(@RequestParam(value="prodId")String prodId) {
		mdao.emptyProdAmount(Integer.parseInt(prodId));
		System.out.println(prodId+" amount set=0");
	}
	// 관리자 문의관리
	@GetMapping("/manager_cs")
	public String managerCs(HttpServletRequest req, Model model) {
		HttpSession session = req.getSession();
		String member_class = (String)session.getAttribute("member_class");
		if(member_class==null) member_class = "";
		System.out.println("class: "+member_class);
		model.addAttribute("member_class", member_class);
		return "manager_cs";
	}
	// 문의 리스트
	@PostMapping("/loadCsList")
	@ResponseBody
	public String managerCsList(
			@RequestParam(value="no", required=false, defaultValue="1")String no, 
			@RequestParam(value="amount", required=false, defaultValue="10")String amount) {
		ManagerPagination mp = new ManagerPagination();
		
		mp.setPageNo(Integer.parseInt(no));
		mp.setAmount(Integer.parseInt(amount));
		
		int total = mdao.getCsCount();
		int totalPage = mp.getTotalPage(total);
		
		ArrayList<ManagerDTO> csList = mdao.csListPaging(mp);
		
		JSONArray ja = new JSONArray();
		for(int i=0; i<csList.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("post_seq", csList.get(i).getPost_seq());
			jo.put("category_name", csList.get(i).getCategory_name());
			jo.put("member_id", csList.get(i).getMember_id());
			jo.put("post_created", csList.get(i).getPost_created());
			jo.put("post_title", csList.get(i).getPost_title());
			jo.put("post_answer", csList.get(i).getPost_answer());
			jo.put("total", totalPage);
			ja.put(jo);
		}
		return ja.toString();
	}
	// 문의글 불러오기
	@PostMapping("/loadCsPost")
	@ResponseBody
	public String loadCsPost(@RequestParam(value="postSeq")String postSeq) {
		System.out.println(postSeq);
		ManagerDTO csPost = mdao.csPost(Integer.parseInt(postSeq));
		JSONObject jo = new JSONObject();
		jo.put("category_name", csPost.getCategory_name());
		jo.put("post_title", csPost.getPost_title());
		jo.put("post_content", csPost.getPost_content());
		return jo.toString();
	}
	// 문의답변 작성
	@PostMapping("/insertComment")
	@ResponseBody
	public String insertComment(HttpServletRequest req) {
		System.out.println(req.getParameter("postSeq"));
		System.out.println(req.getParameter("postComment"));
		String result = "Complete";
		try {
			mdao.csCommentUpdate(Integer.parseInt(req.getParameter("postSeq")),
								 req.getParameter("postComment"));
		}catch(Exception e) {
			result = "Fail";
		}
		return result;
	}
}
