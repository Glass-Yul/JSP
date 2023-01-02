<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!-- 현재 페이지에서만 사용할 수 있게 함 -->
<jsp:useBean id="user" class="user.User" scope="page"/>
<!-- 넘어온 데이터를 기반으로 진행 -->
<jsp:setProperty name="user" property="userID"/>
<jsp:setProperty name="user" property="userPassword"/>
<jsp:setProperty name="user" property="userName"/>
<jsp:setProperty name="user" property="userGender"/>
<jsp:setProperty name="user" property="userEmail"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		// 하나의 항목이라도 비어있으면
		if(user.getUserID()==null || user.getUserPassword()==null || 
			user.getUserName()==null || user.getUserGender()==null || user.getUserEmail()==null){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('입력이 안 된 사항이 있습니다')"); // 알림창 띄움
			script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
			script.println("</script>"); 
		} else{
			UserDAO userDAO = new UserDAO(); //객체 생성
			// 각각의 return값이 저장될 곳
			int result = userDAO.join(user); // 회원가입이므로 모든 데이터를 보냄
			// 해당 아이디가 이미 존재할 때
			if(result == -1){
				PrintWriter script = response.getWriter(); // 쓰기 객체 생성
				script.println("<script>"); // script문을 유동적으로 사용
				script.println("alert('이미 존재하는 아이디입니다')"); // 알림창 띄움
				script.println("history.back()"); // 이전 페이지로 돌려보냄 -> 즉 로그인 페이지로 돌려보냄
				script.println("</script>"); 
			}
			// 그게 아니면
			else {
				PrintWriter script = response.getWriter(); // 쓰기 객체 생성
				script.println("<script>"); // script문을 유동적으로 사용
				script.println("location.href = 'main.jsp'"); // 해당 페이지로 이동 -> 회원가입 완료됨
				script.println("</script>"); 
			}
		}
		
	%>
</body>
</html>   