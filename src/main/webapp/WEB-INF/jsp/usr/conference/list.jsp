<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Conference List"></c:set>
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


<div class="list-container">
	<div class="list-board">
		<a href="../conference/list" class="list-board-item" style="background-color: #00256c; color: white;">학술연구정보</a>
		<a href="../conference/list" class="list-board-item">학술행사</a>
		<a href="../competition/list" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<div class="main-list">학술행사</div>
			<div class="sort-options-container ">
				<div class="sort-options">
					<form>
						<input type="radio" id="option1" name="options" value="option1">
						<button type="button" onclick="selectRadio('option1')">
							<a href="#">등록/수정일순</a>
						</button>
						&nbsp;
						<input type="radio" id="option2" name="options" value="option2">
						<button type="button" onclick="selectRadio('option2')">
							<a href="###">조회순</a>
						</button>
						&nbsp;
						<input type="radio" id="option3" name="options" value="option3">
						<button type="button" onclick="selectRadio('option3')">
							<a href="###">마감순</a>
						</button>
						&nbsp;
						<input type="radio" id="option4" name="options" value="option4">
						<button type="button" onclick="selectRadio('option4')">
							<a href="###">제목순</a>
						</button>
					</form>

					<script>
						function selectRadio(optionId) {
							document.getElementById(optionId).checked = true;
						}
					</script>

					<script>
						function selectRadio(optionId) {
							document.getElementById(optionId).checked = true;
						}
					</script>

					<script>
						function selectRadio(optionId) {
							document.getElementById(optionId).checked = true;
						}
					</script>
				</div>


				<form class="search-form">
					<input type="text" placeholder="검색어를 입력하세요." />
					<button>검색</button>
				</form>
			</div>

			<div class="category-filters">
				<!-- Category Filters -->

				<button class="total_conference">전체(9)</button>
				<button class="conference-1">공학(3)</button>
				<button class="conference-2">자연과학(2)</button>
				<button class="conference-3">의약학(1)</button>
				<button class="conference-4">인문학(2)</button>
				<button class="conference-5">사회과학(0)</button>
				<button class="conference-6">예술체육(1)</button>
				<button class="conference-7">농수해양(0)</button>
				<button class="conference-8">복합학(0)</button>
				<button class="conference-9">전공불문(0)</button>



			</div>

			<!-- Entry 2 -->
			<div>
				<table class="table ">
					<colgroup>
						<col style="width: 5%" />
						<col style="width: 60%" />
						<col style="width: 20%" />
						<col style="width: 10%" />
						<col style="width: 5%" />
					</colgroup>
					<thead class="list-table">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>접수기간</th>
							<th>등록/수정일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${conferences}" var="conference">
							<tr>
								<td>${conference.id}</td>
								<!-- 첫 번째 td에 학회의 ID -->
								<td>
									<a href="detail?id=${conference.id}">${conference.title}</a>
								</td>
								<!-- 두 번째 td에 학회의 제목 -->
								<td>${conference.eventPeriod}</td>
								<!-- 세 번째 td에 행사 기간 -->
								<td>${conference.regDate}</td>
								<!-- 네 번째 td에 등록/수정일 -->
								<td>${conference.hitCount}</td>
								<!-- 다섯 번째 td에 조회수 -->
							</tr>
						</c:forEach>
					</tbody>


				</table>
			</div>
		</div>
	</div>
	<div class="side-bar-container">
		<img class="info-img" src="https://i.ibb.co/tpt0rzp/image.png" alt="image" border="0">
	</div>
</div>

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


<script>
	//라디오 버튼 선택 함수
	function selectRadio(optionId) {
		document.getElementById(optionId).checked = true;
	}
</script>



<script>
	//Ajax 호출을 통해 필터링된 학회 목록을 가져오는 함수
	function getFilteredConferences(categoryId) {
		// categoryId에 해당하는 데이터를 가져오는 Ajax 호출
		$.ajax({
			type : "GET",
			url : "getConferencesByCategory",
			data : {
				categoryId : categoryId
			}, // 서버로 전달할 데이터
			success : function(data) {
				drawConferences(data);
				console.log(data);
			},
			error : function(xhr, status, error) {
				// 에러 발생 시의 처리
				console.error("Error:", error);
			}
		});
	}

	// 각 버튼에 대한 클릭 이벤트 처리
	$(document).ready(function() {
		$(".total_conference").click(function() {
			getFilteredConferences(0); // 전체 카테고리를 나타내는 categoryId를 전달
		});

		$(".conference-1").click(function() {
			getFilteredConferences(1); // categoryId 1을 가진 학회 데이터를 가져오기 위해 1을 전달
		});
		$(".conference-2").click(function() {
			getFilteredConferences(2);
		});
		$(".conference-3").click(function() {
			getFilteredConferences(3);
		});
		$(".conference-4").click(function() {
			getFilteredConferences(4);
		});
		$(".conference-5").click(function() {
			getFilteredConferences(5);
		});
		$(".conference-6").click(function() {
			getFilteredConferences(6);
		});
		$(".conference-7").click(function() {
			getFilteredConferences(7);
		});
		$(".conference-8").click(function() {
			getFilteredConferences(8);
		});
		$(".conference-9").click(function() {
			getFilteredConferences(9);
		});

	});
