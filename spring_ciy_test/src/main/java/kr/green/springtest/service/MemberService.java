package kr.green.springtest.service;

import kr.green.springtest.vo.MemberVO;

public interface MemberService {

	String getEmail(String me_id);

	boolean signup(MemberVO member);

	MemberVO login(MemberVO member);

	
}
