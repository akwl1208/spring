package kr.green.springtest.service;

import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.green.springtest.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	MemberVO login(MemberVO member);

	Object idCheck(MemberVO member);

	String getId(MemberVO member);

	boolean findPw(MemberVO member);

	boolean sendEmail(String title, String content, String email);

	boolean updateMember(MemberVO member, MemberVO user);

	void updateMemberSession(String me_id, String me_session_id, Date me_session_date);

	MemberVO autoLogin(String sessionId);

	void logout(HttpServletRequest request, HttpServletResponse response);

	ArrayList<MemberVO> getMemberList(MemberVO user);

	boolean updateAuthority(MemberVO member, MemberVO user);
}
