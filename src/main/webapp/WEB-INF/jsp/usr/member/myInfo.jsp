<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Info"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<header class="header">
  <a href="../home/main">
    <button class="logo">로고</button>
  </a>
  <nav class="header_menu">
    <a href="../member/myInfo">
      <button class="username">abc123님</button>
    </a>
    <a href="../conference/list">
      <button class="hd_info">학회 정보</button>
    </a>
    <a href="../competition/list">
      <button class="hd_contest">공모전</button>
    </a>
    <a href="../member/myQuestion">
      <button class="hd_question">문의사항</button>
    </a>
    <button class="hd_logout">로그아웃</button>
  </nav>
</header>

<div class="img"></div>
<div class="menu_box1 left">
	<div class="mypage">마이 페이지</div>
</div>
<div class="right">
	<a href="../member/mySchedule">
		<button class="menu_box2 myschedule">내 일정</button>
	</a>
	<a href="../member/myInfo">
		<button class="menu_box2 myinfo">내 정보</button>
	</a>
	<a href="../member/myQuestion">
		<button class="menu_box2 myquestion">내 문의</button>
	</a>
</div>

<div class="info_box info_name">
	<div class="info1">이름</div>
	<div class="info2">길동이</div>
</div>

<div class="info_box info_id">
	<div class="info1">아이디</div>
	<div class="info2">abc123</div>
</div>

<div class="info_box info_pw">
	<div class="info1">비밀번호</div>
	<button class="info2 pw_btn">변경하기</button>
</div>

<div class="info_box info_pn">
	<div class="info1">핸드폰 번호</div>
	<div class="info2">010-1111-1111</div>
</div>

<div class="info_box info_email">
	<div class="info1">이메일</div>
	<div class="info2">abc123@gmail.com</div>
</div>

<button class="modify_btn">수정하기</button>

<style>
body {
	width: 100%;
	hight: 130%;
	margin: 0;
	padding: 0;
}

.header {
	display: flex;
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

.hd_logout {
	font-size: 12.5px;
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

.right {
	display: flex;
	gap: 100px;
	position: absolute;
	right: 112.5px;
	top: 165px;
}

.modify_btn {
	width: 110px;
	height: 70px;
	font-size: 16px;
	line-height: 72px;
	position: fixed;
	left: 50%;
	transform: translateX(-50%);
	bottom: 7%;
	border-radius: 18px;
	background: #00256c;
	color: white;
	text-align: center;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.info_box {
	top: 260px;
	left: 25%;
	height: 87px;
	width: 1000px;
	position: relative;
	border-bottom-width: 1px;
	border-color: #878787;
}

.info1 {
	width: 160px;
	height: 87px;
	background: #7E9DD9;
	color: white;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	border-bottom-width: 1px;
	border-color: #878787;
}

.info2 {
	top: -55px;
	left: 19%;
	width: 200px;
	position: relative;
}

.info_name {
	height: 89px;
	border-top-width: 2px;
	border-top-color: #535353;
}

.pw_btn {
	top: -65px;
	width: 95px;
	height: 38px;
	font-size: 14px;
	border-radius: 10px;
	background: #7E9DD9;
	color: white;
	box-shadow: 4px 3px 3px 0px rgba(0, 0, 0, 0.25);
}
</style>

<%@ include file="../common/foot.jspf"%>