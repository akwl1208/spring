package kr.green.springtest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.springtest.dao.MemberDAO;

@Service
public class MemberServiceImp implements MemberService{

	@Autowired
	MemberDAO memberDao;

	@Override
	public String getEmail(String me_id) {
		return memberDao.selectEmail(me_id);
	}
	

	
}
