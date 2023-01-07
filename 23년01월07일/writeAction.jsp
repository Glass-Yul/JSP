<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현재 페이지에서만 사용할 수 있게 함 -->
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page"/>
<!-- 넘어온 데이터를 기반으로 진행 -->
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>
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
		else{
			// 사용자가 게시글에 어떠한 데이터도 입력하지 않았을 때
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter(); // 쓰기 객체 생성
				script.println("<script>"); // script문을 유동적으로 사용
				script.println("alert('입력이 안 된 사항이 있습니다')"); // 알림창 띄움
				script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
				script.println("</script>"); 
			}
			// 모든 항목이 채워져있으면
			else{
				BbsDAO bbsDAO = new BbsDAO(); //객체 생성
				// 각각의 return값이 저장될 곳
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 
				// 글쓰기가 실패했을 때
				if(result == -1){
					PrintWriter script = response.getWriter(); // 쓰기 객체 생성
					script.println("<script>"); // script문을 유동적으로 사용
					script.println("alert('게시글 글쓰기에 실패하였습니다')"); // 알림창 띄움
					script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
					script.println("</script>"); 
				}
				// 정상적으로 게시글 글쓰기가 완료되었으면
				else {
					PrintWriter script = response.getWriter(); // 쓰기 객체 생성
					script.println("<script>"); // script문을 유동적으로 사용
					script.println("location.href = 'bbs.jsp'"); // 글쓰기가 완료되면 게시물 페이지로 이동
					script.println("</script>"); 
				}
			}	
		}
		
	%>
</body>
</html>   