<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Main"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>

<script>

//이미지가 3초마다 자동으로 슬라이드 되도록 설정
  jQuery(document).ready(function($) {
    setInterval(function() {
      moveRight();
    }, 3000);
    var slideCount = $("#slider ul li").length;
    var slideWidth = $("#slider ul li").width();
    var slideHeight = $("#slider ul li").height();
    var sliderUlWidth = slideCount * slideWidth;
    $("#slider").css({
      width: slideWidth,
      height: slideHeight
    });
    $("#slider ul").css({
      width: sliderUlWidth,
      marginLeft: -slideWidth
    });
    // 슬라이더의 마지막 아이템을 첫번째로 이동
    $("#slider ul li:last-child").prependTo("#slider ul");
    //슬라이드 방향 설정
    function moveLeft() {
      $("#slider ul").animate({
        left: +slideWidth
      }, 200, function() {
        $("#slider ul li:last-child").prependTo("#slider ul");
        $("#slider ul").css("left", "");
      });
    }
    function moveRight() {
      $("#slider ul").animate({
        left: -slideWidth
      }, 200, function() {
        $("#slider ul li:first-child").appendTo("#slider ul");
        $("#slider ul").css("left", "");
      });
    }
    // 버튼 클릭 시 왼쪽과 오른쪽으로 슬라이드
    $("a.control_prev").click(function() {
      moveLeft();
    });
    $("a.control_next").click(function() {
      moveRight();
    });
  });
  </script>


