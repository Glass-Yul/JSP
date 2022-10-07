<!-- 기본 세팅 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
/*
res.setCharacterEncoding("UTF-8");
res.setContentType("text/html; charset=UTF-8");
PrintWriter out = res.getWriter(); 
*/ 
// => 내장 객체가 이미 존재해 주석처리함

String temp = request.getParameter("cnt");
int cnt = 5;
if(temp!=null && !temp.equals("")) // 값이 있는지 확인
	cnt = Integer.parseInt(temp);
// 요청/응답은 무조건 문자열 => Integer로 형변환
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%for(int i=0;i<cnt;i++) {%>
		안녕 Servlet!!<br>
	<%} %>
	
	
</body>
</html>