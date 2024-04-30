<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Question"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<header class="header">
<<<<<<< HEAD
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
</header></header>
=======
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
	<nav class="header_menu">
		<a href="../member/myInfo">
			<button class="username">abc123님</button>
		</a>
		<a href="../article/academicEventList">
			<button class="hd_info">학회 정보</button>
		</a>
		<a href="../article/competitionList">
			<button class="hd_contest">공모전</button>
		</a>
		<a href="../member/myQuestion">
			<button class="hd_question">문의사항</button>
		</a>
		<button class="hd_logout">로그아웃</button>
	</nav>
</header>
>>>>>>> 8fbb975e765942c5e28ec033673cced23243f2bb

<div class="img"></div>
<div class="menu_box1 left">
	<div class="mypage">문의사항</div>
</div>

<div class="Question_box title">
	<div class="Ques1">제목</div>
	<input class="Ques2" type="text" autocomplete="off" placeholder="제목을 입력하세요">
</div>

<div class="Question_box file">
	<div class="Ques1" placeholder="첨부파일 없음">첨부파일</div>
	<div class="Ques2 file_attachment"></div>
	<button class="Ques2 file_btn">파일 선택하기</button>
</div>

<div class="Question_box content">
	<div class="content Ques1">내용</div>
	<input class="Ques2" type="text" autocomplete="off" placeholder="내용을 입력하세요">
</div>

<button class="write_btn">등록</button>

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

.Question_box {
	top: 200px;
	left: 25%;
	height: 87px;
	width: 1000px;
	position: relative;
	border-bottom-width: 1px;
	border-color: #878787;
}

.Ques1 {
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

.Ques2 {
	top: -55px;
	left: 19%;
	width: 200px;
	position: relative;
}

.title {
	height: 89px;
	border-top-width: 2px;
	border-top-color: #535353;
}

.content {
	height: 350px;
}

.content>input {
	top: -90%;
}

.file_attachment {
	height: 30px;
	border: 1px solid black;
	border-radius: 6px;
}

.file_btn {
	top: -105%;
	left: 41%;
	width: 95px;
	height: 38px;
	font-size: 12.5px;
	border-radius: 10px;
	background: #7E9DD9;
	color: white;
	box-shadow: 4px 3px 3px 0px rgba(0, 0, 0, 0.25);
}

.write_btn {
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