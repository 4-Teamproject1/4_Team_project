<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Main"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	jQuery(document).ready(function($) {
		// 자동으로 슬라이드되도록 설정합니다.
		setInterval(function() {
			moveRight();
		}, 3000);
		var slideCount = $("#slider ul li").length;
		var slideWidth = $("#slider ul li").width();
		var slideHeight = $("#slider ul li").height();
		var sliderUlWidth = slideCount * slideWidth;
		// 슬라이더의 너비와 높이를 설정합니다.
		$("#slider").css({
			width : slideWidth,
			height : slideHeight
		});
		$("#slider ul").css({
			width : sliderUlWidth,
			marginLeft : -slideWidth
		});
		// 슬라이더의 마지막 아이템을 첫 번째로 이동시킵니다.
		$("#slider ul li:last-child").prependTo("#slider ul");
		// 왼쪽으로 슬라이드하는 함수
		function moveLeft() {
			$("#slider ul").animate({
				left : +slideWidth
			}, 200, function() {
				$("#slider ul li:last-child").prependTo("#slider ul");
				$("#slider ul").css("left", "");
			});
		}
		// 오른쪽으로 슬라이드하는 함수
		function moveRight() {
			$("#slider ul").animate({
				left : -slideWidth
			}, 200, function() {
				$("#slider ul li:first-child").appendTo("#slider ul");
				$("#slider ul").css("left", "");
			});
		}
		// 이전 버튼 클릭 시 왼쪽으로 슬라이드합니다.
		$("a.control_prev").click(function() {
			moveLeft();
		});
		// 다음 버튼 클릭 시 오른쪽으로 슬라이드합니다.
		$("a.control_next").click(function() {
			moveRight();
		});
	});
</script>

<div id="slider">
	<a href="#" class="control_next">></a>
	<a href="#" class="control_prev"><</a>
	<ul>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/de3e50a4-860c-473b-bf03-c4896ec5d90c/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/f24773fc-db1f-413f-93bf-814723438bb6/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/a38a8761-4aa9-44df-9251-59e4b6837574/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/7a82b78b-bc0a-43f6-9732-a6d71b439d96/image.jpg'); background-size: cover; background-position: center;">
		</li>
	</ul>
</div>


<div class="menu_right">
	<a href="../article/competitionList">
		<button class="competitionList">학회 정보</button>
	</a>
	<a href="../member/myQuestion">
		<button class="menu_box2 myquestion">문의사항</button>
	</a>
	<a href="../member/login">
		<button class="menu_box2 login">로그인</button>
	</a>
	<a href="../member/join">
		<button class="menu_box2 join">회원가입</button>
	</a>
</div>

