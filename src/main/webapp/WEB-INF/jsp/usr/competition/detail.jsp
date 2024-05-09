<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../actual/path/to/javascript/file.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100'
	rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>


<script>
	const params = {};
	params.id = parseInt('${param.id}');
	params.themeId = parseInt('${param.themeId}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
	
</script>


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
		</a> <a href="../competition/list">
			<button class="hd_contest">공모전</button>
		</a> <a href="../member/myQuestion">
			<button class="hd_question">문의사항</button>
		</a>
		<c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;"
				class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>

<div class="list-container">
	<div class="list-board">
		<a href="../conference/list" class="list-board-item"
			style="background-color: #00256c; color: white;">학술연구정보</a> <a
			href="../conference/list" class="list-board-item">학술행사</a> <a
			href="../competition/list" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">
			<form class="search-form">
				<!-- Search form -->
				<!-- Your search form HTML here -->
			</form>
			<div class="list-items-section-box">
				<div style="font-size: 20px; margin-bottom: 10px;">공모전</div>
				<div class="detail-top-bar">
					<div style="font-size: 24px; margin-top: 10px;">${competition.title}</div>
					<ul class="top-bar-count">

						<li>조회수<span class="competition-detail__hit-count">${competition.hitCount}</span></li>


					</ul>
					<c:if test="${loggedInMemberId == 'admin' }">
						<li><a style="white-space: nowrap;" class="btn btn-outline"
							onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
							href="../competition/doDelete?id=${competition.id }">삭제</a></li>
					</c:if>
				</div>
				<table class="table">
					<tbody>
						<tr>
							<td>접수기간</td>
							<td>${competition.applicationPeriod}</td>
							<td>관련 홈페이지</td>
							<td><a href="${competition.homepage}">바로가기</a></td>
						</tr>
						<tr>
							<td>총시상금</td>
							<td>${competition.totalPrizeMoney}</td>
							<td>1등시상금</td>
							<td>${competition.firstPrizeMoney}</td>
						</tr>
						<tr>
							<td>담당자 연락처</td>
							<td><span>${competition.contactNum}</span></td>
							<td>담당자 이메일</td>
							<td>${competition.contactEmail}</td>


						</tr>
					</tbody>


					<!-- 추가적인 데이터 행들을 여기에 추가 -->

				</table>

				<div class="competition-body">
					<img src="${competition.imageURL}" alt="" loading="lazy" />
				</div>
				<div class="bookmark">
					<button id="likeButton" class="bookmark-button"
						onclick="doGoodReaction(${param.themeId}, ${param.id})">즐겨찾기</button>
				</div>
			</div>
		</div>
	</div>

	<div class="side-bar-container"></div>
</div>



<script>
window.onload = function() {
    var img = document.querySelector('.competition-body img');
    if (img.src === 'https://asset.hibrain.io/images/dist/icon/hbnloading.gif') {
        img.style.display = 'none'; // 이미지를 숨깁니다.
        var parentDiv = img.parentNode;
        var messageDiv = document.createElement('div'); // 메시지를 표시할 새 div를 생성합니다.
        messageDiv.textContent = '준비된 이미지가 없습니다';
        messageDiv.style.textAlign = 'center'; // 텍스트를 중앙에 정렬합니다.
        messageDiv.style.padding = '20px'; // 패딩을 추가합니다.
        parentDiv.appendChild(messageDiv); // 생성된 div를 부모 div에 추가합니다.
    }
}
</script>



<script>
<!-- 좋아요 싫어요 버튼	-->
function checkRP() {
	if(isAlreadyAddGoodRp == true){
		$('#likeButton').toggleClass('btn-outline');
	}else {
		return;
	}
}

function doGoodReaction(themeId, academyId) {
if(isNaN(params.memberId) == true){
		if(confirm('로그인 후 이용 가능합니다.')){
			var currentUri = encodeURIComponent(window.location.href);
			window.location.href = '../member/login?afterLoginUri=' + currentUri; // 로그인 페이지에 원래 페이지의 uri를 같이 보냄
		}
		return;
	} 

	$.ajax({
		url: '/usr/scrap/doGoodReaction',
		type: 'GET',
		data: {themeId: themeId, academyId: academyId},
		dataType: 'json',
		success: function(data){
			console.log(data);
			console.log('data.data1Name : ' + data.data1Name);
			console.log('data.data1 : ' + data.data1);
/* 			console.log('data.data2Name : ' + data.data2Name);
			console.log('data.data2 : ' + data.data2); */
			if(data.resultCode.startsWith('S-')){
				var likeButton = $('#likeButton');
				var likeCount = $('#likeCount');
			/* 	var DislikeButton = $('#DislikeButton');
				var DislikeCount = $('#DislikeCount'); */
				
				if(data.resultCode == 'S-1'){
					likeButton.toggleClass('btn-outline');
					likeCount.text(data.data1);
				}else if(data.resultCode == 'S-2'){
				/* 	DislikeButton.toggleClass('btn-outline');
					DislikeCount.text(data.data2); */
					likeButton.toggleClass('btn-outline');
					likeCount.text(data.data1);
				}else {
					likeButton.toggleClass('btn-outline');
					likeCount.text(data.data1);
				}
				
			}else {
				alert(data.msg);
			}
	
		},
		error: function(jqXHR,textStatus,errorThrown) {
			alert('좋아요 오류 발생 : ' + textStatus);

		}
		
	});
}

</script>


<!-- 조회수 -->
<script>
function CompetitionDetail__doIncreaseHitCount() {
    $.get('../competition/doIncreaseHitCountRd', {
        id : params.id,
        ajaxMode : 'Y'
    }, function(data) {
        $('.competition-detail__hit-count').empty().html(data.data1);
    }, 'json');
}

$(function() {
    setTimeout(CompetitionDetail__doIncreaseHitCount, 2000);
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

/* flex */
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

.list-items-section-box {
	margin-left: 250px;
	width: 1100px;
	height: 1400px;
}

.list-items-container {
	flex: 4;
	margin: 20px;
}

.list-board-item:hover, .list-board-item:active {
	background-color: #7E9DD9;
	/* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
	color: white;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
}

.side-bar-container {
	flex: 1;
}

/* Sorting Options */
.sort-options {
	gap: 0.75rem;
	margin-top: 1.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
}

.detail-top-bar {
	border-top: solid 2px #878787;
}

.top-bar-count {
	display: flex;
}

.top-bar-count>li {
	display: inline-block;
	margin-right: 20px;
}

.top-bar-count>li>span {
	margin-left: 5px;
}

/* Table */
.table {
	border-collapse: collapse;
	border-spacing: 0;
}

tr {
	justify-content: center;
}

.table td {
	border: 1px solid #dddddd;
	text-align: left;
	padding: 8px;
}

.competition-body {
	margin-top: 50px;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100%;
	/* 부모 요소의 높이에 따라 이미지를 세로 중앙 정렬합니다. */
}

.competition-body img {
	max-width: 100%;
	/* 이미지의 최대 너비를 부모 요소의 너비에 맞춥니다. */
	max-height: 100%;
	/* 이미지의 최대 높이를 부모 요소의 높이에 맞춥니다. */
}

.bookmark {
	text-align: center;
}

.bookmark-button {
	border: solid 1px black;
	border-radius: 10px;
	padding: 20px 60px;
}

.bookmark-button:hover {
	background-color: #7E9DD9;
	color: white;
}
</style>


<%@ include file="../common/foot.jspf"%>