package kr.green.springtest.service;

import java.util.ArrayList;
import java.util.Date;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import kr.green.springtest.dao.MemberDAO;
import kr.green.springtest.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	private JavaMailSender mailSender;

	@Override
	public boolean signup(MemberVO member) {
		//유효성 검사
		if(member == null)
			return false;
		
		if(member.getMe_id() == null || member.getMe_id().length() == 0)
			return false;
		
		if(member.getMe_pw() == null || member.getMe_pw().length() == 0)
			return false;
		
		if(member.getMe_gender() == null && member.getMe_gender().length() == 0)
			return false;
		
		if(member.getMe_email() == null || member.getMe_email().length() == 0)
			return false;
		
		if(member.getMe_birth() == null)
			return false;
		
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
		//이미 가입된 아이디면
		if(dbMember != null)
			return false;
		//비밀번호 암호화
		String encodePw = passwordEncoder.encode(member.getMe_pw());
		member.setMe_pw(encodePw);
		
		memberDao.insertMember(member);
		return true;
	}

	@Override
	public MemberVO login(MemberVO member) {
		if(member == null || member.getMe_id() == null)
			return null;
		
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
		//가입된 아이디가 아니면
		if(dbMember == null)
			return null;
		
		dbMember.setAutoLogin(member.isAutoLogin());
		
		//아이디, 비번이 일치하는 경우
		if(passwordEncoder.matches(member.getMe_pw(), dbMember.getMe_pw()))
			return dbMember;
		
		//아이디는 있지만 비번이 다른 경우
		return null;
	}

	@Override
	public Object idCheck(MemberVO member) {
		if(member == null || member.getMe_id() == null)
			return false;
		
		MemberVO user = memberDao.selectMember(member.getMe_id());
		if(user != null)
			return false;
		
		return true;
	}

	@Override
	public String getId(MemberVO member) {
		if(member == null)
			return null;
		return memberDao.selectId(member);
	}
	
	@Override
	public boolean sendEmail(String title, String content, String toEmail) {
	  try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	          = new MimeMessageHelper(message, true, "UTF-8");
	
	      messageHelper.setFrom("pageup64@naver.com");  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(toEmail);     // 받는사람 이메일
	      messageHelper.setSubject(title); // 메일제목은 생략이 가능하다
	      messageHelper.setText(content, true);  // 메일 내용
	
	      mailSender.send(message);
	  } catch(Exception e){
	     	return false;
	  }
	  return true;
	}
	
	@Override
	public boolean findPw(MemberVO member) {
		if(member == null || member.getMe_birth() == null || member.getMe_email() == null)
			return false;
		
		String id = memberDao.selectId(member);
		if(id == null)
			return false;
		MemberVO dbMember = memberDao.selectMember(id);
		
		String pwPattern = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		String newPw = "";
		int max = 8;
		for(int i = 0; i < max; i++){
			int index = (int)(Math.random() * (pwPattern.length()+1));
			newPw += pwPattern.charAt(index);
		}
		
		String encPw = passwordEncoder.encode(newPw);
		dbMember.setMe_pw(encPw);
		memberDao.updateMember(dbMember);
		
		String title = "임시 비밀번호입니다";
		String content = newPw + "<br>임시 비밀번호로 로그인해주세요";
		return sendEmail(title, content, member.getMe_email());
	}

	@Override
	public boolean updateMember(MemberVO member, MemberVO user) {
		if(member == null || user == null)
			return false;
		if(!member.getMe_id().equals(user.getMe_id()))
			return false;
		
		user.setMe_birth(member.getMe_birth());
		user.setMe_gender(member.getMe_gender());
		user.setMe_email(member.getMe_email());
		
		if(member.getMe_authority() != 0)
			user.setMe_authority(member.getMe_authority());
		
		if(member.getMe_pw() != null && member.getMe_pw().length() != 0) {
			String encPw = passwordEncoder.encode(member.getMe_pw());
			user.setMe_pw(encPw);
		}
		memberDao.updateMember(user);
		return true;
	}

	@Override
	public void updateMemberSession(String me_id, String session_id, Date session_limit) {
		if(me_id == null)
			return;
		memberDao.updateMemberSession(me_id,session_id,session_limit);
	}

	@Override
	public MemberVO autoLogin(String session_id) {
		if(session_id == null)
			return null;
		return memberDao.selectMemberBySession(session_id);
	}

	@Override
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		if(request == null || response == null)
			return;
		//세션에 있는 회원 정보 삭제
		HttpSession session = request.getSession();
		MemberVO user = (MemberVO)session.getAttribute("user");
		if(user == null)
			return;
		session.removeAttribute("user");
		//쿠키 정보 초기화
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		if(loginCookie == null)
			return;
		loginCookie.setPath("/");
		loginCookie.setMaxAge(0);
		response.addCookie(loginCookie);
		//회원세션 정보 수정
		memberDao.updateMemberSession(user.getMe_id(), null, null);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(MemberVO user) {
		if(user == null)
			return null;
		if(user.getMe_authority() < 8)
			return null;
		
		return memberDao.selectMemberList(user);
	}

	@Override
	public boolean updateAuthority(MemberVO member, MemberVO user) {
		if(member == null || user == null)
			return false;
		
		if(user.getMe_authority() < 8)
			return false;
		
		if(member.getMe_authority() >= user.getMe_authority())
			return false;
		
		MemberVO dbMember = memberDao.selectMember(member.getMe_id());
		if(dbMember == null || dbMember.getMe_authority() >= user.getMe_authority())
			return false;
		
		dbMember.setMe_authority(member.getMe_authority());
		memberDao.updateMember(dbMember);
		return true;
	}
}
