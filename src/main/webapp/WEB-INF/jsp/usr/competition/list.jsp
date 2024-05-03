<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../path/to/your/javascript/file.js"></script>
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

			<div class="main-list">공모전</div>
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


				<form action="/usr/competition/list" method="get">
					<select name="searchKeywordTypeCode">
						<option value="title">제목</option>
					</select>
					<input type="text" name="searchKeyword" value="${searchKeyword}"class="input-sm input input-bordered w-48 max-w-xs">
					<button class="btn btn-ghost btn-sm" type="submit">검색</button>
				</form>
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
						<c:forEach items="${competitions}" var="competition">
							<tr>
								<td>${competition.id}</td>
								<!-- 첫 번째 td에 학회의 ID -->
								<td>
									<a href="detail?themeId=${competition.themeId}&id=${competition.id}">${competition.title}</a>
								</td>
								<!-- 두 번째 td에 학회의 제목 -->
								<td>${competition.applicationPeriod}</td>
								<!-- 세 번째 td에 행사 기간 -->
								<td>${competition.regDate}</td>
								<!-- 네 번째 td에 등록/수정일 -->
								<td>조회수</td>
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

    $(".sort-options button").click(function() {
        selectedOption = $(this).text().trim(); // 버튼의 텍스트가 서버 측에서 예상하는 옵션과 정확히 일치해야 합니다.
        $(".sort-options button").removeClass("btn-active");
        $(this).addClass("btn-active");

        // AJAX 호출을 위한 함수 이름 수정
        getFilteredCompetitions(selectedOption); // 서버 측 컨트롤러와 일치하도록 함수 이름 수정
    });

    // 필터링된 데이터를 가져오는 AJAX 함수
    function getFilteredCompetitions(option) {
        $.ajax({
            type: "GET",
            url: "/usr/competition/getFilteredCompetitions", // 서버 측 URL과 일치하는지 확인
            data: { option: option },
            success: function(data) {
                drawCompetitions(data);
            },
            error: function(xhr, status, error) {
                console.error("Error:", error);
            }
        });
    }

    // 대회 정보를 화면에 그리는 함수
    function drawCompetitions(competitionList) {
        var html = '';
        $.each(competitionList, function(index, competition) {
            html += '<tr>';
            html += '<td>' + competition.id + '</td>';
            html += '<td><a href="detail?id=' + competition.id + '">' + competition.title + '</a></td>';
            html += '<td>' + competition.applicationPeriod + '</td>';
            html += '<td>' + competition.regDate + '</td>';
            html += '<td>' + competition.hitCount + '</td>';
            html += '</tr>';
        });
        $('.table tbody').html(html);
    }
});



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
  .list-board-item:hover,
  .list-board-item:active {
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