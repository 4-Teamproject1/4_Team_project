<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Recommend List"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css">


<script>
	document.addEventListener("DOMContentLoaded", function() {
		const cityBox = document.querySelector('.city_box');
		const popup = document.createElement('div');
		popup.classList.add('popup');

		// 도시 목록
		const areas = [ "강릉", "대구", "대전", "목포", "부산", "서울", "속초", "수원", "여수",
				"전주", "제주", "청주", "포천", "인천" ];

		areas.forEach(function(area) {
			const areaElement = document.createElement('div');
			areaElement.textContent = area;
			areaElement.classList.add('area');
			areaElement.addEventListener('click', function() {
				cityBox.value = area; // 선택된 도시로 입력 필드 값 설정
				popup.style.display = 'none'; // 지역을 선택한 후 팝업 숨김
			});
			popup.appendChild(areaElement);
		});

		cityBox.addEventListener('click', function(event) {
			event.stopPropagation(); // 클릭 이벤트가 문서 본문으로 전파되지 않도록 함
			popup.style.display = 'block';
		});

		popup.addEventListener('click', function(event) {
			event.stopPropagation(); // 클릭 이벤트가 문서 본문으로 전파되지 않도록 함
		});

		document.body.appendChild(popup);

		// 팝업 창 외부를 클릭하면 팝업 창이 닫히도록 처리
		document.addEventListener('click', function(event) {
			if (!popup.contains(event.target)) {
				popup.style.display = 'none';
			}
		});

		// form 제출 시 input 값을 설정
		document.querySelector('.btn_sort_bar').addEventListener('click',
				function(event) {
					document.querySelector('.city_box').value = cityBox.value;
				});
	});

	$(document).ready(function() {
		// date_start_btn 버튼을 클릭할 때의 동작 설정
		$("#date_start_btn").click(function() {
			// jQuery UI의 DatePicker를 활성화하고 설정
			$("#datepicker").datepicker({
				dateFormat : 'yy년 mm월 dd일',
				onSelect : function(dateText, inst) {
					// 선택한 날짜를 텍스트 입력란에 넣음
					$(".city_box").val(dateText);
				}
			});
			// 달력 표시
			$("#datepicker").datepicker("show");
		});
	});
</script>


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

