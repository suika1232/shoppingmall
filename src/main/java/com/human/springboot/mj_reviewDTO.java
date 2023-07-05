package com.human.springboot;

import lombok.Data;

@Data
public class mj_reviewDTO {
	
	int review_seq;
	int mseq;
	String mid;
	float review_rate;
	String review_content;
	
	public int getReview_seq() {
		return review_seq;
	}
	public void setReview_seq(int review_seq) {
		this.review_seq = review_seq;
	}
	public int getMseq() {
		return mseq;
	}
	public void setMseq(int mseq) {
		this.mseq = mseq;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public float getReview_rate() {
		return review_rate;
	}
	public void setReview_rate(float review_rate) {
		this.review_rate = review_rate;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	
	



	
}
