<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #F9B563;">학술연구정보</a>
		<a href="../conference/list" class="list-board-item" style="background-color: orange;">학술행사</a>
		<a href="../competition/list" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<div class="main-list">학술행사</div>
			<div class="sort-options-container ">
				<div class="sort-options">
					<form>
						<input type="radio" id="option1" name="options" value="option1">
						<button type="button" onclick="selectRadio('option1')">등록/수정일순</button>
						&nbsp;
						<input type="radio" id="option2" name="options" value="option2">
						<button type="button" onclick="selectRadio('option2')">
						조회순
						</button>
						&nbsp;
						<input type="radio" id="option3" name="options" value="option3">
						<button type="button" onclick="selectRadio('option3')">
						마감순
						</button>
						&nbsp;
						<input type="radio" id="option4" name="options" value="option4">
						<button type="button" onclick="selectRadio('option4')">
							제목순
						</button>
					</form>

				<!-- 	<script>
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
					</script> -->
				</div>


				<form class="search-form">
					<input type="text" placeholder="검색어를 입력하세요." />
					<button>검색</button>
				</form>
			</div>

			<div class="category-filters">
				<!-- Category Filters -->

				<button class="conference-0">전체(9)</button>
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
								<td>${conference.applicationPeriod}</td>
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
$(document).ready(function() {
    var selectedOption = ""; // 선택된 옵션 초기화
    var selectedCategoryId = ""; // 선택된 카테고리 ID 초기화

    // 등록/수정일순, 조회순, 마감순, 제목순 버튼 클릭 시
    $(".sort-options button").click(function() {
        selectedOption = $(this).text().trim();
        $(".sort-options button").removeClass("btn-active");
        $(this).addClass("btn-active");
        // 선택된 옵션과 카테고리 ID를 이용하여 데이터 가져오기
        getFilteredConferences(selectedOption, selectedCategoryId);
    });

    // 카테고리 버튼 클릭 이벤트
    $(".category-filters button").click(function() {
        selectedCategoryId = $(this).attr("class").split(" ")[0].split("-")[1];
        $(".category-filters button").removeClass("btn-active");
        $(this).addClass("btn-active");
        // 선택된 옵션과 카테고리 ID를 이용하여 데이터 가져오기
        getFilteredConferences(selectedOption, selectedCategoryId);
    });

    // 선택된 옵션들을 기반으로 데이터를 가져오는 함수
    function getFilteredConferences(option, categoryId) {
        $.ajax({
            type: "GET",
            url: "getFilteredConferences",
            data: { option: option, categoryId: categoryId },
            success: function(data) {
                drawConferences(data);
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    }

    // 학술행사 목록을 그리는 함수
    function drawConferences(conferenceList) {
        var html = '';
        $.each(conferenceList, function(index, conference) {
            html += '<tr>';
            html += '<td>' + conference.id + '</td>';
            html += '<td><a href="detail?id=' + conference.id + '">' + conference.title + '</a></td>';
            html += '<td>' + conference.applicationPeriod + '</td>';
            html += '<td>' + conference.regDate + '</td>';
            html += '<td>' + conference.hitCount + '</td>';
            html += '</tr>';
        });
        $('.table tbody').html(html);
    }
});


</script>




<style>
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
	background-color: orange; /* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
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
/* Search Form */
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
	background-color: #DADDB1;
	padding: 5px 10px;
	border-radius: 10px;
	text-color: white;
}

.search-form button:hover {
	background-color: #F9B563;
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

.category-filters>button {
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
	background-color: #F9B563;
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
	background-color: #FFDD95;
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
	background-color: #F7C566;
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