<div class="outer-box">
	<div class="searchClickBox">
		<div class="container">

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
			<div class="left_box">
				<div class="search-container">
					<input type="text" class="search-text" placeholder="텍스트 검색">
				</div>

				<p class="accommodation-type">1박당 요금</p>

				<div class="slidecontainer">
					<div>
						<input type="range" min="0" max="1000000" value="0" class="slider" id="range">
					</div>
					<span>
						Min:
						<span id="minValue">0</span>
					</span>
					<span>
						Max:
						<input type="number" id="maxValue" value="1000000">
					</span>
				</div>


				<div class="accommodation-type">숙소 성급 기준</div>

				<div class="accommodation-list">
					<div class="accommodation-item">
						<div class="accommodation-option">
							<input type="checkbox" class="checkbox" id="number5" />
							<div class="accommodation-name">
								<div class="image-wrapper1">
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/c00140c5f4f915eecc6c973c5c54957a44fc3d09424f81da67aca0727c78a993?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="" class="image" />
								</div>
							</div>
						</div>
					</div>

					<div class="accommodation-item">
						<div class="accommodation-option">
							<input type="checkbox" class="checkbox" id="number4" />
							<div class="accommodation-name">
								<div class="image-wrapper2">
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/34f34578e4a29f61e50fb63dde5e2e72c599f1b34d735cc947a59d062c58be01?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="Decorative image" class="decorative-image" />
								</div>

							</div>
						</div>
					</div>

					<div class="accommodation-item">
						<div class="accommodation-option">
							<input type="checkbox" class="checkbox" id="number3" />
							<div class="image-container">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/79f9ed25195baf775e5e8e5a32e99f36f5135d9d0822bb57a29e8c51c1ce1926?apiKey=f834c4360ac549c5b5237c00b19938c4&"
									alt="Product Image" class="product-image" loading="lazy" />
							</div>
						</div>
					</div>

					<div class="accommodation-item">
						<div class="accommodation-option">
							<input type="checkbox" class="checkbox" id="number2" />
							<div class="accommodation-name">
								<div class="image-wrapper4">
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/5625a76d5b98a0b8fb761b56091791718e2e83d4e9eac1e7ebd3caf630c798ad?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="Decorative image" class="image" />
								</div>
							</div>
						</div>
					</div>
					<div class="accommodation-item">
						<div class="accommodation-option">
							<input type="checkbox" class="checkbox" id="number1" />
							<div class="accommodation-name">
								<div class="image-wrapper5">
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/e97d2a18dce70cbe646949b2afc52ad3e640111a2c9f908c36e467de6f7b6ecd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="" class="image" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>

	<div class="outer-content-box">
		<div class="sort_bar">

			<form action="../hotel/searchList">
				<input class="city_box" type="text" placeholder="어디로 떠나시나요?" name="area" autocomplete="off">


				<div id="date_start_btn" class="date_start">
					<div style="text-align: center;">2024년 5월 12일</div>
					<div style="text-align: center;">금요일</div>
				</div>
				<div class="date_end">
					<div style="text-align: center;">2024년 5월 15일</div>
					<div style="text-align: center;">토요일</div>
				</div>
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
				<button class="btn_sort_bar btn" type="submit">검색하기</button>
			</form>

		</div>
		<div class="hotel-card">
			<c:forEach items="${hotelList}" var="hotel">
				<a href="${hotel.href }" class="hotel-link">
					<div class="hotel-card-content number${hotel.grade }">
						<div class="hotel-info">
							<div class="hotel-info-content">
								<div class="hotel-imageANDdetail">

									<div class="main-image-container">

										<div class="main-image">
											<img class="hotel-img" src="${hotel.imgUrl }" alt="Main hotel image" />
										</div>

									</div>
									<div class="hotel-details">
										<div class="hotel-name">${hotel.hotelName }</div>
										<div class="hotel-grade">
											<c:choose>
												<c:when test="${hotel.grade == 5}">
													<img id="image1" class="star-score"
														src="https://cdn.builder.io/api/v1/image/assets/TEMP/c00140c5f4f915eecc6c973c5c54957a44fc3d09424f81da67aca0727c78a993?apiKey=f834c4360ac549c5b5237c00b19938c4&"
														alt="star" />
												</c:when>
												<c:when test="${hotel.grade == 4}">
													<img id="image2" class="star-score"
														src="https://cdn.builder.io/api/v1/image/assets/TEMP/34f34578e4a29f61e50fb63dde5e2e72c599f1b34d735cc947a59d062c58be01?apiKey=f834c4360ac549c5b5237c00b19938c4&"
														alt="star" />
												</c:when>
												<c:when test="${hotel.grade == 3}">
													<img id="image3" class="star-score"
														src="https://cdn.builder.io/api/v1/image/assets/TEMP/79f9ed25195baf775e5e8e5a32e99f36f5135d9d0822bb57a29e8c51c1ce1926?apiKey=f834c4360ac549c5b5237c00b19938c4&"
														alt="star" />
												</c:when>
												<c:when test="${hotel.grade == 2}">
													<img id="image4" class="star-score"
														src="https://cdn.builder.io/api/v1/image/assets/TEMP/5625a76d5b98a0b8fb761b56091791718e2e83d4e9eac1e7ebd3caf630c798ad?apiKey=f834c4360ac549c5b5237c00b19938c4&"
														alt="star" />
												</c:when>
												<c:when test="${hotel.grade == 1}">
													<img id="image5" class="star-score"
														src="https://cdn.builder.io/api/v1/image/assets/TEMP/e97d2a18dce70cbe646949b2afc52ad3e640111a2c9f908c36e467de6f7b6ecd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
														alt="star" />
												</c:when>
											</c:choose>
										</div>
										<div class="hotel-service">
											<div class="services">숙소 제공사항</div>
											<div class="service-name">${hotel.service}</div>
										</div>
									</div>

								</div>
							</div>
						</div>

						<div class="hotel-rating-price">
							<div class="hotel-rating">

								<div class="hotel-rating-details">
									<div class="hotel-price">
										<div class="hotel-price-details">1박당 요금</div>
										<div class="hotel-price-value">KRW ${hotel.price }</div>
									</div>

								</div>
							</div>
						</div>
					</div>
				</a>
				<div class="empty-place"></div>
			</c:forEach>
		</div>
	</div>