<section>
	<div class="search_box_main">
		<div class="search_box_custom ">
			<div class=" ">
				<div class="btnSearch">
					<input type="text" class="SearchBoxTextEditor " placeholder="어디로 떠나시나요?" id="textInput" value="">
				</div>
			</div>
		</div>
		<div class="search_box ">
			<div>
				<input type="text" class="box_start " placeholder="출발장소" id="textInput" value="" />
			</div>
			<div>
				<input type="text" class="box_end " placeholder="도착장소" id="textInput" value="" />
			</div>
			<div>
				<input type="text" class="box_date " placeholder="가는날" id="textInput" value="" />
			</div>
			<div class="select_box">
				<select class="select select-bordered  w-32 max-w-xs">
					<option disabled selected>인원 수</option>
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
					<option>6</option>
				</select>
			</div>
			<div class="btn_box">
				<div class="search_btn btn">
					<button>검색</button>
				</div>
			</div>
		</div>
	</div>

	<section class="event-schedule">
		<div class="event-schedule-container">
			<div class="event-schedule-columns">
				<div class="event-column">
					<article class="event-card">
						<div class="event-card-content">
							<div class="event-details">
								<div class="event-info">
									<h3 class="event-title">학술행사일정</h3>
									<p class="event-description">한일차세대학술포럼</p>
									<p class="event-description">한국미디어문화학회 학술대회</p>
									<p class="event-description">국제성인역량조사(PIAAC) 학술대회</p>
									<p class="event-description">환태평양 정신의학회 학술대회</p>
								</div>
								<time class="event-date">04.05</time>
								<time class="event-date">05.11</time>
								<time class="event-date">06.28</time>
								<time class="event-date">11.18</time>
							</div>
							<a href="#" class="event-more-button">더보기</a>
						</div>
					</article>
				</div>
				<div class="event-column-secondary">
					<article class="event-card-secondary">
						<div class="event-details">
							<div class="event-info">
								<h3 class="event-title">공모전일정</h3>
								<p class="event-description">KT&G 상상실현 콘테스트</p>
								<p class="event-description">제6회 교육 공공데이터 분석·활용대회</p>
								<p class="event-description">CICA 미술관 국제전 “Drawing Now 2024” 공모</p>
								<p class="event-description">사하 수필공모전</p>
							</div>
							<time class="event-date">04.21</time>
							<time class="event-date">05.22</time>
							<time class="event-date">10.05</time>
							<time class="event-date">11.22</time>
						</div>
						<a href="#" class="event-more-button">더보기</a>
					</article>
				</div>
			</div>
		</div>
	</section>
</section>

<style type="text/css">
*, *:before, *:after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	font-family: "Commissioner", sans-serif;
	line-height: 1.65;
	height: 110%;
	position: relative;
	/* 스크롤바 숨김 */
	scrollbar-width: none; /* Firefox */
	-ms-overflow-style: none; /* IE 10+ */
	background-color: #0F1114;
}

h1 {
	text-align: center;
	font-weight: 300;
}

.menu_right {
	position: absolute;
	top: 15px;
	right: 4.5%;
	color: white;
	background-color: #00256c;
	width: 450px;
	height: 60px;
	border-radius: 10px;
	opacity: 0.9;
	text-align: center;
	justify-content: center;
	padding-top: 17px;
	letter-spacing: 40px;
}

.SearchBoxTextEditor, #textInput {
	background-color: pink;
	padding-left: 20px;
}

#slider {
	top: -20px;
	margin: 0;
	padding: 0;
	position: relative;
	overflow: hidden;
	margin: 20px auto 0 auto;
}

#slider ul {
	position: relative;
	margin: 0;
	padding: 0;
	height: 200px;
	list-style: none;
}

#slider ul li {
	width: 1920px;
	height: 600px;
	position: relative;
	display: block;
	float: left;
	margin: 0;
	padding: 0;
	text-align: center;
	background-size: contain;
}

a.control_prev, a.control_next {
	top: 40%;
	width: 50px;
	height: 50px;
	padding-top: 8px;
	position: absolute;
	display: block;
	color: #fff;
	font-weight: 600;
	font-size: 18px;
	text-align: center;
	justify-content: center;
	background: #2a2a2a;
	border-radius: 6px;
	opacity: 0.6;
	z-index: 3;
	cursor: pointer;
}

a.control_prev:hover, a.control_next:hover {
	opacity: 1;
	-webkit-transition: all 0.2s ease;
}

a.control_prev {
	border-radius: 0 2px 2px 0;
}

a.control_next {
	right: 0;
	border-radius: 2px 0 0 2px;
}

.slider_option {
	position: relative;
	margin: 10px auto;
	width: 160px;
	font-size: 18px;
}

/* 메인검색영역 */
.search_box_main {
	position: absolute; /* slider에 대해 절대적인 위치 설정 */
	top: 40%;
	left: 15%;
	width: 1108px;
	height: 240px;
	background-color: #00256c;
	opacity: 0.93; /* 배경색과 투명도 설정 */
	border-radius: 40px;
	margin-left: 100px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.8);
	z-index: 2; /* slider 위에 겹치도록 설정 */
}

