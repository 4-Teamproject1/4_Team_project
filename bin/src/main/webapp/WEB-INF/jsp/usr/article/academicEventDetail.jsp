<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="AcademicEvent Detail"></c:set>
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

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #00256c; color: white;">학술연구정보</a>
		<a href="#" class="list-board-item">학술행사</a>
		<a href="#" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">
			<form class="search-form">
			</form>
			<div>
				<div style="font-size: 20px; margin-bottom: 10px;">학술행사</div>
				<div class="detail-top-bar">
					<div style="font-size: 24px; margin-top: 10px;">한국비임상기술지원센터 웨비나</div>
					<ul class="top-bar-count">
						<li>
							조회수
							<span>53</span>
						</li>
						<li>
							즐겨찾기수
							<span>3</span>
						</li>
					</ul>
					<ul class="">즐겨찾기</ul>
				</div>

				<table class="table">
					<tbody>
						<tr>
							<td>행사기간</td>
							<td>24.06.27 14:00 ~ 24.06.28 15:00</td>
							<td>접수기간</td>
							<td>24.04.15 ~ 24.05.31 자정</td>
						</tr>
						<tr>
							<td>참가비</td>
							<td>무료</td>
							<td>관련 홈페이지</td>
							<td>
								<a href="">바로가기</a>
							</td>
						</tr>
						<tr>
							<td>담당자 연락처</td>
							<td>
								<span>063-530-9432</span>
							</td>
							<td>담당자 이메일</td>
							<td>hj1234@1894.or.kr</td>
						</tr>
					</tbody>
				</table>
				<div class="competition-body">
					<img
						src="https://cdn.builder.io/api/v1/image/assets/TEMP/9d0c542028057f20f2d45c75ba4004ec4f7ee9ad64ae8306ab3b4296555b3e30?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
						alt="" loading="lazy" />
				</div>
				<div class="bookmark">
					<div class="place-box">
						<div>장소</div>
						<div class="map" id="map" style="width: 500px; height: 350px;"></div>
						<div>교통편</div>
						<div>바로가기</div>
					</div>

					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	4d58ba447ad884369bfffee6e0c34649"></script>
					<script>
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new kakao.maps.LatLng(33.450701,
									126.570667), // 지도의 중심좌표
							level : 3
						// 지도의 확대 레벨
						};

						var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

						// 마커가 표시될 위치입니다 
						var markerPosition = new kakao.maps.LatLng(33.450701,
								126.570667);

						// 마커를 생성합니다
						var marker = new kakao.maps.Marker({
							position : markerPosition
						});

						// 마커가 지도 위에 표시되도록 설정합니다
						marker.setMap(map);

						// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
						// marker.setMap(null);
					</script>
					<button class="bookmark-button">즐겨찾기</button>
				</div>
			</div>
		</div>
	</div>

	<div class="side-bar-container"></div>
</div>


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

/* flex */
.list-container {
	display: flex;
}

.list-board {
	flex: 0.5;
	margin-top: 30px;
	margin-left: 10px;
	margin-right: 10px;
}

.list-items-container {
	flex: 4;
	margin: 20px;
}

.list-board-item:hover, .list-board-item:active {
	background-color: #7E9DD9; /* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
	color: white;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
}

.side-bar-container {
	flex: 1;
}

/* Sorting Options */
.sort-options {
	gap: 0.75rem;
	margin-top: 1.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
}

.detail-top-bar {
	border-top: solid 2px #878787;
}

.top-bar-count {
	display: flex;
}

.top-bar-count>li {
	display: inline-block;
	margin-right: 20px;
}

.top-bar-count>li>span {
	margin-left: 5px;
}

/* Table */
.table {
	border-collapse: collapse;
	border-spacing: 0;
}

tr {
	justify-content: center;
}

.table td {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

.competition-body {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%; /* 부모 요소의 높이에 따라 이미지 세로 중앙 정렬 */
}

.competition-body img {
	max-width: 100%; /* 이미지의 최대 너비를 부모 요소 너비에 맞춤 */
	max-height: 100%; /* 이미지의 최대 높이를 부모 요소 높이에 맞춤 */
}

.bookmark {
	text-align: center;
}

.place-box{
	text-align: left;
}
.map {
	border: solid 1px black;
}

.bookmark-button {
	border: solid 1px black;
	border-radius: 10px;
	padding: 20px 60px;
}

.bookmark-button:hover {
	background-color: #7E9DD9;
	color: white;
}
</style>

<%@ include file="../common/foot.jspf"%>