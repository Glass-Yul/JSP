<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현재 페이지에서만 사용할 수 있게 함 -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<!-- 넘어온 아이디와 패스워드를 기반으로 진행 -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		UserDAO userDAO = new UserDAO(); //팩체 생성
		// 각각의 return값이 저장될 곳
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		// 로그인이 성공일 때
		if(result == 1){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("location.href = 'main.jsp'"); // 해당 페이지로 이동
			script.println("</script>"); 
		}
		// 비밀번호가 불일치일 때
		else if(result == 0){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('비밀번호가 틀립니다')"); // 알림창 띄움
			script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
			script.println("</script>"); 
		}
		// 아이디가 없을 때
		else if(result == -1){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('존재하지 않는 아이디입니다')"); // 알림창 띄움
			script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
			script.println("</script>"); 
		}
		// DB 오류일 때
		else if(result == -2){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('DB 오류가 발생했습니다')"); // 알림창 띄움
			script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
			script.println("</script>"); 
		}
	%>
</body>
</html>   