.search_box {
	position: absolute; /* 절대적인 위치 설정 */
	top: 50%; /* 상단에서 50% */
	left: 580px; /* 왼쪽에서 50% */
	transform: translate(-43%, -40%); /* 가운데 정렬을 위한 변환 */
	z-index: 3;
	width: 1000px;
	height: 180px;
	display: flex;
	flex-direction: row; /* 요소들을 가로로 정렬하기 위해 flex-direction을 row로 설정 */
}

.box_date, .select {
	margin-top: 60px; /* 원하는 만큼의 여백을 설정하여 요소를 밑으로 내립니다. */
}

.search_box_custom {
	position: absolute; /* 절대적인 위치 설정 */
	top: -20px; /* 상단 */
	left: 530px; /* 왼쪽여백 */
	transform: translate(-50%, -50%); /* 가운데 정렬을 위한 변환 */
	width: 20%; /* 너비 조정 */
	height: 60px;
	z-index: 3;
	display: flex; /* 내부 요소를 수평으로 정렬하기 위해 */
	align-items: center; /* 수직 정렬 */
	justify-content: center; /* 수평 정렬 */
}

.SearchBoxTextEditor {
	position: fixed;
	width: 400px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 70px; /* 높이 설정 */
	padding: 10px; /* 내부 여백 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	border-radius: 32px;
}

.btnSearch {
	width: 350px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 40px; /* 높이 설정 */
}

.box_start, .box_end, .box_date {
	height: 55px;
	border-radius: 26px;
}

.box_start {
	position: fixed;
	width: 300px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	padding: 10px; /* 내부 여백 설정 */
	margin-top: 8px;
	margin-left: 70px; /* box_start와의 간격을 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	order: 1; /* box_start를 두 번째로 나오도록 순서를 2로 설정 */
	margin-left: 70px;
}

.box_end {
	position: fixed;
	width: 300px;
	margin-top: 8px;
	margin-left: 428px; /* box_start와의 간격을 설정 */
	padding: 10px; /* 내부 여백 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	order: 2; /* box_end를 가장 먼저 나오도록 순서를 1로 설정 */
}

.box_date {
	position: fixed;
	top: 28px;
	width: 400px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	padding: 10px; /* 내부 여백 설정 */
	margin-left: 70px; /* box_start와의 간격을 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	order: 3;
}

.select_box {
	margin-top: 29px;
	margin-left: -5%; /* box_start와의 간격을 설정 */
	order: 4; /* select를 네 번째로 나오도록 순서를 4로 설정 */
}

.search_btn {
	width: 400px;
	height: 15px;
	font-size: 16px;
	border-radius: 30px;
	margin-top: 170px;
	margin-left: 200px;
}

@media ( max-width : 991px) {
	.search_box_main {
		width: 80%;
		/* 너비를 뷰포트의 80%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		left: 10%;
		/* 왼쪽 여백을 뷰포트의 10%로 설정 */
	}
	.search_box {
		width: 90%;
		/* 너비를 뷰포트의 90%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		left: 40%;
		/* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.search_box_custom {
		padding: 0 20px;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: 90%;
		/* 너비를 뷰포트의 90%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		left: 46%;
		/* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.box_start {
		padding: 0 20px;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px);
		/* 너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-right: 20px;
		/* 오른쪽 여백 설정 */
		margin-left: 11%;
		/* 왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left;
		/* 왼쪽으로 플로팅 */
	}
	.box_end {
		padding: 0 20px;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px);
		/* 너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-left: 55%;
		/* 왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left;
		/* 왼쪽으로 플로팅 */
	}
	.box_date {
		padding: 0 20px;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: 38%;
		/* 너비를 뷰포트의 40%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 11%;
		margin-top: 5%;
		clear: both;
		margin-top: 5%;
		/* float 요소 아래로 내려가게 함 */
	}
	.select_box {
		padding: 0 20px;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: 80%;
		/* 너비를 뷰포트의 90%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		margin-top: 10px;
		margin-left: -20%;
		/* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.btn_box {
		padding: auto;
		/* 왼쪽과 오른쪽 여백을 설정 */
		width: 90%;
		/* 너비를 뷰포트의 90%로 설정 */
		margin: auto;
		/* 가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 25%;
		margin-top: 24%;
		/* 위쪽 여백 조정 */
		clear: both;
		/* float 요소 아래로 내려가게 함 */
	}
}

