package com.korea.bbs;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.BoardDAO;
import util.Common;
import util.Paging;
import vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	HttpServletRequest request;

	BoardDAO board_dao;

	// setter injection
	public void setBoard_dao(BoardDAO board_dao) {
		this.board_dao = board_dao;
	}

	@RequestMapping(value = { "/", "board_list.do" })
	public String list(Model model, String page) {

		int nowPage = 1;

		// board_list.do <-- null
		// board_list.do?page= <-- empty

		// nullcheck
		if (page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		} 

		// 한 페이지에 표시될 게시물의 시작과 끝번호를 계산
		// page가 1이면 1 ~ 10까지 계산이 되어야하고
		// page가 2이면 11 ~ 20까지 계산이 되어야한다.
		int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		HashMap<String, Integer> map = new HashMap<String, Integer>();

		map.put("start", start);
		map.put("end", end);

		// 페이지 번호에 따른 게시글 조회
		List<BoardVO> list = board_dao.selectList(map);

		// 전체 게시물 수 구하기
		int rowTotal = board_dao.getRowTotal();

		// 페이지 메뉴 생성하기
		String pageMenu = Paging.getPaging("board_list.do", nowPage, // 현재 페이지 번호
				rowTotal, // 전체 게시물 수
				Common.Board.BLOCKLIST, // 한 페이지에 표기할 게시물 수
				Common.Board.BLOCKPAGE // 페이지 메뉴의 수
		);

		// 조회수를 위해 저장해뒀던 show라는 정보를 세션에서 제거시켜야 함.
		request.getSession().removeAttribute("show");

		// request영역에 바인딩.
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		return Common.Board.VIEW_PATH + "board_list.jsp?page="+nowPage;

	}

	// 게시글 상세보기
	@RequestMapping("/view.do")
	public String view(Model model, int idx, int page) {

		// view.do?idx=5&page=1
		// idx에 해당하는 게시글 한건 상세보기
		BoardVO vo = board_dao.selectOne(idx);

		// 조회수 증가
		HttpSession session = request.getSession();
		String show = (String) session.getAttribute("show");

		if (show == null) {
			int res = board_dao.update_readhit(idx);
			session.setAttribute("show", "0");
		}

		// 상세보기페이지로 전환하기 위해 바인딩 및 포워딩
		model.addAttribute("vo", vo);

		return Common.Board.VIEW_PATH + "board_view.jsp";
	}

	// 게시글 등록하는 페이지 이동
	@RequestMapping("/insert_form.do")
	public String insert_form() {
		return Common.Board.VIEW_PATH + "insert_form.jsp";
	}

	// 게시글 등록
	@RequestMapping("/insert.do")
	public String insert(BoardVO vo) {

		String ip = request.getRemoteAddr(); // ip

		vo.setIp(ip);

		int res = board_dao.insert(vo);

		if (res > 0) {
			// 등록이 완료가 되었다면, 전체목록을 보여주는 게시판의 첫 페이지로 복귀한다.
//			response.sendRedirect("board_list.do");
			return "redirect:board_list.do";
		}

		return null;

	}

	// 게시글 삭제
	@RequestMapping("/del.do")
	@ResponseBody
	public String delete( int idx ) {

		
		// 삭제하고자 하는 원본게시물의 정보를 얻어온다.
		BoardVO baseVO = board_dao.selectOne(idx);

		baseVO.setSubject("이미 삭제된 글입니다.");
		baseVO.setName("unknown");

		int res = board_dao.del_update(baseVO);
		
		if (res == 1) {
			return "[{'result':'yes'}]";
		} else {
			return "[{'result':'no'}]";
		}

	}
	
	//답글 작성을 위한 페이지로 이동
	@RequestMapping("/replyForm.do") 
	public String reply_form( int idx, int page ) {
		return Common.Board.VIEW_PATH + "replyForm.jsp?idx="+idx+"&page="+page;
	}
	
	//답글달기
	@RequestMapping("/reply.do")
	public String reply( int idx, int page, BoardVO vo ) {
		
		String ip = request.getRemoteAddr();
				
		//기준글의 idx를 사용해서 댓글을 달고싶은 게시글 정보를 먼저 얻어온다.
		BoardVO base_vo = board_dao.selectOne(idx);
		
		//기준글의 step이상인 값은 step = step + 1 처리
		int res = board_dao.update_step(base_vo);
		
		//댓글VO
		vo.setIp(ip);
		
		//원본에 ref, step, depth값을 댓글 vo에 세팅해서 값을 가져온다.
		//댓글이 들어갈 위치 선정
		vo.setRef( base_vo.getRef() );
		vo.setStep( base_vo.getStep() + 1 );
		vo.setDepth( base_vo.getDepth() + 1 );
		
		//댓글 등록
		res = board_dao.reply(vo);
		
		if ( res > 0 ) {
			return "redirect:board_list.do?page="+page;
		}
		return null;
	}
	
}
