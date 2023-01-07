<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		// 로그인에 성공한 사람에겐 회원가입이 안 뜨도록 설정 -> 다시 로그인하는 것을 막음
		String userID = null;
		// userID라는 이름으로 세션이 부여된 사람들은 
		if(session.getAttribute("userID") != null){
			// 변수 userID에 해당 세션값을 대입해줌
			userID = (String) session.getAttribute("userID"); // 세션을 할당 받음
		}
		// 세션값이 없음 즉 로그인이 되어있지 않을 때
		if(userID == null){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('로그인을 진행하세요')"); // 알림창 띄움
			script.println("location.href = 'login.jsp'"); // 로그인이 되어있지않아 로그인 페이지로 이동시킴
			script.println("</script>"); 
		}
		
		int bbsID = 0;
		// 넘어온 값 존재하면
		if(request.getParameter("bbsID") != null){
			// get방식으로 url에 해당 bbsID가 출력되게 만듦
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		// bbsID가 존재하지 않으면
		if(bbsID == 0){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('유효하지 않은 글입니다')"); // 알림창 띄움
			script.println("location.href = 'bbs.jsp'"); // 다시 게시판 화면으로 이동
			script.println("</script>"); 
		}
		// 유효한 bbsID가 존재하면
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		// 넘어온 userID와 로그인한 회원의 userID가 같지 않으면
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('권한이 없습니다')"); // 알림창 띄움
			script.println("location.href = 'bbs.jsp'"); // 다시 게시판 화면으로 이동
			script.println("</script>"); 
		} else{ // 성공적으로 로그인이되어 권한이 있느면
			// 모든 항목이 채워져있으면
			BbsDAO bbsDAO = new BbsDAO(); //객체 생성

			int result = bbsDAO.delete(bbsID); 
			// 글쓰기가 실패했을 때
			if(result == -1){
				PrintWriter script = response.getWriter(); // 쓰기 객체 생성
				script.println("<script>"); // script문을 유동적으로 사용
				script.println("alert('게시글 글 삭제에 실패하였습니다')"); // 알림창 띄움
				script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
				script.println("</script>"); 
			} else { // 정상적으로 게시글 글삭제가 완료되었으면
				PrintWriter script = response.getWriter(); // 쓰기 객체 생성
				script.println("<script>"); // script문을 유동적으로 사용
				script.println("location.href = 'bbs.jsp'"); // 글쓰기가 완료되면 게시물 페이지로 이동
				script.println("</script>"); 
			}
		}
		
	%>
</body>
</html>   