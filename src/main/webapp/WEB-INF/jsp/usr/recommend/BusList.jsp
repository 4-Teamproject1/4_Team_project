<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="RecommendBus List"></c:set>
<%@ include file="../common/head.jspf"%>
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
		</a> <a href="../conference/list">
			<button class="hd_info">학회 정보</button>
		</a> <a href="../competition/list">
			<button class="hd_contest">공모전</button>
		</a> <a href="../member/myQuestion">
			<button class="hd_question">문의사항</button>
		</a>
		<button class="hd_logout">로그아웃</button>
	</nav>
</header>

<div class="img"></div>

<div class="list-container">
	<ul class="accommodation-nav-list">
		<a href="../article/recommendlist">
			<div class="accommodation-nav-item btn m-1">숙소</div>
		</a>
		<div class="dropdown">
			<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
			<ul tabindex="0" class="dropdown-content">
				<li><a href="../recommend/TrainList">기차</a></li>
				<li><a href="../recommend/BusList">버스</a></li>
			</ul>
		</div>
	</ul>
</div>

<form id="bus_searchform" action="/usr/article/recommendBusList_verAjax" method="GET">
	<div class="sort_bar">
		<select class="select select-ghost w-full max-w-xs" name="departureBus" id="departureBus">
			<option value="">버스역선택</option>
			<option value="대전복합">대전복합</option>
			<option value="동대구">동대구</option>
			<option value="동서울">동서울</option>
			<option value="센트럴시티">센트럴시티(서울)</option>
			<option value="서울경부">서울경부</option>
			<option value="서대구">서대구</option>
			<option value="대전청사">대전청사(샘머리)</option>
			<option value="대전도룡">대전도룡</option>
			<option value="창원">창원</option>
			<option value="창원역">창원역</option>
			<option value="포항시청">포항시청</option>
			<option value="포항">포항</option>
			<option value="성남">성남(분당)</option>
			<option value="창원역">창원역</option>
		</select> 
		<select class="select select-ghost w-full max-w-xs" name="arriveBus" id="arriveBus" placeholder="출발역먼저선택">
			<option value="">버스역선택</option>
		</select> 
		<select class="search-date-text" name="ondate">
			<option value="">가는날</option>
			<option value="2">2일</option>
			<option value="3">3일</option>
			<option value="4">4일</option>
			<option value="5">5일</option>
			<option value="6">6일</option>
			<option value="7">7일</option>
			<option value="8">8일</option>
			<option value="9">9일</option>
			<option value="10">10일</option>
			<option value="11">11일</option>
			<option value="12">12일</option>
			<option value="13">13일</option>
			<option value="14">14일</option>
			<option value="15">15일</option>
			<option value="16">16일</option>
			<option value="17">17일</option>
			<option value="18">18일</option>
			<option value="19">19일</option>
			<option value="20">20일</option>
			<option value="21">21일</option>
			<option value="22">22일</option>
			<option value="23">23일</option>
			<option value="24">24일</option>
			<option value="25">25일</option>
			<option value="26">26일</option>
			<option value="27">27일</option>
			<option value="28">28일</option>
			<option value="29">29일</option>
			<option value="30">30일</option>
		</select> <select class="select people_sort_bar">
			<option>1명</option>
			<option>2명</option>
			<option>3명</option>
			<option>4명</option>
			<option>5명</option>
			<option>6명</option>
			<option>7명</option>
			<option>8명</option>
		</select>
		<button id="bus_searchbutton" class="btn_sort_bar btn" type="submit">검색하기</button>
	</div>
</form>

