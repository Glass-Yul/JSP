<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %> <!-- 게시판 목록을 위해 -->
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
<style type="text/css">
	a, a:hover{
		color: #000000;
		text-decoration:none;
	}
</style>
</head>
<body>
	<%
		// 로그인이 되어있으면 로그인 정보를 저장해줌
		String userID = null;
		if(session.getAttribute("userID") != null){
			// 세션이 존재하면 해당 userID에 userID값을 부여함
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; // 디폴트로 첫 페이지라 알려줌
		// 만약 해당 페이지 값이 존재하면
		if(request.getParameter("pageNumber") != null) {
			// pageNumber라 선언한 변수에 해당 페이지 값을 대입
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<table class="table table-striped"  style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<td style="background-color:#eeeeee; text-align:center;">번호</td>
						<td style="background-color:#eeeeee; text-align:center;">제목</td>
						<td style="background-color:#eeeeee; text-align:center;">작성자</td>
						<td style="background-color:#eeeeee; text-align:center;">작성일</td>
				</thead>
				<tbody>
					<%
						BbsDAO bbsDAO = new BbsDAO();
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						for(int i=0; i<list.size(); i++) {
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<!-- 해당 게시글 제목을 클릭 시 작성한 게시글을 볼 수 있게 링크르 ㄹ걸어둠 -->
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13)
								+ "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1){ // 여러 페이지가 존재한다면
				
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}
			%>
			<%
				if(bbsDAO.nextPage(pageNumber + 1)){ // 다음 페이지가 존재한다면
				
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html> 