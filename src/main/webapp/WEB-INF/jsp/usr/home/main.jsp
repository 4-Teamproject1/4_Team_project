<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>
<style>
/* 배경화면실험 */
/* 움직이는화면실행 */
*, *:before, *:after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	font-family: "Commissioner", sans-serif;
	line-height: 1.65;
	position: relative;
	/*     background-color: green; */
}

.slider {
	position: relative; /* 부모 요소에 대해 상대적인 위치 설정 */
	height: 79vh;
	width: 100vw;
	display: flex;
	align-items: center;
	justify-content: center;
	color: black;
	position: relative;
	overflow: hidden;
	transition: background-color 2s;
}

.slider .credits {
	position: absolute;
	top: 2rem;
	left: 2rem;
	line-height: 1.65;
	z-index: 10;
	max-width: 320px;
}

.slider .item .imgs {
	position: relative;
	width: 60%;
	padding-top: 60%;
}

.slider .item .imgs .grid {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: grid;
	grid-template-columns: repeat(12, 1fr);
	grid-template-rows: repeat(12, 1fr);
	grid-column-gap: 32px;
	grid-row-gap: 32px;
	transform: rotate(-20deg);
	opacity: 0.65;
}

.slider .item .imgs .grid .img {
	width: 100%;
	height: 100%;
	position: relative;
	will-change: transform, opacity;
}

.slider .item .imgs .grid .img img {
	position: absolute;
	top: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	position: relative;
	-webkit-filter: contrast(110%) brightness(110%) saturate(130%);
	filter: contrast(110%) brightness(110%) saturate(130%);
}

.slider .item .content {
	position: absolute;
	z-index: 2;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	line-height: 1.15;
	font-size: 8rem;
	font-weight: 700;
}

.slider .item .content .wrap {
	text-align: center;
	text-shadow: 1px 1px 4px rgba(10, 9, 8, 0.2);
	width: 100%;
	max-width: 100%;
	line-height: 1;
}

.slider .item .content .wrap .letter {
	display: inline-block;
}

.slider .nav .next, .slider .nav .prev {
	height: 2rem;
	width: 2rem;
	position: absolute;
	top: calc(50% - 1rem);
	cursor: pointer;
	z-index: 3;
	transition: transform 0.3s;
}

.slider .nav .next {
	right: 2rem;
	background-image:
		url("data:image/svg+xml,%3C?xml version='1.0' encoding='utf-8'?%3E%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M 19 8 L 19 11 L 1 11 L 1 13 L 19 13 L 19 16 L 23 12 L 19 8 z' fill='white'/%3E%3C/svg%3E");
}

.slider .nav .next:hover {
	transform: translateX(0.5rem);
}

.slider .nav .prev {
	left: 2rem;
	background-image:
		url("data:image/svg+xml,%3C?xml version='1.0' encoding='utf-8'?%3E%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M 5 8 L 1 12 L 5 16 L 5 13 L 23 13 L 23 11 L 5 11 L 5 8 z' fill='white'/%3E%3C/svg%3E");
}

.slider .nav .prev:hover {
	transform: translateX(-0.5rem);
}

.slider .nav .explore-btn {
	z-index: 4;
	position: absolute;
	bottom: 2rem;
	left: calc(50% - 4rem);
	width: 8em;
	text-align: center;
	padding: 1rem 0;
	border: solid 2px white;
	background: transparent;
	color: white;
	transition: background-color 0.3s;
	cursor: pointer;
}

.slider .nav .explore-btn:hover {
	/*    color: #0a0908; */
	color: black;
	background: black;
}

.slider .item:not(.is-active) {
	opacity: 0;
	pointer-events: none;
}

/* 메인검색영역 */
.search_box_main {
	position: absolute; /* slider에 대해 절대적인 위치 설정 */
	top: 50%; /* 원하는 위치로 조절 */
	/* 	left: 60px; /* 원하는 위치로 조절 */
	left: 15%;
	width: 1108px;
	height: 240px;
	background-color: #ffa500;
	background-color: rgba(255, 165, 0, 0.9); /* 배경색과 투명도 설정 */
	border-radius: 50px;
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
	/* 	border: 2px solid red; */
}

.box_date, .select {
	margin-top: 60px; /* 원하는 만큼의 여백을 설정하여 요소를 밑으로 내립니다. */
}

.search_box_custom {
	position: absolute; /* 절대적인 위치 설정 */
	top: -1px; /* 상단 */
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
	height: 40px; /* 높이 설정 */
	padding: 10px; /* 내부 여백 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	border-radius: 50px;
}

.btnSearch {
	width: 350px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 40px; /* 높이 설정 */
}

.box_start {
	position: fixed;
	width: 300px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 40px; /* 높이 설정 */
	padding: 10px; /* 내부 여백 설정 */
	margin-top: 8px;
	margin-left: 70px; /* box_start와의 간격을 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	order: 1; /* box_start를 두 번째로 나오도록 순서를 2로 설정 */
	border-radius: 50px;
	margin-left: 70px;
}

.box_end {
	position: fixed;
	width: 300px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 40px; /* 높이 설정 */
	margin-top: 8px;
	margin-left: 428px; /* box_start와의 간격을 설정 */
	padding: 10px; /* 내부 여백 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	order: 2; /* box_end를 가장 먼저 나오도록 순서를 1로 설정 */
	border-radius: 50px;
}