<script>
	$(document)
			.ready(
					function() {
						// 출발지와 해당 출발지에 대한 도착지 매핑 정보
						var destinationMapping = {
							"동서울" : [ "동해", "대전복합", "청주고속터미널", "광주(유·스퀘어)",
									"전주고속터미널", "마산", "부산", "진해", "창원", "창원역",
									"동대구", "서대구" ],
							"대전복합" : [ "광주(유·스퀘어)", "서울경부", "인천", "전주고속터미널",
									"동서울" ],
							"동대구" : [ "동서울", "서울경부", "성남(분당)", "의정부", "인천",
									"광주(유·스퀘어)", "목포", "전주고속터미널", "부산", "마산",
									"진해" ],
							"센트럴시티" : [ "광주(유·스퀘어)", "태안", "논산", "서산", "유성",
									"청주공항", "익산", "전주고속터미널", "김제", "군산", "진안",
									"목포", "순천", "여수" ],
							"서울경부" : [ "대전도룡", "대전복합", "대전청사(샘머리)", "포항시청",
									"죽전", "천안", "동대구" ],
							"서대구" : [ "동서울", "서울경부", "성남(분당)", "인천", "춘천",
									"광주(유·스퀘어)", "청주고속터미널", "전주고속터미널", "마산",
									"진해" ],
							"대전청사" : [ "광주(유·스퀘어)", "서울경부", "전주고속터미널" ],
							"대전도룡" : [ "서울경부" ],
							"창원" : [ "광주(유·스퀘어)", "동서울", "서울경부", "성남(분당)",
									"용인", "용인신갈" ],
							"창원역" : [ "동서울", "서울경부" ],
							"포항시청 " : [ "광주(유·스퀘어)", "서울경부" ],
							"포항" : [ "광주(유·스퀘어)", "서울경부" ],
							"성남" : [ "광주(유·스퀘어)", "동대구", "마산", "부산", "서대구",
									"전주고속터미널", "진해", "창원" ]
						};

						 // 출발지가 변경될 때마다 도착지 옵션을 업데이트하는 함수
				        $('#departureBus').change(function() {
				            var selectedDeparture = $(this).val(); // 선택된 출발지 값 가져오기
				            var destinations = destinationMapping[selectedDeparture] || []; // 해당 출발지에 대한 도착지 목록 가져오기
				            var arriveBusSelect = $('#arriveBus'); // 도착지 select 요소

				            arriveBusSelect.empty(); // 기존 옵션 제거

				            // 도착지 select 요소 업데이트
				            $.each(destinations, function(index, destination) {
				                arriveBusSelect.append($('<option>', {
				                    value: destination,
				                    text: destination
				                }));
				            });

				            // 출발지 선택 여부에 따라 도착지 선택란 활성화/비활성화
				            if (selectedDeparture !== '') {
				                arriveBusSelect.prop('disabled', false); // 도착지 선택란 활성화
				            } else {
				                arriveBusSelect.prop('disabled', true); // 도착지 선택란 비활성화
				            }
				        });

				        // 페이지 로드 시 초기화
				        $('#departureBus').trigger('change');
				    });
</script>

<div class="place-box">
	<div class="outer-arrow">
		<div class="departure-place">${busLists[0].departurePlace}</div>
		<span class="arrow"> → </span>
		<div class="arrive-place">${busLists[0].arrivePlace}</div>
		<div class="bus-total-time">소요시간: ${busLists[0].takesumTime}</div>
	</div>
</div>
<div class="bus_box">
	<div class="bus-info-main">
		<c:if test="${not empty busLists}">
			<c:forEach var="bus" items="${busLists}" varStatus="loop">
				<c:if test="${not loop.first}">
					<!-- 첫 번째 요소를 제외한 경우에만 출력합니다 -->
					<c:if test="${not empty bus.startTime}">
						<div class="bus-info-header">
							<div class="bus-type">
								<span class="bus-class">${bus.grade}</span> <span class="bus-operator">${bus.companyName}</span>
							</div>
							<div class="bus-timings">
								<time class="departure-time">출발시간: ${bus.startTime}</time>
								<div class="bus-features">
									<div class="bus-price-details">
										<span class="view-details">${bus.remainingSeats}</span>
									</div>
									<button class="btn">예매하기</button>
								</div>
							</div>
						</div>
						<hr class="separator" />
					</c:if>
				</c:if>
			</c:forEach>
		</c:if>
	</div>
</div>


<style>
.popup {
	position: absolute;
	top: 35%;
	left: 23%;
	width: 660px;
	height: 350px;
	background-color: white;
	border-radius: 17px;
	padding: 10px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
	z-index: 10;
	display: none;
	overflow-y: auto;
	/* 스크롤바 숨김 */
	scrollbar-width: none; /* Firefox */
	-ms-overflow-style: none; /* IE 10+ */
}

.area {
	cursor: pointer;
	padding: 10px;
	margin: 5px;
	display: inline-block;
	width: calc(20% - 10px);
	/* Set width for 5 regions in a row with margins */
	text-align: center;
	border-radius: 5px;
	transition: background-color 0.1s ease;
	/* Add transition for hover effect */
}

.area:hover {
	background-color: #f0f0f0;
}

.people_sort_bar, .btn_sort_bar, .date_start {
	position: relative;
	height: 60px;
	border-radius: 17px;
	background-color: #edf0f9;
}

