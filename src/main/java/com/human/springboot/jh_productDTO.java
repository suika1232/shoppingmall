package com.human.springboot;

import lombok.Data;

@Data
public class jh_productDTO {
		int prod_id;
		String prod_code;
		int prod_category_code;
		String prod_name;
		int prod_price;
		String prod_image;
		int prod_amount_sold;
		String prod_created;
		String prod_desc;
		int prod_amount;
		
		public int getProd_id() {
			return prod_id;
		}
		public void setProd_id(int prod_id) {
			this.prod_id = prod_id;
		}
		public String getProd_code() {
			return prod_code;
		}
		public void setProd_code(String prod_code) {
			this.prod_code = prod_code;
		}
		public int getProd_category_code() {
			return prod_category_code;
		}
		public void setProd_category_code(int prod_category_code) {
			this.prod_category_code = prod_category_code;
		}
		public String getProd_name() {
			return prod_name;
		}
		public void setProd_name(String prod_name) {
			this.prod_name = prod_name;
		}
		public int getProd_price() {
			return prod_price;
		}
		public void setProd_price(int prod_price) {
			this.prod_price = prod_price;
		}
		public String getProd_image() {
			return prod_image;
		}
		public void setProd_image(String prod_image) {
			this.prod_image = prod_image;
		}
		public int getProd_amount_sold() {
			return prod_amount_sold;
		}
		public void setProd_amount_sold(int prod_amount_sold) {
			this.prod_amount_sold = prod_amount_sold;
		}
		public String getProd_created() {
			return prod_created;
		}
		public void setProd_created(String prod_created) {
			this.prod_created = prod_created;
		}
		public String getProd_desc() {
			return prod_desc;
		}
		public void setProd_desc(String prod_desc) {
			this.prod_desc = prod_desc;
		}
		public int getProd_amount() {
			return prod_amount;
		}
		public void setProd_amount(int prod_amount) {
			this.prod_amount = prod_amount;
		}
		
		
		
}
