<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		// 로그인이 되어있으면 로그인 정보를 저장해줌
		String userID = null;
		if(session.getAttribute("userID") != null){
			// 세션이 존재하면 해당 userID에 userID값을 부여함
			userID = (String) session.getAttribute("userID");
		}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expended="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
		</div>
		 <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1"
       				aria-expanded="false">
         	<ul class="nav navbar-nav">
                <li><a href="main.jsp">메인</a></li>
                <!-- ***************************************************************** -->
           		<!-- 현재 접속한 페이지가 게시판 페이지인 것을 알려줌 -->
                <li class="active"><a href="bbs.jsp">게시판</a></li>
            </ul>
            <%
            	// 로그인이 되어있지 않으면
           		if(userID == null) {
            %>
            <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
                     data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">접속하기<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                     	<li><a href="login.jsp">로그인</a></li>
                     	<li><a href="join.jsp">회원가입</a></li>
                     </ul>
				</li>
			</ul>
            <%
           		} else { // 로그인이 되어있으면
            %>
            <ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
                     data-toggle="dropdown" role="button" aria-haspopup="true"
                     aria-expanded="false">회원관리<span class="caret"></span></a>
                     <ul class="dropdown-menu">
                     	<!-- ***************************************************************** -->
           				<!-- logoutAaction 페이지로 이동하여 로그아웃을 진행 -->	
                     	<li><a href="logoutAction.jsp">로그아웃</a></li>
                     </ul>
				</li>
			</ul>
            <%
           		}
            %>
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped"  style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<td colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글쓰기 양식</td>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 쓰기" 
										name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" 
										name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
			</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html> 