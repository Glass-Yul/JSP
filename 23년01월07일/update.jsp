<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content = "width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<!-- ********************************************************************** -->
<!-- 내가 따로 만든 css파일을 사용하기 위해 -->
<link rel="stylesheet" href="css/custom.css">
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
		// 로그인이 되어있지 않았으면
		if(userID == null){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('로그인을 하세요')"); // 알림창 띄움
			script.println("location.href = 'login.jsp'"); // 다시 게시판 화면으로 이동
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
		// 게시글 작성자를 판별하기 위해
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		// 넘어온 userID와 로그인한 회원의 userID가 같지 않으면
		if(!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('권한이 없습니다')"); // 알림창 띄움
			script.println("location.href = 'bbs.jsp'"); // 다시 게시판 화면으로 이동
			script.println("</script>"); 
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
		</div>
	</nav>
	<div class="container">
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">
				<table class="table table-striped"  style="text-align:center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<td colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글 수정 양식</td>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" 
										name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>" ></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" 
										name="bbsContent" maxlength="2048" style="height:350px;">"<%= bbs.getBbsContent() %>"</textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정">
			</form>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html> 