<script>
document.addEventListener("DOMContentLoaded", function() {
	// 학회 목록에서 가져온 정보를 검색 상자에 넣는 함수
    const searchData = [
        <c:forEach var="conference" items="${conferences}" varStatus="status">
            '${conference.title}'<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
	
 	// 검색 결과를 표시할 검색 상자, input 선택
    const searchResultsContainer = document.querySelector('.search_results');
    const searchInput = document.querySelector('.SearchBoxTextEditor');
    const boxDateInput = document.querySelector('.box_date');
    
	// 학회 목록에서 가져온 회의 제목, 기간, 주소 배열
    const conferenceTitles = [
        <c:forEach var="conference" items="${conferences}" varStatus="status">
            '${conference.title}',
        </c:forEach>
    ];
    const conferenceEventPeriods = [
        <c:forEach var="conference" items="${conferences}" varStatus="status">
            '${conference.eventPeriod}',
        </c:forEach>
    ];
	// 주소가 없는 경우(null) 공백 할당
   const conferenceAddresses = [
        <c:forEach var="conference" items="${conferences}" varStatus="status">
            <c:choose>
                <c:when test="${not empty conference.address}">
                    '${conference.address}',
                </c:when>
                <c:otherwise>
                    '',
                </c:otherwise>
            </c:choose>
        </c:forEach>
    ];

   // 회의 제목, 기간, 주소 배열 데이터를 할당 
    const conferenceAddressesJS = [
        <c:forEach var="conference" items="${conferences}" varStatus="status">
            <c:choose>
                <c:when test="${not empty conference.address}">
                    '${conference.address}',
                </c:when>
                <c:otherwise>
                    '',
                </c:otherwise>
            </c:choose>
        </c:forEach>
    ];

	// 검색 결과 목록을 화면에 표시하고 사용자가 클릭하여 선택할 수 있도록 하는 함수
    function populateSearchResults() {
        searchResultsContainer.innerHTML = ''; // 이전 결과를 지우기
        searchData.forEach((item, index) => {
            const div = document.createElement('div');
            div.textContent = item;
            div.classList.add('search-result-item');
            div.addEventListener('click', function() {
                searchInput.value = this.textContent;
                searchResultsContainer.classList.remove('visible');
                // 클릭한 항목의 인덱스 가져오기
                const selectedIndex = conferenceTitles.indexOf(this.textContent);
                // 해당하는 학회의 날짜 가져오기
                const eventPeriod = conferenceEventPeriods[selectedIndex];
                const startDate = eventPeriod.split(' ~ ')[0]; // 물결 기호(~) 앞의 날짜만 추출
                // box_date 클래스를 가진 입력 필드에 startDate 설정
                boxDateInput.value = startDate;
                // 해당하는 학회의 address 가져오기
                const address = conferenceAddresses[selectedIndex];
                // box_end 클래스를 가진 입력 필드에 address 설정
                document.querySelector('.box_end').value = address;
            });
            searchResultsContainer.appendChild(div);
        });
    }


    // 초기에 검색 결과를 데이터로 채우기
    populateSearchResults();

    document.querySelector('.SearchBoxTextEditor').addEventListener('click', function() {
        searchResultsContainer.classList.add('visible'); // 검색 결과를 보여주기
    });

    document.body.addEventListener("click", function(event) {
        if (!event.target.closest(".search_box")) {
            searchResultsContainer.classList.remove("visible"); // 검색 상자 바깥 클릭 시 결과 숨기기
        }
    });
});
	//검색 목록에서 클릭한 학회의 검색결과가 입력되는 함수
  document.querySelectorAll('.search-result-item').forEach(function(item) {
      item.addEventListener('click', function() {
          searchInput.value = this.textContent; // 검색 입력값 설정
          searchResultsContainer.classList.remove('visible'); // 검색 결과 숨김

          const index = searchData.indexOf(this.textContent);
          const eventPeriod = "${conferences.get(index).eventPeriod}";

          document.querySelector('.box_date').value = eventPeriod;
      });
  });

  </script>


<script>
//주어진 날짜 문자열을 형식화하는 함수
function formatDate(dateString) { // 날짜와 시간을 공백 기준으로 분할
	   var parts = dateString.split(" "); // 시작일과 종료일을 "-"로 분할
	   var startEndDate = parts[0].split("~"); // 시작일과 종료일의 시간을 제외한 부분을 가져옴
	   var startDate = startEndDate[0];
	   var endDate = startEndDate[1]; // 변환된 날짜 형식 반환
	   return startDate + " ~ " + endDate;
	}

</script>

<script>
  document.querySelector('.box_date').addEventListener('click', function() {
	    // 현재 검색 상자에 입력된 텍스트를 가져옴
	    const searchText = document.querySelector('.SearchBoxTextEditor').value;
	    
	    // 해당 텍스트와 일치하는 학회의 인덱스 찾기
	    const index = searchData.indexOf(searchText);
	    
	    if (index !== -1) {
	        const eventPeriod = conferenceEventPeriods[index];
	     // 일치하는 학회가 있다면 eventPeriod 형식 "24.05.20 ~ 24.05.21" 을 "24.05.20" 과 "24.05.21" 로 분리
	        const dates = eventPeriod.split(' ~ ');

	        // 날짜를 두 줄로 표시하기 위한 줄바꿈 적용
	        if (dates.length === 2) {
	            this.value = `${dates[0]}\n${dates[1]}`;
	        } else {
	            this.value = '날짜 형식 오류';
	        }
	    } else {
	        this.value = '일치하는 학회 없음';
	    }
	});

  </script>


<div id="slider">
	<a href="#" class="control_next">＞</a>
	<a href="#" class="control_prev">＜</a>
	<ul>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/de3e50a4-860c-473b-bf03-c4896ec5d90c/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/f24773fc-db1f-413f-93bf-814723438bb6/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/a38a8761-4aa9-44df-9251-59e4b6837574/image.jpg'); background-size: cover; background-position: center;">
		</li>
		<li
			style="background-image: url('https://velog.velcdn.com/images/vrslxowe/post/7a82b78b-bc0a-43f6-9732-a6d71b439d96/image.jpg'); background-size: cover; background-position: center;">
		</li>
	</ul>
</div>

<a href="../home/main">
	 <img src="https://velog.velcdn.com/images/vrslxowe/post/e33e04bc-5aee-4d08-a809-a2ef540a5760/image.png" alt="Logo Image" class="logo_img">
	</a>

<div class="menu_right">
	<a href="../conference/list">
		<button class="menu_box2 academicEventList">학회 정보</button>
	</a>
	<a href="../hotel/recommendlist">
		<button class="menu_box2 recommend">숙박&교통</button>
	</a>
	<c:if test="${rq.isLogined() }">
		<a href="../member/myInfo">
			<button class="menu_box2 info">회원정보</button>
		</a>
	</c:if>
	<c:if test="${!rq.isLogined() }">
		<a href="../member/login">
			<button class="menu_box2 login">로그인</button>
		</a>
		<a href="../member/join">
			<button class="menu_box2 join">회원가입</button>
		</a>
	</c:if>
	<c:if test="${rq.isLogined() }">
		<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="menu_box2 logout" href="../member/doLogout">로그아웃</a>
	</c:if>
</div>

<div class="search_box">
	<form action="../hotel/searchList" method="POST">
		<input type="text" class="SearchBoxTextEditor" name="generalSearch" placeholder="참석하실 학회를 선택해주세요." autocomplete="off"
			value="" />
		<div class="search_results"></div>
		<div class="search_box1">
			<div class="search_box-1">
				<input type="text" class="box_start" name="startLocation" placeholder="출발장소" id="textInputStart" autocomplete="off"
					value="" />
				<input type="text" class="box_end" name="endLocation" placeholder="도착장소" autocomplete="off" id="textInputEnd"
					value="${not empty conference.address ? conferenceService.extractCityFromAddress(conference.address) : ''}" />

			</div>
			<div class="search_box-2">
				<input type="text" class="box_date" name="travelDate" placeholder="가는날" autocomplete="off" id="textInputDate"
					value="" />
				<div class="select_box">
					<select class="select select-bordered w-32 max-w-xs" name="numberOfPeople">
						<option disabled selected>인원 수</option>
						<option>1</option>
						<option>2</option>
						<option>3</option>
						<option>4</option>
						<option>5</option>
						<option>6</option>
						<option>7</option>
						<option>8</option>
					</select>
				</div>
			</div>
			<div class="search_btn btn">
				<button type="submit" class="button-style">검색</button>
			</div>
		</div>
	</form>
</div>


<div class="event-schedule">
	<a href="../conference/list">
		<button class="event-title">학술행사일정</button>
	</a>
	<div class="event-schedule-box">
		<c:forEach var="conference" items="${conferences}" varStatus="status">
			<c:if test="${status.index < 3}">
				<button class="event-description">
					<c:choose>
						<c:when test="${fn:length(conference.title) > 30}">
                        ${fn:substring(conference.title, 0, 30)} ㆍㆍㆍ
                    </c:when>
						<c:otherwise>
                        ${conference.title}
                    </c:otherwise>
					</c:choose>
					<div class="event-date">${conference.eventPeriod}</div>
				</button>
			</c:if>
		</c:forEach>
		<a href="../conference/list" class="event-more-button">더보기</a>
	</div>

</div>
<div class="event-schedule">
	<a href="../competition/list">
		<button class="event-title">공모전일정</button>
	</a>
	<div class="event-schedule-box">
		<c:forEach var="competition" items="${competitions}" varStatus="status">
			<c:if test="${status.index < 3}">
				<button class="event-description">
					${competition.title}
					<div class="event-date">${competition.applicationPeriod}</div>
				</button>
			</c:if>
		</c:forEach>
		<a href="../competition/list" class="event-more-button">더보기</a>
	</div>
</div>


<div class="team_project_box">
	<button class="hidden_btn btn" onclick="toggleContainer()">Contact Us</button>
<div class="member_profile_box">
	<div class="profile_left">
		<div class="first">
			<img class="profile_img"
				src="https://velog.velcdn.com/images/rhdmltjd123/post/4f013abb-0c12-4837-95fa-446769eabb40/image.jpg"
				alt="" />
			<div class="info_box">
				<div class="pro_name">
					<span class="material-symbols-outlined">id_card</span>
					<div>고의성</div>
				</div>
				<div class="pro_email">
					<span class="material-symbols-outlined">mail</span>
					<a href="mailto:rhdmltjd1324@gmail.com">rhdmltjd1324@gmail.com</a>
				</div>
				<div class="pro_pnum">
					<span class="material-symbols-outlined">call</span>
					<div>010-6245-9767</div>
				</div>
				<div class="pro_github">
					<a href="https://github.com/Gouiseong?tab=repositories" target="_blank">
						<img class="github_img"
							src="https://velog.velcdn.com/images/vrslxowe/post/970150e1-d395-4edf-b9c6-72cdf3900091/image.png" alt="" />
					</a>
				</div>
			</div>
		</div>
		<div class="secon">
			<img class="profile_img"
				src="https://velog.velcdn.com/images/vrslxowe/post/50d47acc-65bd-40a6-8edb-6108b538bd4f/image.jpg"
				alt="" />
			<div class="info_box">
				<div class="pro_name">
					<span class="material-symbols-outlined">id_card</span>
					<div>오지현</div>
				</div>
				<div class="pro_email">
					<span class="material-symbols-outlined">mail</span>
					<a href="mailto:ubis970420@gmail.com">ubis970420@gmail.com</a>
				</div>
				<div class="pro_pnum">
					<span class="material-symbols-outlined">call</span>
					<div>010-3397-2434</div>
				</div>
				<div class="pro_github">
					<a href="https://github.com/jihyeon2434?tab=repositories" target="_blank">
						<img class="github_img"
							src="https://velog.velcdn.com/images/vrslxowe/post/970150e1-d395-4edf-b9c6-72cdf3900091/image.png" alt="" />
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="profile_right">
		<div class="first">
			<img class="profile_img"
				src="https://velog.velcdn.com/images/vrslxowe/post/fb8178d1-4e44-4720-8024-1d355364d499/image.jpg"
				alt="" />
			<div class="info_box">
				<div class="pro_name">
					<span class="material-symbols-outlined">id_card</span>
					<div>정다운</div>
				</div>
				<div class="pro_email">
					<span class="material-symbols-outlined">mail</span>
					<a href="mailto:jungpro567@gmail.com">jungpro567@gmail.com</a>
				</div>
				<div class="pro_pnum">
					<span class="material-symbols-outlined">call</span>
					<div>010-7172-1453</div>
				</div>
				<div class="pro_github">
					<a href="https://github.com/JUNGmoon123?tab=repositories" target="_blank">
						<img class="github_img"
							src="https://velog.velcdn.com/images/vrslxowe/post/970150e1-d395-4edf-b9c6-72cdf3900091/image.png" alt="" />
					</a>
				</div>
			</div>
		</div>
		<div class="secon">
			<img class="profile_img"
				src="https://velog.velcdn.com/images/vrslxowe/post/c07c91d9-9d43-4fff-af95-f39340685622/image.jpg"
				alt="" />
			<div class="info_box">
				<div class="pro_name">
					<span class="material-symbols-outlined">id_card</span>
					<div>김선경</div>
				</div>
				<div class="pro_email">
					<span class="material-symbols-outlined">mail</span>
					<a href="mailto:vrslxowe@gmail.com">vrslxowe@gmail.com</a>
				</div>
				<div class="pro_pnum">
					<span class="material-symbols-outlined">call</span>
					<div>010-4167-5324</div>
				</div>
				<div class="pro_github">
					<a href="https://github.com/vrslxowe?tab=repositories" target="_blank">
						<img class="github_img"
							src="https://velog.velcdn.com/images/vrslxowe/post/970150e1-d395-4edf-b9c6-72cdf3900091/image.png" alt="" />
					</a>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>

<script>
    function toggleContainer() {
        var container = document.querySelector('.member_profile_box');
        if (container.style.display === 'none' || container.style.display === '') {
            container.style.display = 'block';
        } else {
            container.style.display = 'none';
        }
    }
</script>

<style type="text/css">

/* 공통 스타일 설정 */
*, *:before, *:after {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

html, body {
	height: 110%;
	position: absolute;
	margin: 0;
	padding: 0;
	/* 스크롤바 숨김 */
	scrollbar-width: none;
	-ms-overflow-style: none; /* Firefox, IE 10+ */
	background-color: #050A19;
	scrollbar-width: none
}

h1 {
	text-align: center;
	font-weight: 300;
}

.logo_img {
	position: absolute;
	width: 100%;
	max-width: 125px;
    height: auto;
	left: 20px;
	top: 15px;
}

/* 상단 오른쪽 메뉴 */
.menu_right {
	position: absolute;
	top: 15px;
	right: 4.5%;
	background-color: #00256c;
	color: white;
	width: 460px;
	height: 60px;
	border-radius: 10px;
	opacity: 0.9;
	text-align: center;
	justify-content: center;
	padding-top: 17px;
	letter-spacing: 40px;
	transition: background-color 0.3s, box-shadow 0.3s;
}

.menu_right .menu_box2:hover {
	text-decoration: underline; /* 마우스 올렸을 때 밑줄 */
}

.logout {
	letter-spacing: 1px;
	font-size: 12.5px;
}

/* 이미지 슬라이더 */
#slider {
	top: -20px;
	margin: 0;
	padding: 0;
	position: relative;
	overflow: hidden;
	margin: 20px auto 0 auto;
}

#slider ul {
	position: relative;
	margin: 0;
	padding: 0;
	height: 200px;
	list-style: none;
}

