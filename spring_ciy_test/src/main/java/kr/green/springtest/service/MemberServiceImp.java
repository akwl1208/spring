package kr.green.springtest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.springtest.dao.MemberDAO;
import kr.green.springtest.vo.MemberVO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;

	@Override
	public String getEmail(String me_id) {
		return memberDao.selectEmail(me_id);
	}

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
		
		memberDao.insertMember(member);
		return true;
	}
	

	
}
