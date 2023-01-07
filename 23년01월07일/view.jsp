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
		int bbsID = 0;
		// 넘어온 값 존재하면
		if(request.getParameter("bbsID") != null){
			// get방식으로 url에 해당 bbsID가 출력되게 만듦
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		// bbsID가 존재한다면
		if(bbsID == 0){
			PrintWriter script = response.getWriter(); // 쓰기 객체 생성
			script.println("<script>"); // script문을 유동적으로 사용
			script.println("alert('유효하지 않은 글입니다')"); // 알림창 띄움
			script.println("location.href = 'bbs.jsp'"); // 다시 게시판 화면으로 이동
			script.println("</script>"); 
		}
		// 유효한 bbsID가 존재하면
		Bbs bbs = new BbsDAO().getBbs(bbsID);
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
						<td colspan="3" style="background-color:#eeeeee; text-align:center;">게시판 글 보기</td>
				</thead>
				<tbody>
					<tr>
						<td style="width:20%;">글 제목</td>
						<td colspan="2">
							<!-- <script> 공격을 막기위해 Title에도 적용시킨다 -->
							<%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
									.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13)
								+ "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height:200px; text-align:left;">
							<%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<%
				// 로그인된 글의 작성자가 해당 게시글을 들어왔을 경우 수정이 가능하게 함 
				if(userID != null && userID.equals(bbs.getUserID())){
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" 
					href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
		</div>
	</div>
	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html> 