.arrival_box, .departure_box {
	position: relative;
	width: 190px;
	left: -60px;
	height: 60px;
	padding-left: 30px;
	background-color: #edf0f9;
}

.arrival_box {
	border-right: 1px solid #cbd5e0;
	border-radius: 17px 0 0 17px;
}

.departure_box {
	border-left: 1px solid #cbd5e0;
	border-radius: 0 17px 17px 0;
}

.date_start {
	left: -10px;
	width: 150px
}

.people_sort_bar {
	width: 190px;
}

.btn_sort_bar {
	left: 15px;
	width: 100px;
	height: 60px;
	color: white;
	border-radius: 19px;
	background-color: #00256C;
}

.sort_bar {
	position: relative;
	top: 95px;
	left: 23%;
	width: 1000px;
	height: 70px;
	font-size: 16px;
	border-radius: 21px;
	border: 1px solid rgba(221, 223, 226, 1);
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	width: 1000px;
	left: 23%;
}

/* 추천목록 중앙서치박스 */
.searchBox {
	display: flex;
	justify-content: center;
	position: relative;
	border-top: 1px solid rgba(237, 240, 249, 1);
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	top: 95px;
	left: 23%;
	width: 1000px;
	height: 200px;
	border-radius: 50px;
	border: 2px solid #cbd5e0;
	background-color: white;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
}

.search-header {
	position: relative;
	display: flex;
	width: 1000px;
	justify-content: center;
	align-items: center;
}

.search-content {
	position: relative;
	display: flex;
	height: 72px;
	justify-content: space-between;
}

/* 검색칸 */
.flight-route {
	display: flex;
	gap: 4px;
}

.search-button {
	display: flex;
	height: 70px;
	font-size: 16px;
	color: white;
	background-color: #00256C;
	border-radius: 37px;
	justify-content: center;
	align-items: center;
}

.search-date-text {
	position: relative;
	font-size: 14px;
	color: #24262c;
	width: 120px;
	margin-right: 10px;
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 22px 4px 4px 22px;
	padding: 12px 5px 12px 16px;
	background-color: #edf0f9;
}

.select_people {
	position: relative;
	display: flex;
	height: 72px;
	width: 100px;
	justify-content: center;
	align-items: center;
	padding: 8px 5px 8px 0;
	border-radius: 4px 22px 22px 4px;
	background-color: #edf0f9;
	margin-right: 10px;
	border-radius: 4px 22px 22px 4px;
}

.origin-airport {
	position: relative;
	display: flex;
	font-size: 14px;
	color: #24262c;
	padding: 12px 5px 12px 16px;
	border-radius: 22px 4px 4px 22px;
	background-color: #edf0f9;
	margin-right: 5px;
}

.destination-airport {
	display: flex;
	padding: 8px 5px 8px 0;
	border-radius: 4px 22px 22px 4px;
	background-color: #edf0f9;
	margin-right: 10px;
	padding: 8px 5px 8px 0;
	border-radius: 4px 22px 22px 4px;
	background-color: #edf0f9;
}

.train_icon {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	display: flex;
	justify-content: center;
	align-items: center;
	display: flex;
}

/* 왼쪽 서치박스*/
.list-container {
	display: flex;
	position: relative;
	top: 205px;
	left: 30px;
}

.accommodation-nav-list {
	position: relative;
	width: 337px;
	list-style: none;
	padding: 0;
}

.accommodation-nav-item {
	width: 200px;
	background-color: #00256C;
	color: white;
	padding: 10px;
	margin-bottom: 5px;
}

.dropdown-content {
	display: none;
	width: 200px;
	height: 140px;
	color: black;
	list-style: none;
	padding-top: 3px;
	border-top: 2px solid #cbd5e0;
	border-bottom: 2px solid #cbd5e0;
}

