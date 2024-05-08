<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="RecommendTrain List"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>


<header class="header">
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
	<nav class="header_menu">
		<c:choose>
			<c:when test="${empty loggedInMemberName}">
				<a class="hover:underline" href="${rq.loginUri}">로그인</a>
			</c:when>
			<c:otherwise>
				<a href="../member/myInfo">
					<button class="username">${loggedInMemberName}님</button>
				</a>
			</c:otherwise>
		</c:choose>
		<a href="../conference/list">
			<button class="hd_info">학회 정보</button>
		</a>
		<a href="../competition/list">
			<button class="hd_contest">공모전</button>
		</a>
		<a href="../member/myQuestion">
			<button class="hd_question">문의사항</button>
		</a>
		<c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>

<div class="img"></div>

<div class="list-container">
	<ul class="accommodation-nav-list">
		<a href="../hotel/recommendlist">
			<div class="accommodation-nav-item btn m-1">숙소</div>
		</a>
		<div class="dropdown">
			<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
			<ul tabindex="0" class="dropdown-content">
				<li>
					<a href="../recommend/TrainList">기차</a>
				</li>
				<li>
					<a href="../recommend/BusList">버스</a>
				</li>
			</ul>
		</div>
	</ul>
</div>

<form id="bus_searchform" action="/usr/recommend/BusList" method="GET">
	<div class="sort_bar">
		<span class="material-symbols-outlined bus_icon">directions_bus</span>
		<select class="select select-ghost w-full max-w-xs arrival_box" name="departureBus" id="departureBus">
			<option value="">출발 터미널</option>
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
		<select class="select select-ghost w-full max-w-xs departure_box" name="arriveBus" id="arriveBus" >
			
		</select>
		<select class="select select-ghost w-full max-w-xs date_start" name="ondate">
			<option value="">출발 일자</option>
			<option value="1">1일</option>
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
		</select>
		<select class="select people_sort_bar">
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
	<div class="outer-arrow">
		<div class="departure-place">${busLists[0].departurePlace}&nbsp→&nbsp${busLists[0].arrivePlace}</div>
		<div class="bus-total-time">${busLists[0].takesumTime}</div>
	</div>
</form>
<script>
	$(document).ready(function() {
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
											var destinations = destinationMapping[selectedDeparture]|| []; // 해당 출발지에 대한 도착지 목록 가져오기
											var arriveBusSelect = $('#arriveBus'); // 도착지 select 요소
											arriveBusSelect.empty(); // 기존 옵션 제거

											// 도착지 select 요소 업데이트
											$.each(destinations,function(index,destination) {
												arriveBusSelect.append($('<option>',{
															value : destination,
															text : destination
														}));
											});

											// 출발지 선택 여부에 따라 도착지 선택란 활성화/비활성화
											if (selectedDeparture !== '') {
												arriveBusSelect.prop(
														'disabled', false); // 도착지 선택란 활성화
											} else {
												arriveBusSelect.prop(
														'disabled', true); // 도착지 선택란 비활성화
											}
										});
						// 페이지 로드 시 초기화
						$('#departureBus').trigger('change');
					});
</script>

<script>
    $(document).ready(function() {
        // 예매하기 버튼 클릭 이벤트 설정
        $('.reservation-btn').click(function() {
            // 새 창에서 kobus 웹사이트를 엽니다
            window.open('https://www.kobus.co.kr/main.do', '_blank');
        });
    });
</script>

<div class="bus-info-main">
	<c:if test="${not empty busLists}">
		<c:forEach var="bus" items="${busLists}" varStatus="loop">
			<c:if test="${not loop.first}">
				<!-- 첫 번째 요소를 제외한 경우에만 출력 -->
				<div class="bus_box">
					<c:if test="${not empty bus.startTime}">
						<div class="bus-class">${bus.grade}</div>
						<div class="bus-operator">${bus.companyName}</div>
						<div class="departure-time">
							출발시간
							<div style="font-size: 23px; font-weight: bold;">${bus.startTime}</div>
						</div>
						<span class="view-details">${bus.remainingSeats}</span>
						<button class="bus_box_btn btn">예매</button>
					</c:if>
				</div>
			</c:if>
		</c:forEach>
	</c:if>
</div>


<style>

/* 지역 선택 스크롤 숨김 */
.select {
	background-color: #fff;
	-ms-overflow-style: none; /* IE and Edge */
	scrollbar-width: none; /* Firefox */
}

.select::-webkit-scrollbar {
	display: none;
}

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
	top: -50px;
	height: 60px;
	border-radius: 17px;
	background-color: #edf0f9;
}

.arrival_box, .departure_box {
	position: relative;
	top: -50px;
	width: 210px;
	left: -40px;
	height: 60px;
	padding-left: 45px;
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
	left: -40px;
	width: 150px;
	margin-left: 30px;
}

.people_sort_bar {
	width: 150px;
	left: -10px;
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
	top: 130px;
	left: 23%;
	width: 1000px;
	height: 200px;
	font-size: 16px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 2px solid #cbd5e0;
	border-radius: 50px;
	background-color: white;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
}

.bus_icon {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	position: relative;
	top: -48px;
	left: -5px;
	z-index: 5;
}

/*중앙 출발 도착 장소 메뉴*/
.outer-arrow {
	position: absolute;
	top: 42%;
	left: 48.5%;
	transform: translate(-50%, -50%);
	display: flex;
	flex-direction: column; /* 요소들을 수직으로 배치 */
	width: 500px;
	height: 90px;
	border-radius: 20px;
	color: white;
	background-color: #7e9dd9;
	text-align: center;
	justify-content: center;
	align-items: center;
}

.departure-place {
	margin-bottom: 15px;
	font-size: 18px;
	letter-spacing: 3px;
}

.bus-total-time {
	font-size: 15px;
}

.arrow {
	margin: 0 10px;
	font-size: 15px;
	color: white;
}

/* 추천목록 중앙서치박스 */
.searchBox {
	display: flex;
	justify-content: center;
	position: relative;
	border-top: 1px solid rgba(237, 240, 249, 1);
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	top: 135px;
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

.search-date {
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
	top: 245px;
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
	top: 150px;
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
		url('https://velog.velcdn.com/images/vrslxowe/post/6a05efd0-4dc6-4340-a064-537f0309bea6/image.jpg')
		no-repeat;
	background-size: cover;
}

/* 예매가능 버스 목록 */
.bus-info-main {
	position: relative;
	display: inline-block;
	top: 160px;
	left: 27%;
	height: 0;
	width: 850px;
	flex-direction: column;
	line-height: normal;
}

.bus_box {
	position: relative;
	height: 200px;
}

.bus-class {
	border-radius: 5px;
	background-color: #B6CCF4;
	color: #e70815;
	justify-content: center;
	padding: 6px 12px;
	font-size: 14px;
}

.bus-operator {
	position: relative;
	font-size: 14px;
	top: -24.5px;
	left: 50px;
}

.departure-time {
	position: relative;
	font-size: 14px;
	height: 70px;
	width: 100px;
	left: 80px;
	top: 37.5px;
	text-align: center;
}

.view-details {
	position: relative;
	justify-content: center;
	left: 400px;
	top: -13px;
}

.bus_box_btn {
	position: relative;
	display: flex;
	width: 75px;
	height: 50px;
	left: 700px;
	top: -50px;
	font-size: 16px;
	color: white;
	background-color: #00256C;
	border-radius: 37px;
	justify-content: center;
	align-items: center;
}

.arrow {
	color: #525252;
	font: 600 29px Inter, sans-serif;
	height: 50px;
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