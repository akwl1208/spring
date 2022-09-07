package kr.green.lg.service;

import kr.green.lg.vo.BoardVO;
import kr.green.lg.vo.MemberVO;

public interface BoardService {

	boolean insertBoard(BoardVO board, MemberVO user, String bd_type);

}
