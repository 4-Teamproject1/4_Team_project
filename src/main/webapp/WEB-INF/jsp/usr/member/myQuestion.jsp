<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Question"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>

<c:if test="${!rq.isLogined()}">
	<script>
		const resultMsg = 'F-1 / 로그인이 필요합니다.'.trim();
		if (resultMsg.length > 0) {
			alert(resultMsg);
		}
		if (confirm('이전 페이지로 이동하시겠습니까?')) {
			history.back();
		} else {
			location.href = '/';
		}
	</script>
</c:if>



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
		<c:if test="${!rq.isLogined() }">

			<a class="hover:underline" href="${rq.loginUri }">로그인</a>

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
		<div class="bar_title">문의 제목</div>
		<div class="bar_date">문의 날짜</div>
		<c:if test="${loggedInMemberId == 'admin' }">
        <div class="bar_delete">삭제</div>
    </c:if>
	</div>

	<div class="question_box">
		<c:forEach var="inquiry" items="${inquiries}">
			<div class="question_content">
				<div class="bar_num">${inquiry.id}</div>
				<div class="bar_title">
					<a href="myQuestionDetail?id=${inquiry.id}">${inquiry.title}</a>
				</div>
				<div class="bar_date">${inquiry.regDate}</div>
				<div class="bar_delete">
					<c:if test="${loggedInMemberId == 'admin' }">
						<a class="delete_btn btn" onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;" href="../member/doDelete?id=${inquiry.id }">삭제</a>
					</c:if>
				</div>
			</div>
		</c:forEach>
	</div>
</section>

<div class="bottom-bar">
	<div class="page-bar">

		<button>
			<a href=""><</a>
		</button>
		<button>
			<a href="">1</a>
		</button>
		<button>
			<a href="">2</a>
		</button>
		<button>
			<a href="">3</a>
		</button>
		<button>
			<a href="">></a>
		</button>

	</div>
</div>

<style>
body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding: 0;
}
/* 상단바 메뉴 */
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

/* 상단 이미지 */
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

/* 상단바 메뉴 */
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

/* 문의 리스트 박스 */
.question_list {
	position: absolute;
	top: 270px;
	left: 18.5%;
	width: 1100px;
	height: auto;
	margin: auto;
	margin-top: 20px;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

.question_bar {
	display: flex;
	width: 1100px;
	height: 30px;
	font-size: 14px;
	color: white;
	align-items: center;
	border-radius: 5px;
	background-color: #7E9DD9;
}

.bar_num {
	position: relative;
	left: 5px;
	width: 50px;
}

.bar_title {
	position: relative;
	left: -10px;
	width: 1000px;
}

.bar_date {
	position: relative;
	left: -80px;
	width: 100px;
}

.bar_delete {
	position: absolute;
	left: 1040px;
	width: 40px;
	
}

.delete_btn {
	position: relative;
	color: white;
	background-color: #00256c;
	left: -12px;
	width: 70px;
}

.question_content {
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	top: 0px;
	width: 1100px;
	height: 80px;
	background-color: #fff;
	border-bottom: 1px solid #cbd5e0;
}

.question_content:hover {
	background-color: #B6CCF4;
	color: white;
}

/* 하단 바 */
.bottom-bar {
	position: relative;
	top: 90%;
	left: -4.5%;
	text-align: center;
}

.page-bar>button>a:hover {
	background-color: #7E9DD9;
	color: white;
}

.page-bar>button>a {
	border: solid 1px gray;
	border-radius: 10px;
	padding-top: 8px;
	padding-bottom: 8px;
	padding-left: 16px;
	padding-right: 16px;
}
</style>

<%@ include file="../common/foot.jspf"%>