</div>

<style>
.popup {
	position: absolute;
	top: 34%;
	left: 29%;
	width: 660px;
	height: 185px;
	background-color: white;
	border-radius: 17px;
	padding: 10px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
	z-index: 10;
	display: none;
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

.city_box, .people_sort_bar, .btn_sort_bar {
	position: relative;
	height: 60px;
	border-radius: 17px;
	background-color: #edf0f9;
}

.city_box {
	left: -20px;
	width: 350px;
	padding-left: 30px;
}

.date_start, .date_end {
	position: relative;
	display: inline-block;
	left: -10px;
	width: 150px;
	height: 60px;
	background-color: #edf0f9;
}

.date_start {
	border-right: 1px solid #cbd5e0;
	border-radius: 17px 0 0 17px;
}

.date_end {
	border-left: 1px solid #cbd5e0;
	border-radius: 0 17px 17px 0;
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
	top: 250px;
	width: 1000px;
	height: 70px;
	font-size: 16px;
	border-radius: 21px;
	border: 1px solid rgba(221, 223, 226, 1);
	background-color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
}

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

/* 호텔 리스트 css */
.outer-content-box {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	width: 100%;
	height: 100%;
	flex-direction: column; /* 요소들을 세로로 배치합니다. */
}

.hotel-imageANDdetail {
	display: flex;
	gap: 20px;
	border-right: solid 1px black;
}

.hotel-img {
	border-radius: 10px;
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
		url('https://velog.velcdn.com/images/vrslxowe/post/e1d7ffad-a877-4c82-a7db-48f8b3de695b/image.jpg')
		no-repeat;
	background-size: cover;
}

.left_box {
	position: relative;
	top: 240px;
}

/* 왼쪽 서치박스 css */
.list-container {
	display: flex;
	position: relative;
	top: 220px;
	left: 30px;
}

/* 슬라이드 바 css */
.accommodation-type {
	margin: 28px 0 0 21px;
	font: 700 14px/143% Inter, sans-serif;
}

.slidecontainer {
	width: 300px;
}

.slider {
	width: 260px;
}

.slider:hover {
	opacity: 1;
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
	width: 150px;
	height: 120px;
	color: black;
	list-style: none;
	padding-top: 1px;
	border-top: 2px solid #cbd5e0;
	border-bottom: 2px solid #cbd5e0;
	position: absolute; /* Change from relative to absolute */
	top: -70px; /* Align with the top of the dropdown button */
	left: 100%; /* Position it to the right of the button */
	background-color: white; /* Add background color */
}

.dropdown-content li {
	padding: 7px;
	text-align: center;
}

.dropdown:hover .dropdown-content {
	display: block;
}

.hotel-card {
	position: relative;
	top: 300px;
	justify-content: center;
	border-radius: 8px;
	box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
	background-color: rgba(255, 255, 255, 0);
	max-width: 965px;
	justify-content: center;
	justify-content: center;
}

.hotel-card-content {
	display: flex;
	border: solid 1px black;
	margin-top: 15px;
	border-radius: 10px;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.4);
	/* 수평 위치, 수직 위치, 흐림 정도, 색상 */
	background-color: ffffff;
	box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.4);
	margin-top: 30px;
}

.hotel-info {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 80%;
	margin-left: 0;
}

.hotel-info-content {
	flex-grow: 1;
}

.hotel-images {
	display: flex;
	gap: 20px;
}

.main-image-container {
	display: flex;
	line-height: normal;
	border-radius: 20px;
}

.main-image-wrapper {
	display: flex;
	flex-grow: 1;
	flex-direction: column;
}

