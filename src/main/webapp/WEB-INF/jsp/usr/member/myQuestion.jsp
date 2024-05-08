<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Question"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>

<title>문의사항</title>

<header class="header">
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
	<nav class="header_menu">
		<a href="../member/myInfo">
			<button class="username">${loggedInMemberName}님</button>
		</a> <a href="../conference/list">
			<button class="hd_info">학회 정보</button>
		</a> <a href="../competition/list">
			<button class="hd_contest">공모전</button>
		</a> <a href="../member/myQuestion">
			<button class="hd_question">문의사항</button>
		</a>
		<c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>

<div class="img"></div>

<div class="menu_box1 left">
	<div class="mypage">문의사항</div>
</div>
<div class="right">
	<a href="../member/myQuestion">
		<button class="menu_box2 myinfo">문의 목록</button>
	</a>
	<a href="../member/inquiry">
		<button class="menu_box2 myquestion">문의 작성</button>
	</a>
</div>


<section class="question_list">
	<div class="question_bar">
		<div class="bar_num">번호</div>
		<div class="bar_title">제목</div>
		<div class="bar_date">날짜</div>
	</div>
	
	<div class="question_box">
		<c:forEach var="inquiry" items="${inquiries}">
	<div class="question_content">
			<div class="bar_num">${inquiry.id}</div>
			<div class="bar_title">${inquiry.title}</div>
			<div class="bar_date">${inquiry.regDate}</div>
		</div>
		</c:forEach>
	</div>
</section>


<style>
body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}

.header {
	display: flex;
	position: absolute;
	justify-content: space-between;
	align-items: center;
	width: 100%;
	margin: 17px auto 0;
	padding: 0 20px;
	gap: 20px;
}

.logo {
	text-align: center;
}

.header_menu {
	display: flex;
	gap: 20px;
}

.header_menu button:hover {
	border-bottom: 1px solid;
}

.hd_logout {
	margin-top: 3.5px;
	font-size: 12.5px;
}

.hd_logout:hover {
	border-bottom: 1px solid;
}

.username {
	flex-grow: 1;
}

.img {
	position: absolute;
	width: 100%;
	height: 150px;
	left: 0;
	top: 57px;
	background:
		url('https://velog.velcdn.com/images/vrslxowe/post/ba2f5fd8-3c2c-4a9a-baa4-2d31c48be056/image.jpg')
		no-repeat;
	background-size: cover;
}

.menu_box1, .menu_box2 {
	border-radius: 18px;
	background: #00256c;
	color: white;
	text-align: center;
	display: inline-block;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.menu_box1 {
	width: 130px;
	height: 80px;
	font-size: 17px;
	line-height: 82px;
}

.menu_box2 {
	width: 110px;
	height: 70px;
	font-size: 16px;
	margin-right: 100px;
	line-height: 72px;
}

.menu_box2:last-child {
	margin-right: 0;
	/* 마지막 요소의 오른쪽 마진 제거 */
}

.left {
	position: absolute;
	left: 112.5px;
	top: 155px;
}

.right {
	display: flex;
	gap: 50px;
	position: absolute;
	right: 112.5px;
	top: 165px;
}

.question_list {
	position: relative;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 1000px;
	height: 600px;
	top: 260px;
	text-align: center;
	margin: auto;
}

.question_bar {
	position: absolute;
	display: flex;
	width: 1000px;
	top: 0;
	height: 30px;
	font-size: 14px;
	color: white;
	align-items: center;
	border-radius: 5px;
	background-color: #7E9DD9;
}

.bar_num {
	margin-left: 50px;
	width: 200px;
}

.bar_title {
	margin-left: 360px;
	width: 500px;
}

.bar_date {
	margin-left: 330px;
	width: 900px;
}

.question_content {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	top: -30px;
	width: 1000px;
	height: 80px;
	background-color: #fff;
	border-bottom: 1px solid;
}

.question_content:hover {
	background-color: #B6CCF4;
	color: white;
}

</style>

<%@ include file="../common/foot.jspf"%>