#slider ul li {
	width: 1920px;
	height: 600px;
	position: relative;
	display: block;
	float: left;
	margin: 0;
	padding: 0;
	text-align: center;
	background-size: contain;
}

a.control_prev, a.control_next {
	top: 40%;
	width: 50px;
	height: 50px;
	padding-top: 8px;
	position: absolute;
	display: block;
	color: #fff;
	font-weight: 600;
	font-size: 18px;
	text-align: center;
	justify-content: center;
	background: #2a2a2a;
	opacity: 0.6;
	z-index: 3;
	cursor: pointer;
}

a.control_prev:hover, a.control_next:hover {
	opacity: 1;
	-webkit-transition: all 0.2s ease;
}

a.control_prev {
	border-radius: 0 5px 5px 0;
}

a.control_next {
	right: 0;
	border-radius: 5px 0 0 5px;
}

.slider_option {
	position: relative;
	margin: 10px auto;
	width: 160px;
	font-size: 18px;
}

/* 메인 검색 영역 */
.search_box {
	position: absolute;
	top: 37%;
	left: 15%;
	width: 1108px;
	height: 240px;
	background-color: #00256c;
	opacity: 0.93;
	border-radius: 50px;
	margin-left: 100px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.8);
	z-index: 2;
}

.search_box1 {
	position: absolute;
	top: 120px;
	left: 554px;
	width: 1108px;
	height: 240px;
	transform: translate(-50%, -50%); /* 가운데 정렬을 위한 변환 */
	z-index: 1;
	display: flex; /* 내부 요소를 수평으로 정렬하기 위해 */
	align-items: center; /* 수직 정렬 */
	justify-content: center; /* 수평 정렬 */
	border-radius: 50px;
}

