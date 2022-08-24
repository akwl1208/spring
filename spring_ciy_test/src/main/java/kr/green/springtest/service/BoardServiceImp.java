package kr.green.springtest.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.green.springtest.dao.BoardDAO;
import kr.green.springtest.pagination.Criteria;
import kr.green.springtest.vo.BoardVO;
import kr.green.springtest.vo.CommentVO;
import kr.green.springtest.vo.LikesVO;
import kr.green.springtest.vo.MemberVO;

@Service
public class BoardServiceImp implements BoardService{

	@Autowired
	BoardDAO boardDao;

	@Override
	public ArrayList<BoardVO> getBoardList(Criteria cri) {
		if(cri == null)
			return null;
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
	public int getTotalCount(Criteria cri) {
		if(cri == null)
			return 0;
		return boardDao.selectTotalCount(cri);
	}

	@Override
	public String getLikesState(LikesVO likes, MemberVO user) {
		if(likes == null || user == null)
			return "0";
		likes.setLi_me_id(user.getMe_id());
		
		LikesVO dbLikes = boardDao.selectLikes(likes);
		try {
			if(dbLikes == null) {
				boardDao.insertLikes(likes);
				return ""+likes.getLi_state();
			}
			String res;
			if(likes.getLi_state() == dbLikes.getLi_state()) {
				dbLikes.setLi_state(0);
				res = likes.getLi_state() + "0";
			}else {
				dbLikes.setLi_state(likes.getLi_state());
				res = likes.getLi_state() + "";
			}
			boardDao.updateLikes(dbLikes);
			return res;
		} catch (Exception e) {
		} finally {
			boardDao.updateBoardLikes(likes.getLi_bd_num());
		}
		return "0";
	}

	@Override
	public LikesVO getLikes(int bd_num, MemberVO user) {
		if(user == null)
			return null;
		
		LikesVO likes = new LikesVO();
		likes.setLi_bd_num(bd_num);
		likes.setLi_me_id(user.getMe_id());
		return boardDao.selectLikes(likes);
	}

	@Override
	public boolean insertComment(CommentVO comment, MemberVO user) {
		if(comment == null || user == null || user.getMe_id() == null)
			return false;
		comment.setCo_me_id(user.getMe_id());
		boardDao.insertComment(comment);
		return true;
	}

	@Override
	public ArrayList<CommentVO> getCommentList(Criteria cri, int bd_num) {
		if(cri == null)
			return null;
		
		BoardVO dbBoard = boardDao.selectBoard(bd_num);
		if(dbBoard == null || !dbBoard.getBd_del().equals("N"))
			return null;
		
		return boardDao.selectCommentList(cri, bd_num);
	}

	@Override
	public int getCommentTotalCount(int bd_num) {
		BoardVO dbBoard = boardDao.selectBoard(bd_num);
		if(dbBoard == null || !dbBoard.getBd_del().equals("N"))
			return 0;
		return boardDao.selectTotalComment(bd_num);
	}

	@Override
	public boolean deleteComment(CommentVO comment, MemberVO user) {
		if(comment == null || user == null)
			return false;
		
		CommentVO dbComment = boardDao.selectComment(comment.getCo_num());
		if(dbComment == null || !dbComment.getCo_me_id().equals(user.getMe_id()))
			return false;
		
		boardDao.deleteComment(comment.getCo_num());
		return true;
	}

	@Override
	public boolean updateComment(CommentVO comment, MemberVO user) {
		if(comment == null || user == null)
			return false;
		
		CommentVO dbComment = boardDao.selectComment(comment.getCo_num());
		if(dbComment == null || !dbComment.getCo_me_id().equals(user.getMe_id()))
			return false;
		
		boardDao.updateComment(comment);
		return true;
	}

}
