package kr.green.lg.vo;

import java.text.DecimalFormat;

import lombok.Data;

@Data
public class ProductVO {
	private String pr_code;
	private String pr_thumb;
	private String pr_title;
	private String pr_content;
	private String pr_spec;
	private int pr_price;
	private String pr_ca_name;
	
	public String getPr_thumb_url() {
		return "/product/img" + pr_thumb;
	}
	
	public String getPr_price_str() {
		if(pr_price == 0)
			return"";
		DecimalFormat df = new DecimalFormat("#,###");
		return df.format(pr_price) + "원";
	}
}
