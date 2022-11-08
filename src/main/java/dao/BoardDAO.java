package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import vo.BoardVO;

public class BoardDAO {

	SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 페이지별 게시글 조회
	public List<BoardVO> selectList(HashMap<String, Integer> map) {
		List<BoardVO> list = sqlSession.selectList("b.board_list", map);
		return list;
	}

	// 게시글 추가
	public int insert(BoardVO vo) {
		int res = sqlSession.insert("b.board_insert", vo);

		// sqlSession.commit();

		return res;
	}

	// 게시글 한 건 조회
	public BoardVO selectOne(int idx) {
		BoardVO vo = sqlSession.selectOne("b.board_one", idx);
		return vo;
	}

	// 조회수 증가
	public int update_readhit(int idx) {
		int res = sqlSession.update("b.board_update_readhit", idx);
		return idx;
	}

	// 댓글추가를 위한 step + 1
	public int update_step(BoardVO vo) {
		int res = sqlSession.update("b.board_update_step", vo);
		return res;
	}

	// 댓글 추가
	public int reply(BoardVO vo) {
		int res = sqlSession.insert("b.board_reply", vo);
		return res;
	}

	// 게시글 삭제(된 것 처럼 업데이트)
	public int del_update(BoardVO vo) {
		int res = sqlSession.update("b.del_update", vo);
		return res;
	}

	// 전체 게시물 수 조회
	public int getRowTotal() {
		int count = sqlSession.selectOne("b.board_count");
		return count;

	}
}
