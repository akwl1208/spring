package kr.green.springtest.dao;

import java.util.ArrayList;
import java.util.Date;

import org.apache.ibatis.annotations.Param;

import kr.green.springtest.vo.MemberVO;

public interface MemberDAO {

	MemberVO selectMember(@Param("me_id")String me_id);

	void insertMember(@Param("member")MemberVO member);

	String selectId(@Param("member")MemberVO member);

	void updateMember(@Param("member")MemberVO dbMember);

	void updateMemberSession(@Param("me_id")String me_id, @Param("session_id")String session_id,
			@Param("session_limit")Date session_limit);

	MemberVO selectMemberBySession(@Param("session_id")String session_id);

	ArrayList<MemberVO> selectMemberList(@Param("user")MemberVO user);


}
