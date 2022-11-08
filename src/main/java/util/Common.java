package util;

public class Common {
	
	//일반 게시판용 클래스
	public static class Board {
		
		//jsp경로
		public final static String VIEW_PATH = "/WEB-INF/views/board/";
		
		//한 페이지에 보여줄 게시물 갯수
		public final static int BLOCKLIST = 10;
		
		//페이지 메뉴 수
		//<- 1 2 3 ->
		public final static int BLOCKPAGE = 5;
	}
	
	//공지사항 게시판용
	public static class Notice {
		public final static int BLOCKLIST = 20;
		public final static int BLOCKPAGE = 5;
	}
}
