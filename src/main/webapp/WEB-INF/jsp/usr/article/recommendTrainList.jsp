<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="RecommendTrain List"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />



<script>
	document.addEventListener('DOMContentLoaded', function() {
		// Get all booking buttons
		const bookingBtns = document.querySelectorAll('.booking-btn');

		// Add event listener to each booking button
		bookingBtns.forEach(function(btn) {
			btn.addEventListener('click', function() {
				// Find the corresponding class label
				const classLabel = btn.nextElementSibling;

				// Toggle the 'show' class on the class label
				classLabel.classList.toggle('show');
			});
		});
	});

	//Get the booking button and class label
	const bookingBtn = document.getElementById('booking-btn');
	const classLabel = document.getElementById('class-label');

	// Add click event listener to the booking button
	bookingBtn.addEventListener('click', function() {
		// Toggle the 'show' class on the class label
		classLabel.classList.toggle('show');
	});
</script>

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

<div class="list-container">
	<ul class="accommodation-nav-list">
		<a href="../article/recommendlist">
			<div class="accommodation-nav-item btn m-1">숙소</div>
		</a>
		<div class="dropdown">
			<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
			<ul tabindex="0" class="dropdown-content">
				<li>
					<a href="../article/recommendAirplaneList">항공</a>
				</li>
				<li>
					<a href="../article/recommendTrainList">기차</a>
				</li>
				<li>
					<a href="../article/recommendBusList">버스</a>
				</li>
			</ul>
		</div>
	</ul>
</div>

<div class="searchBox">
	<header class="search-header">
		<div class="search-content">
			<div class="flight-route">
				<div class="origin-airport">
					<span class="material-symbols-outlined train_icon">train</span>
					<div class="origin-airport-code">
						<select class="select select-ghost w-full max-w-xs">
							<option>서울</option>
							<option>강릉</option>
							<option>경산</option>
							<option>경주</option>
							<option>광명</option>
							<option>광주송정</option>
							<option>구포</option>
							<option>김천구미</option>
							<option>논산</option>
							<option>대전</option>
							<option>동대구</option>
							<option>마산</option>
							<option>목포</option>
							<option>밀양</option>
							<option>부산</option>
							<option>서대전</option>
							<option>서울</option>
							<option>수원</option>
							<option>순천</option>
							<option>여수EXPO(구,여수역)</option>
							<option>영등포</option>
							<option>오송</option>
							<option>용산</option>
							<option>울산(통도사)</option>
							<option>익산</option>
							<option>전주</option>
							<option>정동진</option>
							<option>정읍</option>
							<option>천안아산</option>
							<option>창원중앙</option>
							<option>청량리</option>
							<option>포항</option>
							<option>행신</option>
						</select>
					</div>
				</div>
				<div class="destination-airport">
					<div class="destination-airport-code">
						<select class="select select-ghost w-full max-w-xs">
							<option>부산</option>
							<option>김천</option>
							<option>나주</option>
							<option>남원</option>
							<option>남춘천</option>
							<option>대구</option>
							<option>대천</option>
							<option>동해</option>
							<option>부전</option>
							<option>신탄진</option>
							<option>신창</option>
							<option>아산</option>
							<option>여천</option>
							<option>영동</option>
							<option>왜관</option>
							<option>원주</option>
							<option>익산</option>
							<option>인천</option>
							<option>정읍</option>
							<option>제천</option>
							<option>조치원</option>
							<option>천안</option>
							<option>춘천</option>
							<option>태화강</option>
							<option>평택</option>
							<option>홍성</option>
						</select>
					</div>
				</div>
			</div>
			<button class="search-date-text">5월 2일(목)</button>
			<select class="select select_people">
				<option>1명</option>
				<option>2명</option>
				<option>3명</option>
				<option>4명</option>
				<option>5명</option>
				<option>6명</option>
				<option>7명</option>
				<option>8명</option>
			</select>
			<button class="search-button btn">검색하기</button>
		</div>
	</header>
</div>

<div class="ticket_box">
	<c:if test="${not empty spanTexts}">
		<c:forEach var="spanText" items="${spanTexts}" varStatus="loop">
			<div class="outer-content-box">
				<div class="train-info-name">
					<div class="train-name">${spanText.trainName}${spanText.trainNum}</div>
				</div>
				<div class="train-time">
					<div class="outer-arrival-icon">
						<div class="departure">
							<div class="departure-text">출발 시간</div>
							<time class="departure-time">${spanText.departureTime}</time>
						</div>
						<span class="material-symbols-outlined arrow_icon">east</span>
						<div class="arrival">
							<div class="arrival-text">도착 시간</div>
							<time class="arrival-time">${spanText.arrivalTime}</time>
						</div>
						<button id="booking-btn${loop.index}" class="booking-btn btn">예매</button>
						<div class="class-label" id="class-label${loop.index}">
							<button class="class-general-label btn">일반실</button>
							<button class="class-special-label btn">특실</button>
						</div>
					</div>
					<div class="arrival-icon">소요 시간 ${spanText.travelTime}</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
</div>


<style>
.departure-time, .arrival-time {
	position: relative;
	color: #24262c;
	margin-top: 20px;
	width: 200px;
	font-size: 20px;
	left: 10px;
}

.arrow_icon {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	position: relative;
	left: 280px;
}

.booking-btn {
	position: relative;
	display: flex;
	width: 75px;
	height: 50px;
	left: 470px;
	font-size: 16px;
	color: white;
	background-color: #00256C;
	border-radius: 37px;
	justify-content: center;
	align-items: center;
}

.train-time {
	position: relative;
	top: 17px;
}

.train-class {
	position: relative;
	display: flex;
	top: 18px;
	font-size: 15px;
	display: flex;
}

.departure, .arrival {
	position: relative;
	width: 100px;
	height: 80px;
	left: 200px;
	top: 30px;
}

.arrival {
	margin-left: 200px;
}

.arrival-icon {
	position: relative;
	top: -35px;
	left: 10px;
	width: 190px;
	height: 30px;
	color: #525252;
	font-size: 14px;
	/* 	border: 3px solid blue; */
}

.class-label {
	display: none; /* 처음에 숨겨져 있음 */
	position: absolute;
	left: 750px;
	top: 0;
}

#class-label1 {
	top: 0;
	left: 750px;
}

.class-label button {
	display: block; /* Make buttons display as block elements */
	width: 100px; /* Set width of buttons */
	margin-top: 15px;
	color: white;
	background-color: #5168A4;
	border-radius: 23px;
}

.show {
	display: block; /* 'show' 클래스가 추가될 때 보이도록 함 */
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
		url('https://velog.velcdn.com/images/vrslxowe/post/20b2f61b-15a7-4b21-8d0a-71a03a83d097/image.jpg')
		no-repeat;
	background-size: cover;
}

.outer-content-box {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	width: 1000px;
	height: 200px;
	flex-direction: column; /* 요소들을 세로로 배치합니다. */
}

.train-info-name {
	display: flex;
	flex-direction: column;
	/* 	border: 3px solid red; */
}

/* @media ( max-width : 991px) {
	.train-info-name {
		white-space: initial;
	}
} */
.train-name {
	border-radius: 5px;
	background-color: #B6CCF4;
	color: black;
	justify-content: center;
	padding: 6px 12px;
	font-size: 14px;
}

/* @media ( max-width : 991px) {
	.train-name {
		white-space: initial;
	}
}
 */
.outer-arrival-icon {
	/* 	border: 3px solid blue; */
	display: flex;
	align-items: end;
}
</style>

<%@ include file="../common/foot.jspf"%>