.SearchBoxTextEditor {
	position: absolute;
	top: -5px;
	left: 50%;
	width: 400px;
	height: 70px;
	padding: 10px;
	font-size: 16px;
	border-radius: 32px;
	transform: translate(-50%, -50%);
	background-color: orange;
	z-index: 5;
	left: 50%;
	width: 400px;
	height: 70px;
	padding: 10px;
	border-radius: 32px;
	transform: translate(-50%, -50%);
	background-color: orange;
}

.SearchBoxTextEditor, #textInput {
	background-color: white;
	padding-left: 20px;
}

/* 검색 결과 */
.search_results {
	position: absolute;
	top: 15%;
	left: 50%;
	transform: translateX(-50%);
	color: black;
	font-size: 16px;
	width: 800px;
	max-height: 400px;
	z-index: 10;
	background-color: white;
	border: 1px solid #ccc;
	border-radius: 12px;
	overflow-y: auto;
	display: none; /* Initially hide it */
	/* Hide scrollbar */
	scrollbar-width: none; /* Firefox */
	-ms-overflow-style: none; /* IE 10+ */
}

.search_results.visible {
	display: block;
}

.search_results div {
	padding: 25px;
	cursor: pointer;
}

.search_results div:hover {
	background-color: #f0f0f0;
}