.main-image {
	display: flex;
	flex-direction: column;
	overflow: hidden;
	position: relative;
	aspect-ratio: 1.5;
	align-items: end;
	width: 330px;
	height: 280px;
}

.main-image img {
	position: absolute;
	inset: 0;
	height: 100%;
	width: 100%;
	object-fit: cover;
	object-position: center;
}

.main-image-overlay {
	aspect-ratio: 1;
	object-fit: auto;
	object-position: center;
	width: 40px;
	margin-bottom: 24px;
}

/* 왼쪽 바 css */
.thumbnail-images {
	display: flex;
	gap: 1px;
	font-size: 12px;
	color: #fff;
	font-weight: 400;
	text-align: center;
	line-height: 110%;
	padding: 0 20px;
}

.thumbnail-image {
	aspect-ratio: 1.67;
	object-fit: auto;
	object-position: center;
	width: 67px;
}

.thumbnail-image-more {
	display: flex;
	flex-direction: column;
	overflow: hidden;
	position: relative;
	aspect-ratio: 1.7;
	width: 68px;
	justify-content: center;
}

.thumbnail-image-more-text {
	position: relative;
	font-family: Inter, sans-serif;
	justify-content: center;
	background-color: rgba(0, 0, 0, 0.7);
	padding: 15px 11px;
}

.hotel-details {
	display: flex;
	flex-direction: column;
	line-height: normal;
}

.hotel-name {
	margin-top: 50px;
	color: #24262c;
	line-height: 125%;
	font-size: 20px;
	margin-right: 50px;
	font-weight: bold;
	font: sans-serif;
	width: 400px;
}

.hotel-name-text {
	font: 20px/120% Inter, sans-serif;
}

.hotel-location {
	display: flex;
	margin-top: 5px;
	align-items: start;
	gap: 4px;
	color: #3170e7;
}

.hotel-location-icon {
	aspect-ratio: 2.78;
	object-fit: auto;
	object-position: center;
	width: 56px;
}

.hotel-location-text {
	font-family: Inter, sans-serif;
	align-self: stretch;
	flex-grow: 1;
	flex-basis: auto;
}

.hotel-amenities-title {
	margin-top: 9px;
	font: 400 14px/130% Inter, sans-serif;
}

.hotel-amenities {
	display: flex;
	margin-top: 6px;
	gap: 4px;
	font-weight: 400;
	text-align: center;
}

.hotel-amenity {
	font-family: Inter, sans-serif;
	justify-content: center;
	border-radius: 2px;
	border: 1px solid rgba(193, 203, 224, 1);
	padding: 6px 11px;
}

.hotel-popularity {
	display: flex;
	margin-top: 13px;
	gap: 4px;
	color: #e03126;
	font-weight: 400;
}

.hotel-popularity-icon {
	aspect-ratio: 1;
	object-fit: auto;
	object-position: center;
	width: 14px;
}

.hotel-popularity-text {
	font-family: Inter, sans-serif;
	flex-grow: 1;
	flex-basis: auto;
}

.hotel-rating-price {
	display: flex;
	flex-direction: column;
	line-height: normal;
	margin-top: 100px;
	width: 300px;
}

.hotel-rating {
	display: flex;
	align-items: start;
	gap: 1px;
	align-self: stretch;
	text-align: right;
	margin: auto 0;
	width: 190px;
	justify-content: center;
}

.hotel-rating-icon {
	aspect-ratio: 1;
	object-fit: auto;
	object-position: center;
	width: 32px;
}

.hotel-rating-details {
	display: flex;
	margin-top: 4px;
	flex-direction: column;
	width: 180px;
}

.hotel-rating-score {
	align-self: end;
	display: flex;
	gap: 16px;
	white-space: nowrap;
}

.hotel-rating-text {
	color: #2a2a2e;
	font: 500 14px/143% Inter, sans-serif;
}

.hotel-rating-value {
	color: #fff;
	font: 400 13px/104% Inter, sans-serif;
}

.hotel-reviews {
	color: #707070;
	font: 400 12px/133% Inter, sans-serif;
}

.hotel-price {
	display: flex;
	margin-top: 59px;
	flex-direction: column;
	align-items: end;
	font-weight: 400;
	width: 180px;
}