.dropdown-content li {
	padding: 10px;
	text-align: center;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.ticket_box {
	position: relative;
	top: 110px;
	left: 23%;
	height: 200px;
	width: 1000px;
}

/*상단 바*/
body {
	width: 100%;
	height: 130%;
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
		url('https://velog.velcdn.com/images/vrslxowe/post/6a05efd0-4dc6-4340-a064-537f0309bea6/image.jpg')
		no-repeat;
	background-size: cover;
}

/* 예매가능 버스 목록 */
.bus-info-main {
	position: relative;
	top: 90px;
	left: 35%;
	width: 1000px;
	height: 200px;
	display: flex;
	flex-direction: column;
	line-height: normal;
	margin-left: 0;
	display: flex;
	line-height: normal;
	flex-direction: column;
	display: flex;
	height: 200px;
}

.bus-info-header {
	display: flex;
	flex-grow: 1;
	flex-direction: column;
	align-items: start;
	text-align: center;
	/*    border: 3px solid; */
	width: 700px;
}

.bus-type {
	display: flex;
	gap: 10px;
	white-space: nowrap;
}

.bus-speed {
	border-radius: 5px;
	background-color: #f30e0e;
	color: #fff;
	justify-content: center;
	padding: 5px 13px;
	font: 700 10px Inter, sans-serif;
}

.bus-class {
	background-color: #fff;
	color: #e70815;
	justify-content: center;
	padding: 3px 6px;
	font: 500 15px Inter, sans-serif;
}

.bus-timings {
	background-color: #fff;
	align-self: stretch;
	display: flex;
	gap: 17px;
	font-size: 34px;
	color: #000;
	padding: 15px 20px 0 0;
	/*     border: 3px solid; */
	width: 500px;
}

.departure-time {
	font-family: Inter, sans-serif;
	font-weight: 700;
}

.arrow {
	color: #525252;
	font: 600 29px Inter, sans-serif;
	/*     border: 3px solid; */
	height: 50px;
}

.arrival-time {
	font-family: Inter, sans-serif;
	font-weight: 300;
}

.duration {
	flex-grow: 1;
	flex-basis: auto;
	margin: auto 0;
	font: 400 20px Inter, sans-serif;
	/*     border: 3px solid; */
	width: 300px;
}

.bus-features {
	display: flex;
	/*   margin-top: 5px; */
	gap: 20px;
	font-size: 15px;
	/* border: 3px solid; */
}

.bus-type-duration {
	display: flex;
	gap: 5px;
	flex: 1;
}

.bus-type-label {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: #d9d9d9;
	color: #fff;
	font-weight: 700;
	white-space: nowrap;
	justify-content: center;
	padding: 7px;
	height: 30px;
	/*     margin-top: 30px; */
}

.bus-type-duration-value {
	color: #000;
	font-family: Inter, sans-serif;
	font-weight: 500;
	margin: auto 0;
	width: 100px;
}

.bus-operator {
	color: #000;
	font-family: Inter, sans-serif;
	font-weight: 500;
	flex-grow: 1;
	flex-basis: auto;
	margin: auto 0;
}

.bus-info-price {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 16%;
	margin-left: 20px;
}

.bus-price-details {
	display: flex;
	flex-direction: column;
	align-self: stretch;
	color: #000;
	font-weight: 400;
	white-space: nowrap;
	text-align: center;
	margin: auto 0;
}

.view-details {
	background-color: #fff;
	justify-content: center;
	padding: 10px 16px;
	font: 300px 14px/110% Roboto, sans-serif;
}

.price {
	border-radius: 10px;
	background-color: #fff;
	justify-content: center;
	padding: 11px 9px;
	font: 20px Inter, sans-serif;
}

.separator {
	border-color: rgba(0, 0, 0, 1);
	border-style: solid;
	border-width: 1px;
	background-color: #000;
	min-height: 1px;
	margin-top: 25px;
	width: 640px;
}

/*출발,도착장소 css*/

/*좌측 출발 도착 장소 메뉴*/
.place-box {
	position: relative;
	top: 100px;
	left: 35%;
	width: 500px;
	height: 120px;
	color: white;
	margin-bottom: 20px; /* 필요에 따라 여백 조절 */
	text-align: center;
	background-color: #7E9DD9;
}

.outer-arrow {
	width: 200px;
	height: 100px;
	display: inline-block;
	align-items: center;
	justify-content: center;
	margin: 10px 10px;
}

.arrow {
	margin: 0 10px; /* 출발 도착장소와 화살표 사이의 여백 조정 */
	font-size: 15px; /* 필요에 따라 화살표 크기 조절 */
	color: white; /* 필요에 따라 화살표 색상 조절 */
}

@media ( max-width : 991px) {
	.bus-info-main {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.bus-info-header {
		max-width: 100%;
	}
}

@media ( max-width : 991px) {
	.bus-type {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.bus-speed {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.bus-class {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.bus-timings {
		flex-wrap: wrap;
	}
}

@media ( max-width : 991px) {
	.bus-type-label {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.bus-price-details {
		margin-top: 12px;
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.separator {
		max-width: 100%;
	}
}

@media ( max-width : 991px) {
	.bus-info-price {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.view-details {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.price {
		white-space: initial;
	}
}
</style>
<%@ include file="../common/foot.jspf"%>