<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Recommend List"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<header class="header">
	<div class="logo">로고</div>
	<div class="user-info">
		<span class="username"> <span class="black-text">abc123</span> <span class="black-text">님</span>
		</span>
		<div class="society-info">학회정보</div>
		<div class="inquiries">문의사항</div>
		<div class="logout">로그아웃</div>
	</div>
</header>
<div class="outer-box">
	<div class="searchClickBox">
		<div class="container">

			<div class="search-container">
				<input type="text" class="search-text" placeholder="텍스트 검색">
			</div>

			<div class="accommodation-type">숙소 종류</div>

			<div class="accommodation-list">
				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">아파트먼트 (50)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">서비스 아파트먼트 (4)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">호텔 (51)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">게스트하우스 / 비앤비 (5)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">모텔 (66)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">호스텔 (2)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">펜션 (9)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">프라이빗 하우스 (21)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">프라이빗 빌라 (4)</div>
					</div>
				</div>
			</div>

			<div class="accommodation-type">숙소 거리 기준</div>

			<div class="accommodation-list">
				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">역 근거리 기준 (50)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">버스정류장 근거리 기준 (4)</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">터미널 근거리 기준 (51)</div>
					</div>
				</div>

			</div>

			<div class="accommodation-type">숙소 성급 기준</div>

			<div class="accommodation-list">
				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">
							<div class="image-wrapper1">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/c00140c5f4f915eecc6c973c5c54957a44fc3d09424f81da67aca0727c78a993?apiKey=f834c4360ac549c5b5237c00b19938c4&"
									alt="" class="image" /> (50)
							</div>
						</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">
							<div class="image-wrapper2">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/34f34578e4a29f61e50fb63dde5e2e72c599f1b34d735cc947a59d062c58be01?apiKey=f834c4360ac549c5b5237c00b19938c4&"
									alt="Decorative image" class="decorative-image" />
							</div>
							(4)
						</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="image-container">
							<img
								src="https://cdn.builder.io/api/v1/image/assets/TEMP/79f9ed25195baf775e5e8e5a32e99f36f5135d9d0822bb57a29e8c51c1ce1926?apiKey=f834c4360ac549c5b5237c00b19938c4&"
								alt="Product Image" class="product-image" loading="lazy" /> (4)
						</div>
					</div>
				</div>

				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">
							<div class="image-wrapper4">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/5625a76d5b98a0b8fb761b56091791718e2e83d4e9eac1e7ebd3caf630c798ad?apiKey=f834c4360ac549c5b5237c00b19938c4&"
									alt="Decorative image" class="image" /> (51)
							</div>
						</div>
					</div>
				</div>
				<div class="accommodation-item">
					<div class="accommodation-option">
						<input type="checkbox" class="checkbox" />
						<div class="accommodation-name">
							<div class="image-wrapper5">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/e97d2a18dce70cbe646949b2afc52ad3e640111a2c9f908c36e467de6f7b6ecd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
									alt="" class="image" /> (51)
							</div>
						</div>
					</div>
				</div>
			</div>



		</div>
	</div>




	<div>
		<div class="outer-searchBox">
			<div class="searchBox1">
				<nav class="accommodation-nav">
					<ul class="accommodation-nav-list">

						<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">숙소</div>
						<div class="dropdown">
							<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
							<ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
								<li><a href="../article/recommendAirplaneList">항공</a></li>

								<li><a href="../article/recommendTrainList">기차</a></li>
								<li><a href="../article/recommendBusList">버스</a></li>
							</ul>
						</div>

					</ul>
				</nav>
			</div>

			<div class="searchBox2">
				<div class="container2">
					<div class="box1">
						<div class="sort-criteria">
							<div class="sort-label">정렬 기준</div>
							<div class="best-match">BEST 매치</div>
							<div class="divider"></div>
						</div>
					</div>
					<div class="box2">
						<div class="guest-rating">투숙객 평점순</div>
						<div class="lowest-price">낮은 요금 먼저</div>

						<div class="special-deal">초특가 상품!</div>
					</div>

				</div>
			</div>
		</div>



		<div class="outer-content-box">
			<div class="hotel-card">
				<div class="hotel-card-content">
					<div class="hotel-info">
						<div class="hotel-info-content">
							<div class="hotel-images">
								<div class="main-image-container">
									<div class="main-image-wrapper">
										<div class="main-image">
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/0269ff624f7164c7efb1603b2d706bf08a3def40cdb6fefbb47a0d9c037ee81b?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="Main hotel image" />

										</div>

									</div>
								</div>
								<div class="hotel-details">
									<div class="hotel-name">
										<div class="hotel-name-text">엘디스 리젠트 호텔 (Eldis Regent</div>
										<div class="hotel-name-text">Hotel)</div>
										<div class="hotel-location">
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/6bf923710bd513aeca2a5aedf434ab4ab9075b0725f987c0a6192f40623e31af?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" class="hotel-location-icon" /> <img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/b7f976c6a5f12fe8e38e626913755498f0e8896d59b84c7c5973be1170c3a4dd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" class="hotel-location-icon" />
											<div class="hotel-location-text">대구시내, 대구 - 도심에 위치</div>
										</div>
										<div class="hotel-amenities-title">숙소 제공 사항</div>
										<div class="hotel-amenities">
											<div class="hotel-amenity">조식</div>
											<div class="hotel-amenity">피트니스 센터</div>
											<div class="hotel-amenity">주차</div>
											<div class="hotel-amenity">무료 Wi-Fi</div>
										</div>
										<div class="hotel-popularity">
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/b7dd0252b796495ed29789b677c69d764fecfd53da152aef74b9c5441d2560ff?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" class="hotel-popularity-icon" />
											<div class="hotel-popularity-text">현재 인기 2시간 전 예약됨</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="hotel-rating-price">
						<div class="hotel-rating">
							<img
								src="https://cdn.builder.io/api/v1/image/assets/TEMP/18d8990427cc7ac525aa734abaaf3e6853634987e2662880d8927c29267db16b?apiKey=f834c4360ac549c5b5237c00b19938c4&"
								alt="" class="hotel-rating-icon" />
							<div class="hotel-rating-details">
								<div class="hotel-rating-score">
									<div class="hotel-rating-text">우수</div>
									<div class="hotel-rating-value">8.2</div>
								</div>
								<div class="hotel-reviews">3,962 건의 이용후기</div>
								<div class="hotel-price">
									<div class="hotel-discount">* TODAY * 57% 할인</div>
									<div class="hotel-price-details">1박당 요금(세금 및 봉사료 제외)</div>
									<div class="hotel-original-price">192,941</div>
									<div class="hotel-discounted-price">
										<div class="hotel-price-currency">₩</div>
										<div class="hotel-price-value">82,645</div>
									</div>
									<div class="hotel-free-cancellation">+ 예약 무료 취소</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

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

