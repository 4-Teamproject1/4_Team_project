<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Question Detail"></c:set>
<%@ include file="../common/toastUiEditorLib.jspf"%>
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
		<c:if test="${rq.isLogined() }">
			<a href="../member/myInfo">
				<button class="username">${loggedInMemberName}님</button>
			</a>
		</c:if>
		<a href="../conference/list">
			<button class="hd_info">학회 정보</button>
		</a>
		<a href="../competition/list">
			<button class="hd_contest">공모전</button>
		</a>
		<a href="../hotel/recommendlist">
			<button class="hd_recommend">숙박&교통</button>
		</a>
		<c:if test="${!rq.isLogined() }">
			<li>
				<a class="hover:underline" href="${rq.loginUri }">로그인</a>
			</li>
		</c:if>
		<c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>

<div class="img"></div>
<div class="menu_box1 left">
	<a href="../member/myQuestion">
		<div class="mypage">문의사항</div>
	</a>
</div>

<div class="Ques_date">작성일자&nbsp${inquiry.regDate}</div>
<div class="Question_box title">
	<div class="Ques_title">문의 제목</div>
	<div class="Ques1">${inquiry.title}</div>
</div>
<div class="Question_box content">
	<div class="Ques_content">문의 내용</div>
	<div class="Ques2">${inquiry.body}</div>
</div>
<button class="back_btn" type="button" onclick="history.back();">뒤로가기</button>

<style>
body {
	width: 100%;
	hight: 130%;
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
	left: 0px;
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

.Ques_date {
	position: relative;
	top: 250px;
	left: 67%;
	width: 193px;
	height: 20px;
	font-size: 14px;
}

.Question_box {
	position: relative;
	top: 250px;
	left: 25%;
	height: 87px;
	width: 1000px;
	border-bottom-width: 1px;
	border-color: #878787;
}

.Ques_title, .Ques_content {
	position: relative;
	width: 160px;
	height: 87px;
	background: #7E9DD9;
	color: white;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	border-bottom-width: 1px;
	border-color: #878787;
}

.Ques_content {
	height: 450px;
}

.Ques1, .Ques2 {
	position: relative;
	left: 19%;
	width: 780px;
	height: 100%;
	color: black;
}

.Ques1 {
	top: -87px;
	display: flex;
	align-items: center;
}

.Ques2 {
	top: -100.2%;
	padding: 20px 0 0 0;;
}

.title {
	height: 89px;
	border-top-width: 2px;
	border-top-color: #535353;
}

.content {
	height: 450px;
}

.back_btn {
	width: 110px;
	height: 60px;
	font-size: 16px;
	position: fixed;
	left: 50%;
	transform: translateX(-50%);
	bottom: 3%;
	border-radius: 18px;
	background: #00256c;
	text-align: center;
	color: white;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
}
</style>

<%@ include file="../common/foot.jspf"%>