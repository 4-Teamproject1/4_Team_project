<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="AcademicEvent List"></c:set>
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
		<a href="/usr/article/academicEventList" class="list-board-item">학술행사</a>
		<a href="/usr/article/competitionList" class="list-board-item" >공모전</a>
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
						<button type="button" onclick="selectRadio('option2')"><a href="###">조회순</a></button>
						&nbsp;
						<input type="radio" id="option3" name="options" value="option3">
						<button type="button" onclick="selectRadio('option3')"><a href="###">마감순</a></button>
						&nbsp;
						<input type="radio" id="option4" name="options" value="option4">
						<button type="button" onclick="selectRadio('option4')"><a href="###">제목순</a></button>
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
				<!-- Your category filters HTML here -->
				<span>
					<a href="" style="font-size: 16px;">전체(9)</a>
				</span>
				<span>
					<a href="">공학(3)</a>
				</span>
				<span>
					<a href="">자연과학(2)</a>
				</span>
				<span>
					<a href="">의약학(1)</a>
				</span>
				<span>
					<a href="">인문학(2)</a>
				</span>
				<span>
					<a href="">사회과학(0)</a>
				</span>
				<span>
					<a href="">예술체육(1)</a>
				</span>
				<span>
					<a href="">농수해양(0)</a>
				</span>
				<span>
					<a href="">복합학(0)</a>
				</span>
				<span>
					<a href="">전공불문(0)</a>
				</span>


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
						<td>1</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>2</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>3</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>4</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>5</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>6</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>7</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>8</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>9</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>9</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>10</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>11</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>12</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>13</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>14</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>15</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>16</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
					</tbody>
					<tbody>
						<td>17</td>
						<td>한국비임상기술지원센터 웨비나</td>
						<td>24.04.03 ~ 24.04.24</td>
						<td>24.04.09</td>
						<td>53</td>
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
	background-color: #7E9DD9; /* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
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
	background-color: #7E9DD9;
	padding: 5px 10px;
	border-radius: 10px;
	color: white;
}

.search-form button:hover {
	background-color: #00256c;
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