.hotel-card {
	justify-content: center;
	border-radius: 8px;
	box-shadow: 0 2px 2px 0 rgba(0, 0, 0, 0.12);
	border: 1px solid rgba(221, 223, 226, 1);
	background-color: rgba(255, 255, 255, 0);
	max-width: 965px;
	padding-right: 9px;
}

.hotel-card-content {
	display: flex;
	gap: 20px;
}

@media ( max-width : 991px) {
	.hotel-card-content {
		flex-direction: column;
		align-items: stretch;
		gap: 0;
	}
}

.hotel-info {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 80%;
	margin-left: 0;
}

@media ( max-width : 991px) {
	.hotel-info {
		width: 100%;
	}
}

.hotel-info-content {
	flex-grow: 1;
}

@media ( max-width : 991px) {
	.hotel-info-content {
		max-width: 100%;
		margin-top: 40px;
	}
}

.hotel-images {
	display: flex;
	gap: 20px;
}

 @media ( max-width : 991px) {
	.hotel-images {
		flex-direction: column;
		align-items: stretch;
		gap: 0;
	}
} 

.main-image-container {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 44%;
	margin-left: 0;
}

@media ( max-width : 991px) {
	.main-image-container {
		width: 100%;
	}
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
	width: 100%;
	align-items: end;
	padding: 12px 60px 80px;
	margin-left: 10px;
	margin-top: 5px;
	width: 300px;
	height: 250px;
}

