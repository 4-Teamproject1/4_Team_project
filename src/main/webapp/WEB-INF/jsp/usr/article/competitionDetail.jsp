<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #F9B563;">학술연구정보</a>
		<a href="#" class="list-board-item">학술행사</a> <a href="#"
			class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<div class="">학술행사</div>
			<div class="">공모전</div>
			<div class="sort-options ">
				<form>
					<input type="radio" id="option1" name="options" value="option1">
					<button type="button" onclick="selectRadio('option1')">등록/수정일순</button>
					&nbsp; <input type="radio" id="option2" name="options"
						value="option2">
					<button type="button" onclick="selectRadio('option2')">조회순</button>
					&nbsp; <input type="radio" id="option3" name="options"
						value="option3">
					<button type="button" onclick="selectRadio('option3')">마감순</button>
					&nbsp; <input type="radio" id="option4" name="options"
						value="option4">
					<button type="button" onclick="selectRadio('option4')">제목순</button>
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

<img src="https://attachment.hibrain.io/recruits/3469412/1713143906596/제목 없음.png" style="height: 1234px; width: 900px;">
		
			</div>
		</div>
	</div>
	<div class="side-bar-container"></div>
</div>

<div class="bottom-bar">
	<div class="page-bar">
		<span><button><a href="" class="btn"><</a></button> </span>
		<button><a href="" class="btn">1</a></button>
		<button><a href="" class="btn">2</a></button>
		<button><a href="" class="btn">3</a></button>
		<span><button><a href="" class="btn">></a></button> </span>
	</div>
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
	margin: 20px;
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
	justify-content: left;
	align-items: center;
	padding: 0.25rem 0.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
	white-space: nowrap;
	border-top: 2px solid #ed8936;
}

.category-filters>span {
	padding: 5px 10px 5px 10px;
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

.list-table th {
	text-align: center;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
}

/* 테이블 행 hover 시 배경색 변경 */
.table tbody tr:hover {
	background-color: #EAD8C0;
}

tr {
	justify-content: center;
}

/* 하단 바 */
.bottom-bar {
	margin-top: 60px;
	border: solid 1px red;
	text-align: center;
}

.page-bar {

	background-color: yellow;
}

.page-bar>button {

}
</style>


<%@ include file="../common/foot.jspf"%>