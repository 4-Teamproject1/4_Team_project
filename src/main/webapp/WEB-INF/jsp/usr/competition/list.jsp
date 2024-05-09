<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../path/to/your/javascript/file.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />


<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>

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

<div class="list-container">
  <div class="list-board">
    	<span class="list-board-item" style="background-color: #00256c; color: white;">학술연구정보</span>
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
	<section class="research-info-container">
  <h2 class="research-info-title">
    <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/7cbe973a0e1df613c84889fc15d87154d539e3663bd68a899a58efaeb4c3775b?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="" class="research-info-title-bg" />
    추천 학술연구정보
  </h2>

  <article class="research-item">
    <header class="research-item-header">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/3e3bc42bcec7cf8d9999536faf111953374afda004954f6ec46e70f4bbe100ca?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="한국연구재단 로고" class="research-item-logo" />
      <div class="research-item-source"><a href="https://www.nrf.re.kr/index">한국연구재단</a>
</div>
    </header>
    <h3 class="research-item-title">2024년 해외우수과…</h3>
  </article>

  <article class="research-item">
    <header class="research-item-header">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/3e3bc42bcec7cf8d9999536faf111953374afda004954f6ec46e70f4bbe100ca?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="한국연구재단 로고" class="research-item-logo" />
      <div class="research-item-source"><a href="https://www.nrf.re.kr/index">한국연구재단</a></div>
    </header>
    <h3 class="research-item-title">외국박사학위 취득…</h3>
  </article>

  <article class="research-item">
    <header class="research-item-header">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/b6808111502d581184bb0da596706cf4f070005a54b61cac66393afda21613be?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="포스코청암재단 로고" class="research-item-logo" />
      <div class="research-item-source"><a href="https://www.postf.org/">포스코청암재단</a></div>
    </header>
    <h3 class="research-item-title">포스코사이언스펠로…</h3>
  </article>

  <article class="research-item">
    <header class="research-item-header">
      <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/3c11db3e9f7daece43bba25c248a5b9fbbe910fc59ac695190e2d19e9704a2ee?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="서울연구원 로고" class="research-item-logo" />
      <div class="research-item-source"><a href="https://www.si.re.kr/">서울연구원</a></div>
    </header>
    <h3 class="research-item-title">2024년 NExt100 청…</h3>
  </article>
</section>
	
	</div>
</div>

<div class="bottom-bar">
	<div class="page-bar">
    <c:if test="${currentPage > 1}">
        <a href="?page=${currentPage - 1}&limit=20"><button>이전</button></a>
    </c:if>
    <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="?page=${i}&limit=20"><button>${i}</button></a>
    </c:forEach>
    <c:if test="${currentPage < totalPages}">
        <a href="?page=${currentPage + 1}&limit=20"><button>다음</button></a>
    </c:if>
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
            html += '<td><a href="detail?themeId=' + competition.themeId + 'id=' + competition.id + '">' + competition.title + '</a></td>';
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

  .username {
    flex-grow: 1;
  }

  .list-container {
    display: flex;
    position: relative;
    top: 40px;
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
	height: 500px;
	margin-top: 80px;
	width: 100px;
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

.page-bar a {
    text-decoration: none; /* 링크 밑줄 제거 */
}

.page-bar button {
    background-color: #f9f9f9; /* 버튼 배경색 */
    border: 1px solid #ccc; /* 테두리 */
    color: #333; /* 글자 색상 */
    padding: 8px 16px; /* 패딩 */
    margin: 4px; /* 마진 */
    border-radius: 4px; /* 모서리 둥글게 */
}

.page-bar button:hover {
    background-color: #e9e9e9; /* 마우스 호버시 색상 변경 */
}

  
  
  
  

/* 사이드 학술 연구정보 박스 */

  .research-info-container {
    background-color: #fff;
    display: flex;
    max-width: 183px;
    flex-direction: column;
    font-size: 13px;
    letter-spacing: -0.7px;
    padding: 29px 19px 18px;
  }

  .research-info-title {
    display: flex;
    flex-direction: column;
    position: relative;
    justify-content: center;
    align-items: start;
    overflow: hidden;
    aspect-ratio: 6.86;
    width: 180px;
    color: #f2675f;
    letter-spacing: -1.2px;
    padding: 4px 31px;
    font: 700 15px Inter, sans-serif;
  }

  .research-info-title-bg {
    position: absolute;
    inset: 0;
    height: 100%;
    width: 100%;
    object-fit: cover;
    object-position: center;
  }

  .research-item {
    padding-left: 10px;
    justify-content: center;
    border: 1px solid rgba(0, 131, 203, 1);
    border-top-width: 3px;
    display: flex;
    margin-top: 11px;
    flex-direction: column;
    padding: 11px 0;
    width: 140px;
    height: 80px;
    }
    
    
 .research-item-header {
    display: flex;
    gap: 7px;
    color: #3b3b3b;
    font-weight: 700;
    white-space: nowrap;
    line-height: 292%;
    width: 180px;
  }

  .research-item-logo {
    aspect-ratio: 1;
    object-fit: contain;
    object-position: center;
    width: 25px;
  }

  .research-item-source {
    font-family: Inter, sans-serif;
    flex-grow: 1;
    flex-basis: auto;
    margin: auto 0;
  }

  .research-item-title {
    color: #474747;
    font-family: Inter, sans-serif;
    font-weight: 400;
    line-height: 178%;
    margin-top: 11px;
  }
</style>


<%@ include file="../common/foot.jspf"%>