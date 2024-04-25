<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>

<style>
.time-range {
	display: flex;
	max-width: 233px;
	flex-direction: column;
	padding: 0 20px;
}

.time-range-header {
	display: flex;
	width: 100%;
	gap: 20px;
	font-weight: 600;
	white-space: nowrap;
	justify-content: space-between;
}

.time-range-title {
	color: #24262c;
	font: 16px/127% Roboto, sans-serif;
}

.time-range-reset {
	color: #3170e7;
	font: 14px/150% Roboto, sans-serif;
}

.departure-time {
	color: #24262c;
	margin-top: 20px;
	width: 100%;
	font: 400 14px/130% Roboto, sans-serif;
}

.departure-time-range {
	background: linear-gradient(90deg, #a8b3cb 0%, #a8b3cb 0%, #3170e7 0%, #3170e7 100%,
		#a8b3cb 100%, #a8b3cb 100%);
	display: flex;
	margin-top: 10px;
	width: 100%;
	flex-direction: column;
	justify-content: center;
}

.departure-time-slider {
	background: linear-gradient(90deg, #a8b3cb 0%, #a8b3cb 0%, #3170e7 0%, #3170e7 100%,
		#a8b3cb 100%, #a8b3cb 100%);
	display: flex;
	width: 100%;
	gap: 20px;
	justify-content: space-between;
	padding: 3px;
}

.departure-time-handle {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 24px;
	height: 24px;
}

.departure-time-labels {
	display: flex;
	width: 100%;
	gap: 20px;
	font-size: 14px;
	color: #6b7388;
	font-weight: 400;
	white-space: nowrap;
	line-height: 150%;
	justify-content: space-between;
}

.arrival-time {
	color: #24262c;
	margin-top: 20px;
	width: 100%;
	font: 400 14px/130% Roboto, sans-serif;
}

.arrival-time-range {
	background: linear-gradient(90deg, #a8b3cb 0%, #a8b3cb 0%, #3170e7 0%, #3170e7 100%,
		#a8b3cb 100%, #a8b3cb 100%);
	display: flex;
	margin-top: 10px;
	width: 100%;
	flex-direction: column;
	justify-content: center;
}

.arrival-time-slider {
	background: linear-gradient(90deg, #a8b3cb 0%, #a8b3cb 0%, #3170e7 0%, #3170e7 100%,
		#a8b3cb 100%, #a8b3cb 100%);
	display: flex;
	width: 100%;
	gap: 20px;
	justify-content: space-between;
	padding: 3px;
}

.arrival-time-handle {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 24px;
	height: 24px;
}

.arrival-time-labels {
	display: flex;
	width: 100%;
	gap: 20px;
	font-size: 14px;
	color: #6b7388;
	font-weight: 400;
	white-space: nowrap;
	line-height: 150%;
	justify-content: space-between;
}

.divider {
	/* 	display: flex; */
	/*  margin-top: 34px;  */
	width: 100%;
	/* 	flex-direction: column; */
	justify-content: center;
}

/* .divider {

  background-color: #000;
  min-height: 1px;
  margin-top: 37px;
  width: 100%;
} */
.divider-line {
	border-top: 1px solid rgba(168, 179, 203, 1);
	min-height: 1px;
	width: 100%;
}

.price-range-header {
	display: flex;
	margin-top: 17px;
	width: 100%;
	gap: 20px;
	font-weight: 600;
	justify-content: space-between;
}

.price-range-title {
	color: #24262c;
	font: 16px/127% Roboto, sans-serif;
}

.price-range-reset {
	color: #3170e7;
	font: 14px/150% Roboto, sans-serif;
}

.price-range-max {
	color: #24262c;
	margin-top: 15px;
	width: 100%;
	font: 400 14px/130% Roboto, sans-serif;
}

.price-range-slider {
	background: linear-gradient(90deg, #3170e7 0%, #3170e7 100%, #a8b3cb 100%, #a8b3cb
		100%);
	display: flex;
	margin-top: 10px;
	width: 100%;
	flex-direction: column;
	justify-content: center;
}

.price-range-handle {
	background: linear-gradient(90deg, #3170e7 0%, #3170e7 100%, #a8b3cb 100%, #a8b3cb
		100%);
	display: flex;
	width: 100%;
	align-items: flex-end;
	justify-content: center;
	padding: 3px 60px;
}

.price-range-handle-inner {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	display: flex;
	width: 27px;
	justify-content: center;
}

.price-range-handle-dot {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	height: 24px;
}

.duration-range-header {
	display: flex;
	margin-top: 17px;
	width: 100%;
	gap: 20px;
	font-weight: 600;
	justify-content: space-between;
}

.duration-range-title {
	color: #24262c;
	font: 16px/127% Roboto, sans-serif;
}

.duration-range-reset {
	color: #3170e7;
	font: 14px/150% Roboto, sans-serif;
}

.duration-range-max {
	color: #24262c;
	margin-top: 15px;
	width: 100%;
	font: 400 14px/130% Roboto, sans-serif;
}

.duration-range-slider {
	background: linear-gradient(90deg, #3170e7 0%, #3170e7 100%, #a8b3cb 100%, #a8b3cb
		100%);
	display: flex;
	margin-top: 10px;
	width: 100%;
	flex-direction: column;
	justify-content: center;
}

.duration-range-handle {
	background: linear-gradient(90deg, #3170e7 0%, #3170e7 100%, #a8b3cb 100%, #a8b3cb
		100%);
	display: flex;
	width: 100%;
	align-items: flex-end;
	justify-content: center;
	padding: 3px 60px;
}

.duration-range-handle-inner {
	display: flex;
	flex-direction: row;
}

.duration-range-handle-start {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	display: flex;
	width: 27px;
	justify-content: center;
}

.duration-range-handle-end {
	border-radius: 12px;
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	border: 2px solid rgba(49, 112, 231, 1);
	background-color: #fff;
	height: 24px;
	flex-grow: 1;
	width: auto;
}

/* 범위박스 끝 */
.main-image-container {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 44%;
	margin-left: 0;
}

/* @media ( max-width : 991px) {
	.main-image-container {
		width: 100%;
	}
} */
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

/* @media ( max-width : 991px) {
	.main-image {
		padding-left: 20px;
	}
} */
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

/* @media ( max-width : 991px) {
	.accommodation-nav {
		padding: 0 20px;
	}
}
 */
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

/* @media ( max-width : 991px) {
	.container {
		padding: 0 20px;
	}
} */
.header {
	align-self: stretch;
	display: flex;
	width: 100%;
	gap: 20px;
	color: #000;
	justify-content: space-between;
}

/* @media ( max-width : 991px) {
	.header {
		max-width: 100%;
		margin-right: 10px;
		flex-wrap: wrap;
	}
} */
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
	margin-right: 40px;
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

/* @media ( max-width : 991px) {
	.accommodation-type {
		margin-left: 10px;
	}
}
 */
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

/* @media ( max-width : 991px) {
	.accommodation-list {
		margin-left: 10px;
	}
}
 */
.accommodation-item {
	justify-content: center;
	display: flex;
	flex-direction: column;
	padding: 4px 0;
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
	margin-top: 100px;
	/*   border: 2px solid; */
}

.small-outer-content-box {
	display: flex;
	justify-content: center;
	width: 100%;
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
	display: flex;
}

/* 추천목록 중앙서치박스 */
.searchBox2 {
	width: 100%;
	height: 70px;
	display: flex;
	justify-content: center;
}

.flight-search-container {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: #fff;
	border-top: 1px solid rgba(237, 240, 249, 1);
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	width: 1300px;
	/* 	border: 12px solid red; */
}

.flight-search-header {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	padding: 13px 60px;
	background-color: #fff;
	border-top: 1px solid rgba(237, 240, 249, 1);
	box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.15);
	/* 	  border: 3px solid blue; */
}

/* @media ( max-width : 991px) {
	.flight-search-header {
		max-width: 100%;
		padding: 0 20px;
	}
} */
.flight-search-content {
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

/* @media ( max-width : 991px) {
	.flight-search-content {
		flex-wrap: wrap;
	}
} */
.flight-search-image {
	width: 434px;
	aspect-ratio: 10;
	object-fit: auto;
	object-position: center;
	border-radius: 22px 4px 4px 22px;
	/* 	border: 3px solid; */
}

/* @media ( max-width : 991px) {
	.flight-search-image {
		max-width: 100%;
	}
} */
.flight-search-details {
	display: flex;
	flex-direction: column;
	justify-content: center;
	background-color: #edf0f9;
	border-radius: 999px;
}

.flight-search-dates {
	display: flex;
	align-items: center;
	gap: 19px;
	padding: 12px 14px;
	background-color: #edf0f9;
	border-radius: 999px;
	justify-content: center;
	/* 	border: 3px solid; */
}

.flight-search-date {
	display: flex;
	align-self: stretch;
	margin: auto 0;
	gap: 8px;
	/* 	border: 3px solid red; */
}

.flight-search-date-icon {
	display:;
	justify-content: center;
	align-items: center;
	position: relative;
	overflow: hidden;
	width: 16px;
	aspect-ratio: 1;
}

.flight-search-date-icon img {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.flight-search-date-text {
	font: 400 14px/150% Roboto, sans-serif;
	color: #24262c;
}

.flight-search-duration {
	display: flex;
	position: relative;
	overflow: hidden;
	align-self: stretch;
	width: 57px;
	aspect-ratio: 2.85;
}

.flight-search-duration img {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.flight-search-passengers {
	display: flex;
	margin: auto 0;
	gap: 7px;
}

.flight-search-passenger-count {
	display: flex;
	gap: 2px;
}

.flight-search-passenger-icon {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	overflow: hidden;
	width: 16px;
	aspect-ratio: 1;
}

.flight-search-passenger-icon img {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.flight-search-passenger-number {
	font: 400 14px/150% Roboto, sans-serif;
	color: #333;
	text-align: center;
}

.flight-search-class {
	display: flex;
	justify-content: space-between;
	gap: 20px;
}

.flight-search-class-details {
	display: flex;
	margin: auto 0;
	gap: 11px;
}

.flight-search-class-name {
	font: 400 14px/150% Roboto, sans-serif;
	color: #333;
}

.flight-search-class-icon {
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
	overflow: hidden;
	width: 16px;
	aspect-ratio: 1;
}

.flight-search-class-icon img {
	position: absolute;
	inset: 0;
	width: 100%;
	height: 100%;
	object-fit: cover;
	object-position: center;
}

.flight-search-button {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding: 15px 27px;
	font: 600 16px/127% Roboto, sans-serif;
	color: #fff;
	text-align: center;
	white-space: nowrap;
	background-color: #3170e7;
	border-radius: 999px;
}

/* @media ( max-width : 991px) {
	.flight-search-button {
		white-space: initial;
		padding: 0 20px;
	}
} */
.flight-info {
	display: flex;
	flex-direction: column;
	width: 1000px;
	text-align: center;
}

.flight-details {
	align-self: center;
	display: flex;
	width: 100%;
	max-width: 943px;
	align-items: start;
	gap: 20px;
}

/* @media ( max-width : 991px) {
	.flight-details {
		max-width: 100%;
		flex-wrap: wrap;
	}
} */
.airline-name {
	color: #000;
	margin-top: 16px;
	flex-grow: 1;
	font: 400 16px/114% Roboto, sans-serif;
}

.departure-info, .arrival-info {
	display: flex;
	margin-top: 17px;
	gap: 12px;
	font-weight: 400;
}

.departure-time, .arrival-time {
	color: #000;
	font: 16px/114% Roboto, sans-serif;
}

.departure-airport, .arrival-airport {
	color: #3818f8;
	margin: auto 0;
	font: 11px/165% Roboto, sans-serif;
}

.flight-duration-pricing {
	align-self: stretch;
	display: flex;
	gap: 20px;
	justify-content: space-between;
}

.flight-duration {
	color: #000;
	align-self: start;
	margin-top: 16px;
	font: 400 16px/114% Roboto, sans-serif;
}

.pricing-info {
	display: flex;
	flex-direction: column;
}

.discounted-price {
	display: flex;
	gap: 4px;
}

.fare-type {
	color: #000;
	flex-grow: 1;
	font: 400 16px/114% Roboto, sans-serif;
}

.discounted-fare {
	color: #f30d29;
	font: 700 13px/140% Roboto, sans-serif;
}

.regular-fare {
	color: #777;
	align-self: end;
	font: 700 13px/140% Roboto, sans-serif;
}

/* @media ( max-width : 991px) {
	.divider {
		max-width: 100%;
	}
} */
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

.container {
	background-color: #fff;
	display: flex;
	flex-direction: column;
	align-items: start;
	color: #5a5b5b;
	font-weight: 400;
	padding: 30px 80px 80px 33px;
	/*   border: 3px solid; */
}

.cancel-btn {
	width: 70px;
	height: 10px;
}

.train-info-wrapper {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.train-info {
	display: flex;
	flex-direction: column;
	max-width: 598px;
}

.train-info-container {
	width: 100%;
}

@media ( max-width : 991px) {
	.train-info-container {
		max-width: 100%;
	}
}

.train-info-row {
	display: flex;
	gap: 20px;
}

/* @media ( max-width : 991px) {
	.train-info-row {
		flex-direction: column;
		align-items: stretch;
		gap: 0;
	}
} */
.train-info-col {
	display: flex;
	flex-direction: column;
	line-height: normal;
	width: 82%;
	margin-left: 0;
}

media (max-width: 991px) { .train-info-col { width:100%;
	
}

}
.train-info-details {
	display: flex;
	flex-grow: 1;
	gap: 17px;
	text-align: center;
	padding: 0 20px;
}

/* @media ( max-width : 991px) {
	.train-info-details {
		margin-top: 40px;
	}
} */
.train-info-times {
	display: flex;
	flex-direction: column;
	white-space: nowrap;
	flex-grow: 1;
	flex-basis: 0;
	width: fit-content;
}

/* @media ( max-width : 991px) {
	.train-info-times {
		white-space: initial;
	}
} */
.train-info-header {
	display: flex;
	gap: 20px;
	/* 	border: 5px solid purple; */
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
	background-color: #010101;
	color: #fff;
	justify-content: center;
	padding: 6px 12px;
	font: 700 10px Inter, sans-serif;
}

/* @media ( max-width : 991px) {
	.train-name {
		white-space: initial;
	}
}
 */
.train-time {
	display: flex;
	margin-top: 17px;
	gap: 20px;
	justify-content: space-between;
}

.departure-time {
	color: #000;
	font: 700 34px Inter, sans-serif;
	/* 	border: 3px solid blue; */
	height: 50px;
}

.outer-arrival-icon {
	/* 	border: 3px solid blue; */
	display: flex;
	align-items: end;
}

.arrival-icon {
	color: #525252;
	font: 600 29px Inter, sans-serif;
	/* 	border: 3px solid blue;
 */
	height: 50px;
}

.outer-arrival-time {
	display: flex;
	align-items: end;
	/* 	border: 3px solid red; */
}

.arrival-time {
	color: #000;
	height: 50px;
	font: 700 34px Inter, sans-serif;
	/* 	margin-top: 33px; */
	/* 	  border: 3px solid;  */
}

.train-class {
	display: flex;
	margin-top: 18px;
	gap: 20px;
	font-size: 15px;
}

/* @media ( max-width : 991px) {
	.train-class {
		white-space: initial;
	}
} */
.class-general {
	display: flex;
	gap: 11px;
	flex: 1;
}

@media ( max-width : 991px) {
	.class-general {
		white-space: initial;
	}
}

.class-general-label {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: #d9d9d9;
	color: #fff;
	font-weight: 700;
	justify-content: center;
	padding: 7px;
}

/* @media ( max-width : 991px) {
	.class-general-label {
		white-space: initial;
	}
} */
.class-general-status {
	color: #000;
	font-family: Inter, sans-serif;
	font-weight: 500;
	margin: auto 0;
}

.class-special {
	display: flex;
	gap: 11px;
	flex: 1;
}
/* 
@media ( max-width : 991px) {
	.class-special {
		white-space: initial;
	}
}
 */
.class-special-label {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: #d9d9d9;
	color: #fff;
	font-weight: 700;
	justify-content: center;
	padding: 7px 8px;
}

/* @media ( max-width : 991px) {
	.class-special-label {
		white-space: initial;
	}
} */
.class-special-status {
	color: #000;
	font-family: Inter, sans-serif;
	font-weight: 500;
	margin: auto 0;
}

.small-outer-travel-time {
	/* 	border: 3px solid green; */
	margin-top: 35px;
	height: 50px;
	display: flex;
	align-items: end;
}

.outer-travel-time {
	display: flex;
	align-items: end;
	height: 100px;
	/* 	border: 2px solid;  */
	margin-top: 10px;
}

.travel-time {
	color: #000;
	margin: auto 0;
	font: 400 20px Inter, sans-serif;
	/* 	border: 3px solid;  */
}

.booking-col {
	display: flex;
	line-height: normal;
	width: 18%;
	margin-left: 20px;
	/* 	border: 3px solid red; */
	align-items: center;
}

.outer-booking-btn {
	/* border: 3px solid; */
	
}

.booking-btn {
	border-radius: 10px;
	background-color: #d9d9d9;
	/* margin-top: 44px; */
	color: #000;
	white-space: nowrap;
	text-align: center;
	width: 100%;
	justify-content: center;
	padding: 12px 30px;
	font: 400 20px Inter, sans-serif;
}

/* @media ( max-width : 991px) {
	.booking-btn {
		margin-top: 40px;
		white-space: initial;
		padding: 0 20px;
	}
} */
.divider {
	border-color: rgba(0, 0, 0, 1);
	border-style: solid;
	/* 	border-width: 1px; */
	/* background-color: #000; */
	/* 	min-height: 1px; */
	/* 	margin-top: 5px; */
	width: 100%;
	/* border: 3px solid; */
}

@media ( max-width : 991px) {
	.divider {
		max-width: 100%;
	}
}

/* 검색칸 */
.flight-route {
	display: flex;
	gap: 4px;
}

.origin-airport {
	border-radius: 22px 4px 4px 22px;
	background-color: #edf0f9;
	display: flex;
	gap: 14px;
	font-size: 14px;
	color: #24262c;
	font-weight: 400;
	line-height: 130%;
	flex: 1;
	padding: 12px 80px 12px 16px;
}

.airport-icon {
	width: 20px;
	aspect-ratio: 1;
	object-fit: contain;
	object-position: center;
}

.origin-airport-code {
	font-family: Roboto, sans-serif;
	margin: auto 0;
}

.destination-airport {
	border-radius: 4px 22px 22px 4px;
	background-color: #edf0f9;
	display: flex;
	gap: 14px;
	flex: 1;
	padding: 8px 80px 8px 0;
}

.destination-airport-icons {
	display: flex;
	gap: 5px;
}

/* .destination-airport-pin {
	display: flex;
	justify-content: center;
	align-items: center;
	border-radius: 999px;
	box-shadow: 0px 2px 7px 0px rgba(0, 0, 0, 0.2);
	background-color: #fff;
	width: 58px;
	height: 28px;
	padding: 0 6px;
	border: 3px solid;
	margin-top: 15px;

	
	
	
} */
.pin-icon {
	width: 16px;
	aspect-ratio: 1;
	object-fit: contain;
	object-position: center;
}

.plane-icon {
	width: 20px;
	aspect-ratio: 1;
	object-fit: contain;
	object-position: center;
	margin: auto 0;
}

.destination-airport-code {
	color: #24262c;
	margin: auto 0;
	font: 400 14px/130% Roboto, sans-serif;
}

.searchBox2 {
	margin-top: 20px;
	/* border: 3px solid; */
}
</style>
<header class="header">
	<div class="logo">로고</div>
	<div class="user-info">
		<span class="username">
			<span class="black-text">abc123</span>
			<span class="black-text">님</span>
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

		</div>
	</div>

	<div>
		<div class="outer-searchBox">
			<div class="searchBox1">
				<nav class="accommodation-nav">
					<ul class="accommodation-nav-list">

						<div class="accommodation-nav-item btn m-1">
							<a href="../article/recommendlist">숙소</a>
						</div>
						<div class="dropdown">
							<div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
							<ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
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
				</nav>
			</div>

			<div class="searchBox2">

				<div class="flight-search-container">
					<header class="flight-search-header">
						<div class="flight-search-content">

							<div class="flight-route">
								<div class="origin-airport">
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/f0fadc5e1d76844beefb51b89ef84518ea8035476fccb2578225cdc2cfc41524?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="Origin airport icon" class="airport-icon" />
									<div class="origin-airport-code">
										<select class="select select-ghost w-full max-w-xs">
											<option disabled selected>청주(CJU)</option>
											<option>Svelte</option>
											<option>Vue</option>
											<option>React</option>
										</select>
									</div>
								</div>
								<div class="destination-airport">
									<div class="destination-airport-icons">
										<div class="destination-airport-pin">
											<!-- <img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/98c18b60e9f95eb96b6bf53e442854cccd679784f32787012fcce26fdb4cbecd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="Destination pin icon" class="pin-icon" /> -->
										</div>
										<img
											src="https://cdn.builder.io/api/v1/image/assets/TEMP/9924b81dad0fbf6a35b311cf1ec8f152b87ecb9c2f4337693e3fbc5bc4dad5da?apiKey=f834c4360ac549c5b5237c00b19938c4&"
											alt="Plane icon" class="plane-icon" />
									</div>
									<div class="destination-airport-code">
										<select class="select select-ghost w-full max-w-xs">
											<option disabled selected>부산 (PUS)</option>
											<option>Svelte</option>
											<option>Vue</option>
											<option>React</option>
										</select>
									</div>
								</div>
							</div>

							<div class="flight-search-details">
								<div class="flight-search-dates">
									<div class="flight-search-date">
										<!-- <div class="flight-search-date-icon">

											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/36fa2c3b0a8961d87b50f228f68a2281f5fa3e5c753dc9b0a1181b340d9873b4?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" />
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/b533c9792731d97f1f90a405a81d97c8ff6003c50cace4cf001954acb1f6363f?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="Calendar icon" />
										</div> -->
										<div class="flight-search-date-text">일, 28 4월</div>
										<!-- <div id="calendar" > -->

									</div>
									<!-- <div class="flight-search-date">
										<div class="flight-search-date-icon">
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/4f9b7796862a0f5136ed1e711686f04480ccf0ab3ca59e32418fb698a54a423b?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" />
											<img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/6468715dfa7a8aaac104e143a35e1c1f8e93978a65f2a4a94056575230d7438a?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="Calendar icon" />
										</div>
										<div class="flight-search-date-text">화, 30 4월</div>
									</div> -->
									<!-- <div class="flight-search-duration">
										<img
											src="https://cdn.builder.io/api/v1/image/assets/TEMP/d4eaca586df01d2de36e8aa7bc9b4266b5739b251e12629b62f8daca305803e8?apiKey=f834c4360ac549c5b5237c00b19938c4&"
											alt="" />
										<img
											src="https://cdn.builder.io/api/v1/image/assets/TEMP/b0440974fe5614d0211dee8350a8804486c0546f430b6ffd7f706b61334e2a49?apiKey=f834c4360ac549c5b5237c00b19938c4&"
											alt="Flight duration" />
									</div> -->
								</div>
							</div>
							<div class="flight-search-passengers">
								<div class="flight-search-passenger-count">
									<div class="flight-search-passenger-icon"></div>
									<!-- <select class="select select-ghost w-full max-w-xs">
										<option disabled selected><img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/bf324d7d075e3aa82dd4036f568d5ba7d5e3cac9abcc614363f794c2ec45721e?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="" class="your-class-name" /><img
												src="https://cdn.builder.io/api/v1/image/assets/TEMP/6bae24e921b2dcee5986b9432576475b0dd7e006205a35cc4939303245ad33d5?apiKey=f834c4360ac549c5b5237c00b19938c4&"
												alt="Passenger icon" />인원
										</option>
										<option>1</option>
										<option>2</option>
										<option>3</option>
									</select> -->
								</div>
								<div class="flight-search-passenger-icon">
									<!-- <img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/7984c315fb4720f7a8246883a4b750da404d00d9f2eb344e9b366f8a537d1c94?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="" />
									<img
										src="https://cdn.builder.io/api/v1/image/assets/TEMP/9cb6cedd3cbfe98a89ab2bb9cd9b7c0c4d3c408172d761c631c5a3c86312c553?apiKey=f834c4360ac549c5b5237c00b19938c4&"
										alt="Passenger icon" /> -->
								</div>
							</div>
							<div class="flight-search-class">
								<div class="flight-search-class-details dropdown dropdown-open">
									<div class="flight-search-class-name ">
										<!-- 	<select class="select select-ghost w-full max-w-xs">
											<option disabled selected>이코노미</option>
											<option>Svelte</option>
											<option>Vue</option>
											<option>React</option>
										</select> -->
									</div>
									<!-- <div class="flight-search-class-icon">

										<img
											src="https://cdn.builder.io/api/v1/image/assets/TEMP/38109152b681e7836e55edc85b3983b22ab1619f978ff9d8f391fdd52ae97b04?apiKey=f834c4360ac549c5b5237c00b19938c4&"
											alt="" />
										<img
											src="https://cdn.builder.io/api/v1/image/assets/TEMP/3e17e53102545c352d5947a690894268bb14489cc479de4328cc5b7b64c508cd?apiKey=f834c4360ac549c5b5237c00b19938c4&"
											alt="Dropdown arrow" />
									</div> -->
								</div>
								<div class="flight-search-button">검색하기</div>
							</div>
						</div>
					</header>
				</div>
			</div>
		</div>

		<div class="outer-content-box">
			<div class="small-outer-content-box">
				<div class="train-info-wrapper">
					<section class="train-info">
						<div class="train-info-container">
							<div class="train-info-row">
								<div class="train-info-col">
									<div class="train-info-details">
										<div class="train-info-times">
											<header class="train-info-header">
												<div class="train-info-name">
													<div class="train-name">KTX</div>
													<div class="train-time">
														<time class="departure-time">22:37</time>

														<div class="outer-arrival-icon">
															<div class="arrival-icon">→</div>
														</div>

													</div>
												</div>
												<div class="outer-arrival-time">
													<time class="arrival-time">23:44</time>
												</div>

											</header>
											<div class="train-class">
												<div class="class-general">
													<div class="class-general-label">일반</div>
													<div class="class-general-status">예매가능</div>
												</div>
												<div class="class-special">
													<div class="class-special-label">특</div>
													<div class="class-special-status">예매가능</div>
												</div>
											</div>
										</div>
										<div class="outer-travel-time">
											<div class="small-outer-travel-time">
												<div class="travel-time">1시간 7분</div>
											</div>

										</div>

									</div>
								</div>

								<div class="booking-col">
									<div class="outer-booking-btn">
										<button class="booking-btn">예매</button>
									</div>

								</div>

							</div>
						</div>
						<div class="divider"></div>

					</section>
				</div>

				<div class="train-info-wrapper">
					<section class="train-info">
						<div class="train-info-container">
							<div class="train-info-row">
								<div class="train-info-col">
									<div class="train-info-details">
										<!-- Article 정보 출력 -->
										<div class="train-info-times">
											<header class="train-info-header">
												<div class="train-info-name">
													<c:if test="${not empty spanTexts}">
														<c:forEach var="article" items="${spanTexts}">
															<div class="train-name">${article.trainName}</div>
															<div class="train-time">
																<time class="departure-time">${article.departureTime}</time>
																<div class="outer-arrival-icon">
																	<div class="arrival-icon">→</div>
																</div>
															</div>
														</c:forEach>
													</c:if>
												</div>
												<div class="outer-arrival-time"></div>
											</header>
											<!-- 기타 정보 출력 -->
											<!-- 예매 버튼 등 -->
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="divider"></div>
					</section>
				</div>

			</div>
			<div class="small-outer-content-box">
				<div class="train-info-wrapper">
					<section class="train-info">
						<div class="train-info-container">
							<div class="train-info-row">
								<div class="train-info-col">
									<div class="train-info-details">
										<div class="train-info-times">
											<header class="train-info-header">
												<div class="train-info-name">
													<div class="train-name">KTX</div>
													<div class="train-time">
														<time class="departure-time">22:37</time>

														<div class="outer-arrival-icon">
															<div class="arrival-icon">→</div>
														</div>

													</div>
												</div>
												<div class="outer-arrival-time">
													<time class="arrival-time">23:44</time>
												</div>

											</header>
											<div class="train-class">
												<div class="class-general">
													<div class="class-general-label">일반</div>
													<div class="class-general-status">예매가능</div>
												</div>
												<div class="class-special">
													<div class="class-special-label">특</div>
													<div class="class-special-status">예매가능</div>
												</div>
											</div>
										</div>
										<div class="outer-travel-time">
											<div class="small-outer-travel-time">
												<div class="travel-time">1시간 7분</div>
											</div>

										</div>

									</div>
								</div>

								<div class="booking-col">
									<div class="outer-booking-btn">
										<button class="booking-btn">예매</button>
									</div>

								</div>

							</div>
						</div>
						<div class="divider"></div>

					</section>
				</div>

			</div>


		</div>

	</div>

	<!-- <script>
		document.addEventListener("DOMContentLoaded", function() {
			var flightSearchDateText = document
					.querySelector(".flight-search-date-text");
			var calendar = document.getElementById("calendar");

			// flight-search-date-text 요소를 클릭했을 때
			flightSearchDateText.addEventListener("click", function() {
				// 달력을 표시하거나 숨깁니다.
				if (calendar.style.display === "none"
						|| calendar.style.display === "") {
					calendar.style.display = "block";
					// 이번 달이 기본으로 설정된 달력을 표시하는 기능을 추가할 수 있습니다.
				} else {
					calendar.style.display = "none";
				}
			});
		});
	</script> -->


	<%@ include file="../common/foot.jspf"%>