package kr.green.springtest.dao;

import org.apache.ibatis.annotations.Param;

import kr.green.springtest.vo.MemberVO;

public interface MemberDAO {

	String selectEmail(@Param("me_id")String me_id);

	MemberVO selectMember(@Param("me_id")String me_id);

	void insertMember(@Param("member")MemberVO member);
	

}