.box_start, .box_end, .box_date {
	height: 55px;
	border-radius: 26px;
	font-size: 16px;
	margin-left: 70px;
	box-sizing: border-box;
	transform: translate(-30%, -50%);
}

.box_start, .box_end {
	position: fixed;
	top: 85px;
	left: 0;
	width: 300px;
	left: 21.5%;
	padding: 10px;
}

.box_start {
	order: 1; /* box_start를 두 번째로 나오도록 순서를 2로 설정 */
}

.box_end {
	margin-left: 428px; /* box_start와의 간격을 설정 */
	order: 2; /* box_end를 가장 먼저 나오도록 순서를 1로 설정 */
}

.search_box-2 {
	position: absolute;
	top: 160px;
	display: inline-block;
}

.box_date {
	position: relative;
	width: 400px;
	padding: 10px;
	left: -51px;
	order: 3;
}

.select_box {
	position: relative;
	top: -79px;
	left: 380px;
	order: 4; /* select를 네 번째로 나오도록 순서를 4로 설정 */
}

.search_btn {
	width: 400px;
	height: 15px;
	margin-top: 250px;
	font-size: 16px;
	border-radius: 30px;
	z-index: 6;
}

/* 하단 학회, 공모전 리스트 박스 */
.event-schedule {
	vertical-align: top;
	width: 700px;
	height: 350px;
	margin-top: 5%;
	margin-left: 8.3%;
	display: inline-block;
	color: E1E1E1;
	background-color: #4E597C;
	border-radius: 15px;
}

