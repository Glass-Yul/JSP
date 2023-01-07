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
		// 로그인에 성공한 사람에겐 회원가입이 안 뜨도록 설정 -> 다시 로그인하는 것을 막음
		String userID = null;
		// userID라는 이름으로 세션이 부여된 사람들은 
		if(session.getAttribute("userID") != null){
			// 변수 userID에 해당 세션값을 대입해줌
			userID = (String) session.getAttribute("userID"); // 세션을 할당 받음
		}
		if(userID != null){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('이미 로그인이 되어있습니다')"); // 알림창 띄움
			script.println("location.href = 'main.jsp'"); // 로그인이 되어있으면 main페이지로 돌려보냄
			script.println("</script>"); 
		}
		UserDAO userDAO = new UserDAO(); //팩체 생성
		// 각각의 return값이 저장될 곳
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		// 로그인이 성공일 때
		if(result == 1){
			// 로그인에 성공한 사람에게 세션을 부여해줌
			session.setAttribute("userID", user.getUserID());
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