package com.human.springboot;

import lombok.Data;

@Data
public class jh_selectreviewDTO {
	
	int oid;
	int mseq;
	int pid;
	String pname;
	String pimg;
	String lastorder;
	String firstorder;
	
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public int getMseq() {
		return mseq;
	}
	public void setMseq(int mseq) {
		this.mseq = mseq;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPimg() {
		return pimg;
	}
	public void setPimg(String pimg) {
		this.pimg = pimg;
	}
	public String getLastorder() {
		return lastorder;
	}
	public void setLastorder(String lastorder) {
		this.lastorder = lastorder;
	}
	public String getFirstorder() {
		return firstorder;
	}
	public void setFirstorder(String firstorder) {
		this.firstorder = firstorder;
	}
	
	
	
}
