<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- 필요한 JavaScript 라이브러리 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<!-- 폰트 스타일링을 위한 Google Fonts -->
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<!-- 로그인한 회원 정보 설정 -->
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>


<script>
//페이지에 대한 매개변수 정의
	const params = {};
	params.id = parseInt('${param.id}');
	params.themeId = parseInt('${param.themeId}');
	params.memberId = parseInt('${loginedMemberId}');
	
	console.log(params);
	console.log(params.memberId);
	console.log(params.themeId);
	console.log(params.id);
	var isAlreadyAddGoodRp = ${isAlreadyAddGoodRp};
</script>



<!-- 헤더 섹션 -->
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
		<a href="../hotel/recommendlist">
			<button class="hd_recommend">숙박&교통</button>
		</a>
		<c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>



<!-- 메인 콘텐츠 섹션 -->
<div class="list-container">
	<div class="list-board">
		<a href="../conference/list" class="list-board-item" style="background-color: #00256c; color: white;">학술연구정보</a>
		<a href="../conference/list" class="list-board-item">학술행사</a>
		<a href="../competition/list" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">
			<div class="list-items-section-box">
				<div style="font-size: 20px; margin-bottom: 10px;">학술행사</div>
				<div class="detail-top-bar">
					<div style="font-size: 24px; margin-top: 10px;">${conference.title}</div>
					<ul class="top-bar-count">
						<li>
							조회수
							<span class="conference-detail__hit-count">${conference.hitCount}</span>
						</li>

					</ul>
					<div class="delete_btn">
						<c:if test="${loggedInMemberId == 'admin' }">
							<a onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false;"
								href="../conference/doDelete?id=${conference.id }">삭제</a>
						</c:if>
					</div>
				</div>
				<table class="table">
					<tbody>
						<tr>
							<td>행사기간</td>
							<td>${conference.eventPeriod}</td>
							<td>접수기간</td>
							<td>${conference.applicationPeriod}</td>
						</tr>
						<tr>
							<td>참가비</td>
							<td>${conference.entryFee}</td>
							<td>관련 홈페이지</td>
							<td>
								<a href="${conference.homepage}">바로가기</a>
							</td>
						</tr>
						<c:if test="${not empty conference.place || not empty conference.address}">
							<tr>
								<td>장소</td>
								<c:choose>
									<c:when test="${not empty conference.place}">
										<td>${conference.place}</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
								<td>주소</td>
								<c:choose>
									<c:when test="${not empty conference.address}">
										<td>${conference.address}</td>
									</c:when>
									<c:otherwise>
										<td></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:if>
					</tbody>
				</table>
				<!-- 행사 이미지 -->
				<div class="competition-body">
					<img src="${conference.imageURL}" alt="" style="width: 800px; height: auto;" loading="lazy" />
				</div>
				<!-- 즐겨찾기 버튼 -->
				<div class="btn-box">
					<button id="likeButton" class="bookmark-button" onclick="doGoodReaction(${param.themeId}, ${param.id})">즐겨찾기</button>
				</div>
			</div>
		</div>
	</div>
</div>


<!-- 사이드바 섹션 -->
<div class="side-bar-container"></div>
</div>

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
			if(data.resultCode.startsWith('S-')){
				var likeButton = $('#likeButton');
				var likeCount = $('#likeCount');		
				if(data.resultCode == 'S-1'){
					likeButton.toggleClass('btn-outline');
					likeCount.text(data.data1);
				}else if(data.resultCode == 'S-2'){
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

<!-- 조회수 증가 관련 스크립트 -->
<script>
function ConferenceDetail__doIncreaseHitCount() {
    $.get('../conference/doIncreaseHitCountRd', {
        id : params.id,
        ajaxMode : 'Y'
    }, function(data) {
        $('.conference-detail__hit-count').empty().html(data.data1);
    }, 'json');
}

$(function() {
    setTimeout(ConferenceDetail__doIncreaseHitCount, 2000);
});

</script>



<style>
.body {
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
}

.list-items-section-box {
	margin-left: 220px;
	width: 1100px;
	height: 1400px;
}

.list-items-container {
	flex: 4;
	margin: 20px;
}

.delete_btn {
	position: relative;
	top: -100px;
	left: 1060px;
	width: 35px;
}

.delete_btn:hover {
	border-bottom: 1px solid;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
	width: 165px;
}

.list-board-item:hover, .list-board-item:active {
	background-color: #7E9DD9;
	/* 마우스를 올렸을 때와 클릭했을 때의 배경색 */
	color: white;
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
	height: 90px;
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
	height: auto;
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
	border: 3px solid;
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

/* 즐겨찾기 버튼 */
.btn-box {
	display: flex;
	justify-content: center;
	margin-top: 30px;
}
</style>

<%@ include file="../common/foot.jspf"%>