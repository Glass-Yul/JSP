<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
           		<!-- ***************************************************************** -->
           		<!-- 현재 접속한 페이지가 메인 페이지인 것을 알려줌 -->
                <li class="active"><a href="main.jsp">메인</a></li>
                <li><a href="bbs.jsp">게시판</a></li>
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
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>
					2. 상황을 가장 잘 활용하는 사람이 가장 좋은 상황을 맞는다. – 존 우든<br>
					3. 창조적인 삶을 살려면 내가 틀릴지도 모른다는 공포를 버려야 한다. – 미상<br>
					5. 신뢰의 이유는 안전하거나 확실해서가 아니라, 위험을 감수할 용의가 있어서이다. – 미상<br>
					8. 기다리는 사람에게 좋은 일이 생기지만, 찾아나서는 사람에게는 더 좋은 일이 생긴다. – 미상<br>
					9. 늘 하던 대로 하면 늘 얻던 것을 얻는다. – 미상<br>
					10. 열정을 잃지 않고 실패에서 실패로 걸어가는 것이 성공이다. – 윈스턴 처칠<br>
					12. 성공한 사업가들은 긍정적인 에너지를 주는 사람들이지 가져가는 사람들이 아니다. – 미상<br>
					13. 성공한 사람을 볼 때 당신은 대중에게 드러난 영예만 보지, 절대 그 영예를 얻기 위해 했던 개인적 희생은 보지 않는다. – 바입하브 샤<br>
					14. 기회는 일어나는 것이 아니라 만들어내는 것이다. – 크리스 그로서<br>
					16. 위대한 정신을 가진 사람들은 생각을 논한다. 평범한 사람들은 사건을 논한다. 마음이 좁은 사람들은 사람들을 논한다. – 엘리너 루즈벨트<br>
					18. 당신이 자신의 시간을 가치있게 생각하지 않으면 남들도 마찬가지일 것이다. 시간과 재능을 막 나눠주지 말고 팔아라. – 킴 가스트<br>
					19. 남들이 당신에게 던진 벽돌들로 탄탄한 기반을 쌓을 수 있어야 성공한다. – 데이비드 브링클리<br>
					20. 당신이 허락해주지 않으면 아무도 당신이 열등감을 느끼게 만들 수 없다. – 엘리너 루즈벨트<br>
					22. 지옥을 겪고 있다면 계속 겪어 나가라. – 윈스턴 처칠<br>
					23. 자기가 세상을 바꿀 수 있다고 생각할 정도로 미친 사람들이 세상을 바꾼다. – 미상<br>
					24. 언성을 높이지 말고 논거를 강화하라. – 미상<br>
					25. 괴로운 시련처럼 보이는 것이 뜻밖의 좋은 일일 때가 많다. – 오스카 와일드<br>
					26. 삶의 의미는 자신의 재능을 발견하는 것이다. 삶의 목적은 그것을 나눠주는 것이다. – 미상<br>
					28. 잘못된 것들을 쫓아다니는 것을 그만두면 옳은 일들이 당신을 따라잡을 기회가 생긴다. –롤리다스칼<br>
					29. 위대한 것으로 향하기 위해 좋은 것을 포기하는 걸 두려워하지 마라. - 존 록펠러<br>
					32. 간단하게 설명할 수 없으면 제대로 이해하지 못하는 것이다. – 알버트 아인슈타인<br>
				</p>
				<!-- 보통 jumbotron를 사용하면 a태그로 버튼을 만들어줌 -->
				<!-- href="#"은 아무 링크도 달지않은 것임 -->
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	<!-- carousel은 사진첩같은 거라고 생각하며 ㄴ됨 -->
	<div class="container">
		<!-- class="carousel slide"에서 slide라 작성해주어 양옆으로 이동 가능하게 함 -->
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
			<ol class="carousel-indicators">
				<!-- data-slide-to는 이름(인덱스)을 주는 것임 -->
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner">
				<!-- class="item active"를 주므로써 현재 선택된 사진을 보여줌 -->
				<div class="item active">
					<img src="images/1.png">
				</div>
				<div class="item">
					<img src="images/2.png">
				</div>
				<div class="item">
					<img src="images/3.jpg">
				</div>
			</div>
			<!-- 사진을 왼/오른쪽으로 이동할 수 있게 버튼을 만들어줌 -->
			<a class="left carousel-control" href="#myCarousel" data-slide="prev">
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next">
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>

</body>
</html> 