package kr.green.lg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.lg.dao.BoardDAO;
import kr.green.lg.vo.BoardVO;
import kr.green.lg.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService {
	@Autowired
	BoardDAO boardDao;

	@Override
	public boolean insertBoard(BoardVO board, MemberVO user, String bd_type) {
		if(board == null ||
				board.getBd_title() == null || board.getBd_title().length() == 0 ||
				board.getBd_content() == null)
		return false;
		if(user == null)
			return false;
		board.setBd_me_email(user.getMe_email());
		board.setBd_type(bd_type);
		return boardDao.insertBoard(board) == 1 ? true : false;
	}
}