</script>

<script>
	function drawConferences(conferenceList) {
		console.log("Received conferenceList:", conferenceList); // conferenceList를 콘솔에 출력하여 확인

		// 새로운 HTML을 생성하기 위한 변수를 선언합니다.
		var html = '';

		// conferenceList를 순회하면서 각 회의의 정보를 HTML에 추가합니다.
		$.each(conferenceList, function(index, conference) {
			// 각 회의에 대한 HTML을 생성하여 html에 추가합니다.
			html += '<tr>';
			html += '<td>' + conference.id + '</td>';
			html += '<td><a href="detail?id=' + conference.id + '">'
					+ conference.title + '</a></td>';
			html += '<td>' + conference.eventPeriod + '</td>';
			html += '<td>' + conference.regDate + '</td>';
			html += '<td>' + conference.hitCount + '</td>';
			html += '</tr>';
		});

		// 생성된 HTML을 테이블의 tbody에 추가합니다.
		$('.table tbody').html(html);
	}
</script>




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

/* 버튼에 마우스를 올렸을 때와 클릭했을 때의 스타일 */
.list-board-item:hover, .list-board-item:active {
	background-color: #7E9DD9;
	/* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
	color: white;
}

/* list container */
.list-items-container {
	flex: 4;
	margin: 20px;
	height: 100%;
}

.main-list {
	font-size: 24px;
}

/* side bar container */
.side-bar-container {
	flex: 1;
	height: 800px;
}

.info-img {
	margin-top: 100px;
}

/* Sorting Options */
.sort-options-container {
	display: flex;
	color: #4a5568;
}

.sort-options {
	flex: 4;
	margin-top: 5px;
}

/* 사용자 정의 라디오 버튼 */
input[type="radio"] {
	-webkit-appearance: none;
	/* 웹킷 브라우저의 기본 모양 제거 */
	-moz-appearance: none;
	/* 모질라 파이어폭스의 기본 모양 제거 */
	appearance: none;
	/* 다른 브라우저의 기본 모양 제거 */
	width: 13px;
	/* 원 모양을 만들기 위해 너비와 높이 설정 */
	height: 13px;
	border-radius: 50%;
	/* 원 모양으로 만들기 */
	border: 1px solid #00256c;
	/* 라디오 버튼 동그라미의 테두리 색상 */
	outline: none;
}

/* 라디오 버튼 선택됐을 때 */
input[type="radio"]:checked {
	background-color: #7E9DD9;
	/* 선택됐을 때 라디오 버튼 동그라미의 색상 채우기 */
	border: 2px solid white;
	outline: 1px solid #00256c;
}

/* 검색 폼 */
.search-form {
	flex: 1;
	justify-content: right;
	align-items: center;
	margin-bottom: 5px;
}

.search-form input {
	border: 1px solid #cbd5e0;
	border-radius: 5px;
	padding: 5px;
	margin-right: 5px;
}

.search-form button {
	background-color: #00256c;
	padding: 5px 10px;
	border-radius: 10px;
	color: white;
}

.search-form button:hover {
	background-color: #7E9DD9;
}

.search-btn {
	padding: 0.375rem 0.625rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #fff;
	background-color: #f9fafb;
	border: none;
	border-radius: 0.25rem;
}

/* 카테고리 구분 */
.category-filters {
	display: flex;
	justify-content: left;
	align-items: center;
	padding: 0.25rem 0.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
	white-space: nowrap;
	border-top: 2px solid #878787;
}

.category-filters>span {
	padding: 5px 10px;
}

.category-item {
	display: flex;
	gap: 0.625rem;
	align-items: center;
}

.category-count {
	font-weight: bold;
	color: #3182ce;
}

/* Table */
.table-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.875rem 1.25rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #1a202c;
	white-space: nowrap;
	border-bottom: 1px solid #cbd5e0;
}

.table-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.625rem 0.875rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #1a202c;
	white-space: nowrap;
	border-bottom: 1px solid #cbd5e0;
}

.list-table {
	background-color: #7E9DD9;
	color: white;
	font-size: 14px;
}

.list-table th {
	text-align: center;
}

/* 중앙 정렬을 위한 CSS */
.table td {
	text-align: center;
}

/* 제목 열은 중앙 정렬되지 않도록 수정 */
.table td:nth-child(2) {
	text-align: left;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
}

/* 테이블 행 hover 시 배경색 변경 */
.table tbody tr:hover {
	background-color: #B6CCF4;
	color: white;
}

tr {
	justify-content: center;
}

/* 하단 바 */
.bottom-bar {
	margin-top: 60px;
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