.box_date {
	position: fixed;
	top: 40px;
	width: 400px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
	height: 40px; /* 높이 설정 */
	padding: 10px; /* 내부 여백 설정 */
	margin-left: 70px; /* box_start와의 간격을 설정 */
	font-size: 16px; /* 글꼴 크기 설정 */
	box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
	border-radius: 50px;
	order: 3;
}

.select_box {
	margin-top: 33px;
	margin-left: -5%; /* box_start와의 간격을 설정 */
	order: 4; /* select를 네 번째로 나오도록 순서를 4로 설정 */
	/* 	border: 2px solid red; */
}

.btn_box {
	width: 400px;
	height: 53px;
	width: 300px;
	margin-top: 160px;
	margin-left: 240px;
	/* 	background-color: green; */
}

.search_btn {
	width: 300px;
	height: 40px;
	font-size: 16px; /* 글꼴 크기 설정 */
}

@media ( max-width : 991px) {
	.search_box_main {
		width: 80%; /* 너비를 뷰포트의 80%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		left: 10%; /* 왼쪽 여백을 뷰포트의 10%로 설정 */
	}
	.search_box {
		width: 90%; /* 너비를 뷰포트의 90%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		left: 40%; /* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.search_box_custom {
		padding: 0 20px; /* 왼쪽과 오른쪽 여백을 설정 */
		width: 90%; /* 너비를 뷰포트의 90%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		left: 46%; /* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.box_start {
		padding: 0 20px; /* 왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px); /* 너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-right: 20px; /* 오른쪽 여백 설정 */
		margin-left: 11%; /* 왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left; /* 왼쪽으로 플로팅 */
	}
	.box_end {
		padding: 0 20px; /* 왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px); /* 너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-left: 55%; /* 왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left; /* 왼쪽으로 플로팅 */
	}
	.box_date {
		padding: 0 20px; /* 왼쪽과 오른쪽 여백을 설정 */
		width: 38%; /* 너비를 뷰포트의 40%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 11%;
		margin-top: 5%;
		clear: both;
		margin-top: 5%; /* float 요소 아래로 내려가게 함 */
	}
	.select_box {
		padding: 0 20px; /* 왼쪽과 오른쪽 여백을 설정 */
		width: 80%; /* 너비를 뷰포트의 90%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		margin-top: 10px;
		margin-left: -20%; /* 왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.btn_box {
		padding: auto; /* 왼쪽과 오른쪽 여백을 설정 */
		width: 90%; /* 너비를 뷰포트의 90%로 설정 */
		margin: auto; /* 가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 25%;
		margin-top: 24%; /* 위쪽 여백 조정 */
		clear: both; /* float 요소 아래로 내려가게 함 */
	}
}

/* main페이지 하단 정보요약글 */
.event-schedule {
	align-items: center;
	background-color: rgba(220, 220, 220, 0.2);
	box-shadow: 0px 4px 30px 0px rgba(0, 0, 0, 0.25);
	display: flex;
	flex-direction: column;
	padding: 19px 60px 9px;
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

.event-column {
	display: flex;
	flex-direction: column;
	line-height: normal;
	margin-left: 0;
	margin-right: 5%;
	width: 45%;
}

.event-column-secondary {
	display: flex;
	flex-direction: column;
	line-height: normal;
	margin-left: 5%;
	width: 45%;
}

@media ( max-width : 991px) {
	.event-column {
		width: 100%;
		margin: auto;
	}
}

@media ( max-width : 991px) {
	.event-column-secondary {
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
	background-color: #fff;
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
	align-self: end;
	font-family: Inter, sans-serif;
	margin-top: 24px;
}

.event-date {
	align-self: end;
	color: #878787;
	font-family: Inter, sans-serif;
	margin-top: 38px;
}

.event-more-button {
	align-items: center;
	align-self: center;
	background-color: rgba(239, 152, 46, 0.3);
	border-radius: 37px;
	color: #0f0e0e;
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

<div class="main_background">
	<div class="slider">
		<div class="nav">
			<div class="next" style=""></div>
			<div class="prev"></div>
		</div>
		<div class="item is-active">
			<div class="content">
				<img class="wrap" src="https://url.kr/prk3yu" alt="" />
			</div>
		</div>
		<div class="item">
			<div class="content">
				<img class="wrap" src="https://url.kr/lxz4iu" alt="" />
			</div>
		</div>
		<div class="item">
			<div class="content">
				<img class="wrap" src="https://url.kr/zxkg8d" alt="" />
			</div>
		</div>
		<div class="item">
			<div class="content">
				<img class="wrap" src="https://url.kr/u2brfm" alt="" />
			</div>
		</div>
	</div>
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
									<p class="event-description">학술행사일정 미리보기해야지</p>
								</div>
								<time class="event-date">04.04</time>
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
								<p class="event-description">공모전일정 미리보기해야지</p>
							</div>
							<time class="event-date">04.04</time>
						</div>
						<a href="#" class="event-more-button">더보기</a>
					</article>
				</div>
			</div>
		</div>
	</section>
</section>


<%@ include file="../common/foot.jspf"%>