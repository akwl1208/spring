package kr.green.springtest.service;

import kr.green.springtest.vo.MemberVO;

public interface MemberService {

	boolean signup(MemberVO member);

	MemberVO login(MemberVO member);

	Object idCheck(MemberVO member);

	String getId(MemberVO member);

	
}
