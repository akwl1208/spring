package kr.green.springtest.dao;

import org.apache.ibatis.annotations.Param;

public interface MemberDAO {

	String selectEmail(@Param("me_id")String me_id);
	

}