.event-schedule-container {
	text-align: center; /* 가운데 정렬 */
}

.event-title {
	position: relative;
	top: 15px;
	left: 15px;
	padding-left: 10px;
	width: 95%;
	color: white;
	text-align: left;
	padding-bottom: 10px;
	border-bottom: 2px solid white;
}

.event-schedule-box {
	display: flex; /* Use flexbox for alignment */
	flex-direction: column; /* Arrange items vertically */
	align-items: flex-start; /* Align items to the left */
	justify-content: space-between; /* Add space between items */
	position: relative;
	top: 45px;
	height: 200px;
}

.event-description {
	display: block;
	width: 95%;
	height: 25px;
	margin-left: 15px;
	padding-left: 10px;
	text-align: left;
	line-height: 9px;
	border-bottom: 1px solid #828282;
	margin-bottom: 25px;
}

.event-date, .event-date-2 {
	position: relative;
	color: #ABABAB;
	top: -9px;
	width: 300px;
	height: 25px;
	margin-left: 77%;
}

.event-more-button {
	display: inline-block;
	position: absolute;
	top: 100%;
	left: 37%;
	width: 120px;
	height: 55px;
	background-color: #243F92;
	color: white;
	border-radius: 40px;
	display: flex;
	text-align: center;
	align-items: center;
	justify-content: center;
}

/* 팀 프로젝트 조장 및 조원 프로필 */
.hidden_btn {
	position: relative;
	width: 100px;
	height: 50px;
	top: 650px;
	left: 46.5%;
}

.team_project_box {
	background-color: #050A19;
	height: 750px;
}

.member_profile_box {
	display: none;
 	position: relative;
	background-color: #5168A4;
	width: 1050px;
	height: 480px;
	top: 100px;
	left: 21.5%;
	border-radius: 25px;
 }
 
.profile_left {
	position: relative;
	top: 30;
	left: 15px;
}