.hotel-discount {
	justify-content: center;
	border-radius: 2px;
	background-color: #e03126;
	align-self: stretch;
	color: #fff;
	text-align: center;
	padding: 5px 10px;
	font: 12px/125% Inter, sans-serif;
}

.hotel-price-details {
	color: black;
	align-self: stretch;
	margin-top: 6px;
	font: 500 10px/140% Inter, sans-serif;
}

.hotel-original-price {
	color: #6b7388;
	text-decoration: line-through;
	margin-top: 8px;
	font: 11px/138% Inter, sans-serif;
}

.hotel-discounted-price {
	display: flex;
	margin-top: 13px;
	gap: 6px;
	color: #e03126;
	font-weight: 600;
	white-space: nowrap;
}

.hotel-price-currency {
	margin: auto 0;
	font: 12px/125% Inter, sans-serif;
}

.hotel-price-value {
	font: 20px/129% Inter, sans-serif;
	color: red;
}

.hotel-free-cancellation {
	color: #28871c;
	margin-top: 5px;
	font: 500 12px/133% Inter, sans-serif;
}

.outer-box {
	width: 100%;
	display: flex;
}

.accommodation-nav {
	/* 	background-color: #f9b563; */
	display: flex;
	max-width: 557px;
	align-items: center;
	font-size: 17px;
	color: #2a2a2e;
	font-weight: 500;
	justify-content: center;
	padding: 7px 60px;
}

.container {
	background-color: #fff;
	display: flex;
	flex-direction: column;
	align-items: start;
	color: #5a5b5b;
	font-weight: 400;
	padding: 30px 80px 80px 33px;
}

.header {
	align-self: stretch;
	display: flex;
	width: 100%;
	gap: 20px;
	color: #000;
	justify-content: space-between;
}

.logo {
	text-align: center;
	font: 23px Exo 2, sans-serif;
}

.user-info {
	display: flex;
	gap: 20px;
	font-size: 19px;
	justify-content: space-between;
}

.username {
	font-family: Inter, sans-serif;
}

.society-info, .inquiries, .logout {
	font-family: Inter, sans-serif;
}

.search-container {
	position: relative;
	justify-content: center;
	align-items: start;
	border-radius: 18px;
	border: 1px solid rgba(115, 115, 115, 1);
	background-color: #f8f7f9;
	display: flex;
	width: 263px;
	max-width: 100%;
	flex-direction: column;
	font-size: 14px;
	color: #737373;
	padding: 12px 38px;
}

.search-text {
	background-color: #f8f7f9;
}

.search-text {
	justify-content: center;
}

.accommodation-type {
	margin: 28px 0 0 21px;
	font-size: 14px
}

.accommodation-list {
	position: relative;
	display: flex;
	width: 247px;
	max-width: 100%;
	flex-direction: column;
	font-size: 12px;
	line-height: 180%;
	justify-content: center;
	margin: 18px 0 0 21px;
	padding: 4px 0;
}

.accommodation-item {
	justify-content: center;
	display: flex;
	flex-direction: column;
	padding: 4px 0;
}

.accommodation-option {
	display: flex;
	gap: 10px;
}

.checkbox {
	border-radius: 2px;
	border: 1px solid rgba(232, 232, 232, 1);
	background-color: #fff;
	width: 16px;
	height: 16px;
}

.accommodation-name {
	font-family: Inter, sans-serif;
	flex-grow: 1;
	flex-basis: auto;
	margin: auto 0;
}

/* 성급 기준*/
.image-wrapper1 {
	display: flex;
	max-width: 75px;
	flex-direction: column;
	justify-content: center;
}

