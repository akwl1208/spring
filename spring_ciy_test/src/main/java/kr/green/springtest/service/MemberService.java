package kr.green.springtest.service;

import kr.green.springtest.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	MemberVO login(MemberVO member);

	Object idCheck(MemberVO member);

	String getId(MemberVO member);

	boolean findPw(MemberVO member);

	boolean sendEmail(String title, String content, String email);

	boolean updateMember(MemberVO member, MemberVO user);
}
