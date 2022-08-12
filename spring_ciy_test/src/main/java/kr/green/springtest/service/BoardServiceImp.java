package kr.green.springtest.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.springtest.dao.BoardDAO;
import kr.green.springtest.pagination.Criteria;
import kr.green.springtest.vo.BoardVO;
import kr.green.springtest.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService{

	@Autowired
	BoardDAO boardDao;

	@Override
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		return boardDao.selectBoardList(cri);
	}

	@Override
	public BoardVO getBoard(int bd_num) {
		return boardDao.selectBoard(bd_num);
	}

	@Override
	public void updateView(int bd_num) {
		boardDao.updateViews(bd_num); 
	}

	@Override
	public void insertBoard(BoardVO board, MemberVO user) {
		if(board == null || board.getBd_title() == null || board.getBd_content() == null)
			return;
		if(board.getBd_title().trim().length() == 0)
			return;
		if(board.getBd_content().trim().length() == 0)
			return;
		if(user == null || user.getMe_id() == null)
			return;
		
		board.setBd_me_id(user.getMe_id());
		boardDao.insertBoard(board);
	}

	@Override
	public void updateBoard(BoardVO board, MemberVO user) {
		if(user == null || board == null)
			return;
		if(board.getBd_title().trim().length() == 0)
			return;
		if(board.getBd_content().trim().length() == 0)
			return;
		
		BoardVO dbBoard = boardDao.selectBoard(board.getBd_num());
		if(dbBoard == null || !dbBoard.getBd_del().equals("N"))
			return;
		if(!user.getMe_id().equals(dbBoard.getBd_me_id()))
			return;
		
		boardDao.updateBoard(board);
	}

	@Override
	public void deleteBoard(int bd_num, MemberVO user) {
		if(user == null)
			return;
		
		BoardVO board = boardDao.selectBoard(bd_num);
		if(board == null || !board.getBd_del().equals("N"))
			return;
		if(!board.getBd_me_id().equals(user.getMe_id()))
			return;
		board.setBd_del("Y");
		boardDao.updateBoard(board);
	}

	@Override
	public int getTotalCount() {
		return boardDao.selectTotalCount();
	}


}
