package kr.green.springtest.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.green.springtest.service.MemberService;
import kr.green.springtest.vo.MemberVO;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value= {"/"})
	public ModelAndView home(ModelAndView mv, MemberVO member){
	    mv.setViewName("/main/home");
	    return mv;
	}
	// 회원가입
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public ModelAndView signupGet(ModelAndView mv){
	    mv.setViewName("/main/signup");
	    return mv;
	}
	
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public ModelAndView signupPost(ModelAndView mv, MemberVO member){
			if(memberService.signup(member)) {
				mv.setViewName("redirect:/");
			}else {
				mv.setViewName("redirect:/signup");
			}
	    return mv;
	}
	//로그인
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView loginGet(ModelAndView mv){
	    mv.setViewName("/main/login");
	    return mv;
	}
	
	@RequestMapping(value= "/login", method=RequestMethod.POST)
	public ModelAndView loginPost(ModelAndView mv, MemberVO member){
		MemberVO dbMember = memberService.login(member);		
		if(dbMember != null)
			mv.setViewName("redirect:/");
		else
			mv.setViewName("redirect:/login");
		mv.addObject("user", dbMember);
		return mv;
	}
	
}