.profile_right {
	position: relative;
	top: -370px;
	left: 535px;
}

.first, .secon {
	width: 500px;
	height: 200px;
	color: white;
	background-color: #00256C;
	border-radius: 25px;
}

.secon {
	position: relative;
	top: 20px;
}

.info_box {
	position: relative;
	top: -150px;
	left: 200px;
}

.profile_img {
	position: relative;
	top: 20px;
	left: 20px;
	width: 150px;
	height: 150px;
	border-radius: 120px;
}

.pro_name, .pro_email, .pro_pnum, .pro_github {
	position: relative;
	top: 25px;
	left: 30px;
	width: 150px;
	height: 50px;
}

.pro_github {
	top: -130px;
	left: 200px;
}

.github_img {
	width: 40px;
	height: 40px;
}

/* 반응형 디자인 조정 */
@media ( max-width : 991px) {
	.search_box_main {
		width: 80%; /*너비를 뷰포트의 80%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		left: 10%; /*왼쪽 여백을 뷰포트의 10%로 설정 */
	}
	.search_box {
		width: 90%; /*너비를 뷰포트의 90%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		left: 40%; /*왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.search_box_custom {
		padding: 0 20px; /*왼쪽과 오른쪽 여백을 설정 */
		width: 90%; /*너비를 뷰포트의 90%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		left: 46%; /*왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.box_start {
		padding: 0 20px; /*왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px); /*너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-right: 20px; /*오른쪽 여백 설정 */
		margin-left: 11%; /*왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left; /*왼쪽으로 플로팅 */
	}
	.box_end {
		padding: 0 20px; /*왼쪽과 오른쪽 여백을 설정 */
		width: calc(45% - 40px); /*너비를 뷰포트의 45%로 설정하고 좌우 여백을 고려하여 계산 */
		margin-left: 55%; /*왼쪽 여백을 뷰포트의 5%로 설정 */
		float: left; /*왼쪽으로 플로팅 */
	}
	.box_date {
		padding: 0 20px; /*왼쪽과 오른쪽 여백을 설정 */
		width: 38%; /*너비를 뷰포트의 40%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 11%;
		margin-top: 5%;
		clear: both;
		margin-top: 5%; /*float 요소 아래로 내려가게 함 */
	}
	.select_box {
		padding: 0 20px; /*왼쪽과 오른쪽 여백을 설정 */
		width: 80%; /*너비를 뷰포트의 90%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		margin-top: 10px;
		margin-left: -20%; /*왼쪽 여백을 뷰포트의 5%로 설정 */
	}
	.btn_box {
		padding: auto; /*왼쪽과 오른쪽 여백을 설정 */
		width: 90%; /*너비를 뷰포트의 90%로 설정 */
		margin: auto; /*가운데 정렬을 위해 자동 마진 설정 */
		margin-left: 25%;
		margin-top: 24%; /*위쪽 여백 조정 */
		clear: both; /*float 요소 아래로 내려가게 함 */
	}
}

@media ( max-width : 991px) {
	.event-schedule {
		padding: 0 20px;
	}
}

@media ( max-width : 991px) {
	.event-schedule-container {
		max-width: 100%;
	}
}

@media ( max-width : 991px) {
	.event-schedule-columns {
		align-items: stretch;
		flex-direction: column;
		gap: 0;
	}
}

@media ( max-width : 991px) {
	.event-column, .event-column-secondary {
		width: 100%;
		margin: auto;
	}
}

@media ( max-width : 991px) {
	.event-card {
		margin-top: 40px;
		max-width: 100%;
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.event-card-content {
		max-width: 100%;
		padding: 0 20px;
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.event-details {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.event-info {
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.event-more-button {
		margin-top: 40px;
		padding: 0 20px;
		white-space: initial;
	}
}

@media ( max-width : 991px) {
	.event-card-secondary {
		margin-top: 40px;
		max-width: 100%;
		padding: 0 20px;
		white-space: initial;
	}
}
</style>