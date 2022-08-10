package kr.green.springtest.service;

import java.util.ArrayList;

import kr.green.springtest.vo.BoardVO;
import kr.green.springtest.vo.MemberVO;

public interface BoardService {

	ArrayList<BoardVO> getBoardList();

	BoardVO getBoard(int bd_num);

	void updateView(int bd_num);

	void insertBoard(BoardVO board, MemberVO user);

	void updateBoard(BoardVO board, MemberVO user);

}
