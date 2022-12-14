package kr.green.lg.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.green.lg.pagenation.Criteria;
import kr.green.lg.pagenation.PageMaker;
import kr.green.lg.service.ProductService;
import kr.green.lg.vo.CategoryVO;
import kr.green.lg.vo.LikesVO;
import kr.green.lg.vo.MemberVO;
import kr.green.lg.vo.ProductVO;


@Controller
public class ProductController {
	
	@Autowired
	ProductService productService;
	
	@RequestMapping(value = "/product/select", method = RequestMethod.GET)
	public ModelAndView productSelectGet(ModelAndView mv, String pr_code,
			HttpSession session) {
		ProductVO product = productService.selectProduct(pr_code);
		MemberVO user = (MemberVO)session.getAttribute("user");
		LikesVO like = productService.getLikes(pr_code, user);
		
		mv.addObject("li", like);
		mv.addObject("p", product);
		mv.setViewName("/product/select");
		return mv;
	}
	
	@RequestMapping(value = "/product/list", method = RequestMethod.GET)
	public ModelAndView productListGet(ModelAndView mv, String ca_name) {
		mv.addObject("pr_ca_name", ca_name);
		mv.setViewName("/product/list");
		return mv;
	}
	
	@RequestMapping(value = "/likes/list", method = RequestMethod.GET)
	public ModelAndView likesListGet(ModelAndView mv, HttpSession session) {
		MemberVO user = (MemberVO)session.getAttribute("user");
		ArrayList<ProductVO> productList = productService.selectProductListByLikes(user);
		
		mv.addObject("list", productList);
		mv.setViewName("/product/likesList");
		return mv;
	}
	/*----- ajax ------------------------------------------------------------------------*/
	@RequestMapping(value = "/category/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> categoryList() {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<CategoryVO> categoryList = productService.getCategoryList();
		
		map.put("list", categoryList);
		return map;
	}
	
	@RequestMapping(value = "/ajax/product/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> ajaxProductList(@RequestBody Criteria cri) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		ArrayList<ProductVO> productList = productService.selectProductList(cri);
		
		int totalCount = productService.getProductTotalCount(cri);
		PageMaker pm = new PageMaker(totalCount, 2, cri);
		
		map.put("pm", pm);
		map.put("list", productList);
		return map;
	}
	
	@RequestMapping(value = "/likes", method = RequestMethod.POST)
	@ResponseBody
	public Map<Object, Object> likes(@RequestBody LikesVO likes) {
		HashMap<Object, Object> map = new HashMap<Object, Object>();
		int res = productService.updateLikes(likes);
		map.put("res", res);
		return map;
	}
}