@media ( max-width : 991px) {
	.main-image {
		padding-left: 20px;
	}
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
	width: 56%;
	margin-left: 20px;
}

@media ( max-width : 991px) {
	.hotel-details {
		width: 100%;
	}
}

.hotel-name {
	border-right: 1px solid rgba(221, 223, 226, 1);
	display: flex;
	flex-grow: 1;
	flex-direction: column;
	align-items: start;
	font-size: 12px;
	color: #24262c;
	font-weight: 600;
	line-height: 125%;
	padding: 14px 41px 60px 12px;
}

@media ( max-width : 991px) {
	.hotel-name {
		padding-right: 20px;
	}
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

@media ( max-width : 991px) {
	.hotel-amenities {
		padding-right: 20px;
	}
}

.hotel-amenity {
	font-family: Inter, sans-serif;
	justify-content: center;
	border-radius: 2px;
	border: 1px solid rgba(193, 203, 224, 1);
	padding: 6px 11px;
}

@media ( max-width : 991px) {
	.hotel-amenity {
		white-space: initial;
	}
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
	width: 20%;
	margin-left: 20px;
}

@media ( max-width : 991px) {
	.hotel-rating-price {
		width: 100%;
	}
}

.hotel-rating {
	display: flex;
	align-items: start;
	gap: 1px;
	align-self: stretch;
	text-align: right;
	margin: auto 0;
}

@media ( max-width : 991px) {
	.hotel-rating {
		margin-top: 40px;
	}
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
	padding: 0 20px;
}

.hotel-rating-score {
	align-self: end;
	display: flex;
	gap: 16px;
	white-space: nowrap;
}

@media ( max-width : 991px) {
	.hotel-rating-score {
		white-space: initial;
	}
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
	padding-left: 10px;
	flex-direction: column;
	align-items: end;
	font-weight: 400;
}

@media ( max-width : 991px) {
	.hotel-price {
		margin-top: 40px;
	}
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
	color: #90949c;
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

@media ( max-width : 991px) {
	.hotel-discounted-price {
		white-space: initial;
	}
}

.hotel-price-currency {
	margin: auto 0;
	font: 12px/125% Inter, sans-serif;
}

.hotel-price-value {
	font: 23px/129% Inter, sans-serif;
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

@media ( max-width : 991px) {
	.accommodation-nav {
		padding: 0 20px;
	}
}

.accommodation-nav-list {
	display: flex;
	width: 337px;
	max-width: 100%;
	align-items: center;
	gap: 20px;
	justify-content: space-between;
}

.accommodation-nav-divider {
	border: 1px solid rgba(0, 0, 0, 1);
	width: 1px;
	height: 46px;
}

.accommodation-nav-item {
	font-family: Inter, sans-serif;
	margin: auto 0;
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

@media ( max-width : 991px) {
	.container {
		padding: 0 20px;
	}
}

.header {
	align-self: stretch;
	display: flex;
	width: 100%;
	gap: 20px;
	color: #000;
	justify-content: space-between;
}

@media ( max-width : 991px) {
	.header {
		max-width: 100%;
		margin-right: 10px;
		flex-wrap: wrap;
	}
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
	margin: 176px 0 0 13px;
	padding: 12px 38px;
}

.search-text {
	background-color: #f8f7f9;
}

@media ( max-width : 991px) {
	.search-container {
		margin: 40px 0 0 10px;
		padding: 0 20px;
	}
}

.search-text {
	font-family: Inter, sans-serif;
	justify-content: center;
}

.accommodation-type {
	margin: 28px 0 0 21px;
	font: 700 14px/143% Inter, sans-serif;
}

@media ( max-width : 991px) {
	.accommodation-type {
		margin-left: 10px;
	}
}

.accommodation-list {
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

@media ( max-width : 991px) {
	.accommodation-list {
		margin-left: 10px;
	}
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

.image-wrapper2 {
	display: flex;
	max-width: 59px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper2>.image {
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

/* 중앙 주황 서치박스*/
.searchBox1 {
	width: 100%;
	height: 80px;
	display: flex;
	justify-content: center;
}

.accommodation-nav-list {
	display: flex;
	width: 837px;
	max-width: 100%;
	align-items: center;
	gap: 20px;
	justify-content: space-between;
}

.accommodation-nav-divider {
	border: 1px solid rgba(0, 0, 0, 1);
	width: 1px;
	height: 46px;
}

.accommodation-nav-item {
	font-family: Inter, sans-serif;
	width: 200px;
	margin: auto 0;
	background-color: #f9b563;
}

.outer-content-box {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	width: 100%;
	height: 400px;
	flex-direction: column; /* 요소들을 세로로 배치합니다. */
}

.outer-searchBox {
	display: flex;
	justify-content: center; /* 수평 가운데 정렬 */
	width: 100%;
	height: 200px;
	flex-direction: column; /* 요소들을 세로로 배치합니다. */
}

.searchClickBox {
	width: 400px;
	display: block;
}

/* 추천목록 중앙서치박스 */
.searchBox2 {
	width: 100%;
	height: 70px;
	display: flex;
	justify-content: center;
}

.container2 {
	width: 1500px;
	height: 50px;
	border-radius: 8px;
	border: 1px solid rgba(221, 223, 226, 1);
	justify-content: space-between; /* 원하는 정렬에 맞게 조정하세요 */
	background-color: #fff;
	display: flex;
	max-width: 965px;
	align-items: center;
	gap: 20px;
	font-size: 14px;
	font-weight: 500;
	line-height: 143%;
}

.container2>div {
	flex: 1; /* 각 하위 div가 동일한 너비를 가지도록 설정 */
	display: flex; /* 내부 요소를 가로로 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	gap: 20px; /* 각 요소 사이의 간격 */
	width: 700px;
}

/* 필요에 따라 너비 및 기타 스타일을 조정하세요 */
.sort-criteria, .guest-rating, .lowest-price, .distance-container,
	.special-deal {
	flex-grow: 1;
	flex-basis: 0;
	width: 130px;
	/* 원하는 스타일을 추가하세요 */
}

@media ( max-width : 991px) {
	.container {
		flex-wrap: wrap;
	}
}

.sort-criteria {
	display: flex;
	gap: 0;
}

.sort-label {
	font-family: Inter, sans-serif;
	justify-content: center;
	align-items: start;
	border-radius: 7px 0 0 7px;
	border-right: 1px solid rgba(221, 223, 226, 1);
	background-color: #f8f7f9;
	color: #737373;
	padding: 16px;
}

.best-match {
	font-family: Inter, sans-serif;
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
	font-family: Inter, sans-serif;
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

@media ( max-width : 991px) {
	.distance-container {
		white-space: initial;
	}
}

.distance-image-wrapper {
	display: flex;
	flex-direction: column;
	font-family: Inter, sans-serif;
	position: relative;
	overflow: hidden;
	z-index: 10;
	aspect-ratio: 3.54;
	justify-content: center;
	margin: auto 0;
}

@media ( max-width : 991px) {
	.distance-image-wrapper {
		white-space: initial;
	}
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
</style>

<%@ include file="../common/foot.jspf"%>