.image {
	aspect-ratio: 5.88;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.star_image {
	display: flex;
	max-width: 59px;
	flex-direction: column;
	justify-content: center;
}

.star_image>.image {
	aspect-ratio: 4.55;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.image-container {
	width: 100%;
	max-width: 43px;
}

.product-image {
	aspect-ratio: 3.33;
	object-fit: auto;
	object-position: center;
	width: 100%;
	fill: #ffa726;
}

.image-wrapper4 {
	display: flex;
	max-width: 28px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper4>.image {
	aspect-ratio: 2.33;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.image-wrapper5 {
	display: flex;
	max-width: 13px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper5>.image {
	aspect-ratio: 1;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.sort-criteria, .guest-rating, .lowest-price, .distance-container,
	.special-deal {
	flex-grow: 1;
	flex-basis: 0;
	width: 130px;
}

.sort-criteria {
	display: flex;
	gap: 0;
}

.sort-label {
	justify-content: center;
	align-items: start;
	border-radius: 7px 0 0 7px;
	border-right: 1px solid rgba(221, 223, 226, 1);
	background-color: #f8f7f9;
	color: #737373;
	padding: 16px;
}

.best-match {
	justify-content: center;
	background-color: #f9b563;
	color: #fff;
	text-align: center;
	padding: 16px 41px;
}

.divider {
	background-color: #dddfe2;
	width: 1px;
	height: 30px;
	margin: auto 0;
}

.guest-rating, .lowest-price {
	color: #2a2a2e;
	text-align: center;
	align-self: stretch;
	margin: auto 0;
}

.distance-container {
	align-self: stretch;
	display: flex;
	gap: 0;
	color: #2a2a2e;
	white-space: nowrap;
	text-align: center;
	margin: auto 0;
}

.distance-image-wrapper {
	display: flex;
	flex-direction: column;
	position: relative;
	overflow: hidden;
	z-index: 10;
	aspect-ratio: 3.54;
	justify-content: center;
	margin: auto 0;
}

.distance-image {
	position: absolute;
	inset: 0;
	height: 100%;
	width: 100%;
	object-fit: cover;
	object-position: center;
}

.special-deal {
	color: #2a2a2e;
	text-align: center;
	font-family: Inter, sans-serif;
	align-self: stretch;
	flex-grow: 1;
	flex-basis: auto;
	margin: auto 0;
}

@media ( max-width : 991px) {
	.hotel-card-content {
		flex-direction: column;
		align-items: stretch;
		gap: 0;
	}
}

@media ( max-width : 991px) {
	.hotel-info {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.hotel-info-content {
		max-width: 100%;
		margin-top: 40px;
	}
}

@media ( max-width : 991px) {
	.hotel-images {
		flex-direction: column;
		align-items: stretch;
		gap: 0;
	}
}

@media ( max-width : 991px) {
	.main-image-container {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.main-image {
		padding-left: 20px;
	}
}

@media ( max-width : 991px) {
	.hotel-details {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.hotel-name {
		padding-right: 20px;
	}
}

@media ( max-width : 991px) {
	.hotel-amenities {
		padding-right: 20px;
	}
}

@media ( max-width : 991px) {
	.hotel-amenity {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.hotel-rating-price {
		width: 100%;
	}
}

@media ( max-width : 991px) {
	.hotel-rating {
		margin-top: 40px;
	}
}

@media ( max-width : 991px) {
	.hotel-rating-score {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.hotel-price {
		margin-top: 40px;
	}
}

@media ( max-width : 991px) {
	.hotel-discounted-price {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.accommodation-nav {
		padding: 0 20px;
	}
}

@media ( max-width : 991px) {
	.container {
		padding: 0 20px;
	}
}

@media ( max-width : 991px) {
	.header {
		max-width: 100%;
		margin-right: 10px;
		flex-wrap: wrap;
	}
}

@media ( max-width : 991px) {
	.search-container {
		margin: 40px 0 0 10px;
		padding: 0 20px;
	}
}

@media ( max-width : 991px) {
	.accommodation-type {
		margin-left: 10px;
	}
}

@media ( max-width : 991px) {
	.accommodation-list {
		margin-left: 10px;
	}
}

@media ( max-width : 991px) {
	.container {
		flex-wrap: wrap;
	}
}

@media ( max-width : 991px) {
	.distance-container {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.distance-image-wrapper {
		white-space: initial;
	}
}
</style>


<script>
	//검색 문자가 포함된 호텔요소 찾기
	// input 요소 가져오기
	var searchText = document.querySelector('.search-text');

	// input 값이 변경될 때 호출되는 함수
	searchText.addEventListener('input', function() {
		// 입력된 검색어
		var searchKeyword = this.value.toLowerCase().trim();

		// 모든 호텔 요소 가져오기
		var hotelList = document.querySelectorAll('.hotel-card-content');

		// 각 호텔 요소에 대해 반복
		hotelList.forEach(function(hotel) {
			// 호텔 이름 요소 가져오기
			var hotelNameElement = hotel.querySelector('.hotel-name');
			// 호텔 이름
			var hotelName = hotelNameElement.textContent.toLowerCase();

			// 호텔 이름에 검색어가 포함되어 있는 경우
			if (hotelName.includes(searchKeyword)) {
				// 해당 호텔 요소를 보이도록 설정
				hotel.style.display = 'flex';
			} else {
				// 검색어가 포함되어 있지 않은 경우 해당 호텔 요소를 숨김
				hotel.style.display = 'none';
			}
		});
	});

	//슬라이드 바 
	var slider = document.getElementById("range");
	var minValue = document.getElementById("minValue");
	var maxValue = document.getElementById("maxValue");

	// 초기 설정
	minValue.innerHTML = slider.min;
	maxValue.value = slider.max;

	slider.oninput = function() {
		minValue.innerHTML = this.min;
		this.style.setProperty('--slider-value',
				(this.value / (this.max - this.min)) * 100 + '%');
	}

	maxValue.addEventListener('input', function() {
		// maxValue가 1000000을 넘지 않도록 제한
		if (parseInt(this.value) > parseInt(slider.max)) {
			this.value = slider.max;
		}
		slider.value = this.value;
		slider.dispatchEvent(new Event('input'));
	});

	// JavaScript 코드

	document.addEventListener('DOMContentLoaded', function() {
		// 모든 체크박스 요소를 가져옵니다.
		var checkboxes = document.querySelectorAll('.checkbox');

		checkboxes.forEach(function(checkbox) {
			checkbox.addEventListener('change', function() {
				// 현재 선택된 체크박스의 id를 가져옵니다.
				var id = this.id;

				// 다른 체크박스를 해제합니다.
				checkboxes.forEach(function(otherCheckbox) {
					if (otherCheckbox !== checkbox) {
						otherCheckbox.checked = false;
					}
				});

				// 모든 요소를 보이게 설정합니다.
				var elementsToShow = document
						.querySelectorAll('.hotel-card-content');
				elementsToShow.forEach(function(element) {
					element.style.visibility = 'visible';
					element.style.display = 'flex';
				});

				// 선택된 체크박스 이외의 요소들을 숨깁니다.
				if (this.checked) {
					var elementsToHide = document
							.querySelectorAll('.hotel-card-content:not(.' + id
									+ ')');
					elementsToHide.forEach(function(element) {
						element.style.visibility = 'hidden';
						element.style.display = 'none';
					});
				}
			});
		});
	});
	// 슬라이드 바 값이 변경될 때 호출되는 함수
	slider.addEventListener("input", function() {
		// 슬라이드 바의 현재 값
		var sliderValue = parseInt(this.value);

		// 인풋에 슬라이드 바의 값 업데이트
		maxValue.value = sliderValue;

		// 모든 호텔 요소 가져오기
		var hotelList = document.getElementsByClassName("hotel-card-content");

		// 각 호텔 요소에 대해 반복
		for (var i = 0; i < hotelList.length; i++) {
			// 호텔 가격 요소 가져오기
			var priceElement = hotelList[i]
					.getElementsByClassName("hotel-price-value")[0];
			// 호텔 가격 값
			var hotelPrice = parseInt(priceElement.textContent);

			// 호텔 가격이 슬라이드 바 값보다 작은 경우
			if (hotelPrice >= sliderValue) {
				// 해당 호텔을 화면에서 숨김
				hotelList[i].style.display = "none";
			} else {
				// 해당 호텔을 화면에 보이도록 설정
				hotelList[i].style.display = "flex";
			}
		}
	});
</script>

<%@ include file="../common/foot.jspf"%>