/* main페이지 하단 정보요약글 */
.event-schedule {
	align-items: center;
	display: flex;
	flex-direction: column;
	padding: 19px 60px 9px;
	position: absolute;
	top: 65%;
	width: 100%;
}

@media ( max-width : 991px) {
	.event-schedule {
		padding: 0 20px;
	}
}

.event-schedule-container {
	max-width: 1464px;
	width: 100%;
}

@media ( max-width : 991px) {
	.event-schedule-container {
		max-width: 100%;
	}
}

.event-schedule-columns {
	display: flex;
	gap: 20px;
}

@media ( max-width : 991px) {
	.event-schedule-columns {
		align-items: stretch;
		flex-direction: column;
		gap: 0;
	}
}

.event-column, .event-column-secondary {
	display: flex;
	flex-direction: column;
	line-height: normal;
	margin-left: 0;
	margin-right: 5%;
	width: 45%;
	background-color: #1E2A51;
	border-radius: 15px;
}

@media ( max-width : 991px) {
	.event-column, .event-column-secondary {
		width: 100%;
		margin: auto;
	}
}

.event-card {
	background-color: rgba(255, 255, 255, 0.65);
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
	display: flex;
	flex-direction: column;
	flex-grow: 1;
	font-size: 15px;
	font-weight: 400;
	justify-content: center;
	padding: 2px 0;
	text-align: center;
	white-space: nowrap;
	width: 100%;
}

@media ( max-width : 991px) {
	.event-card {
		margin-top: 40px;
		max-width: 100%;
		white-space: initial;
	}
}

.event-card-content {
	display: flex;
	flex-direction: column;
	padding: 32px 57px;
}

@media ( max-width : 991px) {
	.event-card-content {
		max-width: 100%;
		padding: 0 20px;
		white-space: initial;
	}
}

.event-details {
	display: flex;
	gap: 20px;
	justify-content: space-between;
	max-width: 100%;
	width: 410px;
}

@media ( max-width : 991px) {
	.event-details {
		white-space: initial;
	}
}

.event-info {
	color: #000;
	display: flex;
	flex-direction: column;
}

@media ( max-width : 991px) {
	.event-info {
		white-space: initial;
	}
}

.event-title {
	font-family: Inter, sans-serif;
}

.event-description {
	width: auto;
	height: 20px;
	margin-top: 24px;
	background-color: pink;
}

.event-date {
	display: block;
	width: auto;
	height: 20px;
	color: #878787;
	margin-top: 38px;
	background-color: skyblue;
}

.event-more-button {
	align-items: center;
	align-self: center;
	background-color: #243F92;
	border-radius: 37px;
	font-family: Inter, sans-serif;
	justify-content: center;
	margin-top: 116px;
	max-width: 100%;
	padding: 19px 60px;
	width: 166px;
}

@media ( max-width : 991px) {
	.event-more-button {
		margin-top: 40px;
		padding: 0 20px;
		white-space: initial;
	}
}

.event-card-secondary {
	background-color: rgba(255, 255, 255, 0.65);
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
	display: flex;
	flex-direction: column;
	flex-grow: 1;
	font-size: 15px;
	font-weight: 400;
	padding: 32px 57px;
	text-align: center;
	white-space: nowrap;
	width: 100%;
}

@media ( max-width : 991px) {
	.event-card-secondary {
		margin-top: 40px;
		max-width: 100%;
		padding: 0 20px;
		white-space: initial;
	}
}
</style>