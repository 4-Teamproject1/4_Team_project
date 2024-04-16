<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } ARTICLE LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #F9B563;">학술연구정보</a> <a href="#" class="list-board-item">학술행사</a>
		<a href="#" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<h1 class="">학술행사</h1>
			<div class="sort-options ">
				<form>
					<input type="radio" id="option1" name="options" value="option1">
					<button type="button" onclick="selectRadio('option1')">조회순</button>
					&nbsp; <input type="radio" id="option2" name="options"
						value="option2">
					<button type="button" onclick="selectRadio('option2')">마감순</button>
					&nbsp; <input type="radio" id="option3" name="options"
						value="option3">
					<button type="button" onclick="selectRadio('option3')">제목순</button>
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
				<!-- Search form -->
				<!-- Your search form HTML here -->
			</form>

			<div class="category-filters">
				<!-- Category Filters -->
				<!-- Your category filters HTML here -->

			</div>

			<!-- Entry 2 -->

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
			</table>
		</div>
	</div>
	<div class="side-bar-container"></div>
</div>





<style>
/* flex */
.list-container {
	display: flex;
	
}
.list-board {
	flex: 0.5;
}
.list-items-container {
	flex: 4;
}

.side-bar-container {
	flex: 1;
	background-color: pink;
}

/* Sorting Options */
.sort-options {
	gap: 0.75rem;
	margin-top: 1.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
}

/* Search Form */
.search-form {
	gap: 0.375rem;
	align-items: center;
	margin-top: 1.75rem;
}

.search-input {
	height: 1.5rem;
	border: 1px solid #cbd5e0;
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

/* Category Filters */
.category-filters {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.25rem 0.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
	white-space: nowrap;
	border-top: 2px solid #ed8936;
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
	background-color: #F9B563;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 20px;
}


</style>


<%@ include file="../common/foot.jspf"%>