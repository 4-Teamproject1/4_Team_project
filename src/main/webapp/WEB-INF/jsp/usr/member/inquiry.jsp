<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Inquiry List"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<%@ include file="../common/toastUiEditorLib.jspf"%>
<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>

<script type="text/javascript">
	let InquiryWrite__submitFormDone = false;
	function InquiryWrite__submit(form) {
		if (InquiryWrite__submitFormDone) {
			return;
		}
		form.title.value = form.title.value.trim();
		if (form.title.value == 0) {
			alert('제목을 입력해주세요');
			return;
		}
		const editor = $(form).find('.toast-ui-editor').data(
				'data-toast-editor');
		const markdown = editor.getMarkdown().trim();
		if (markdown.length == 0) {
			alert('내용 써라');
			editor.focus();
			return;
		}
		form.body.value = markdown;
		InquiryWrite__submitFormDone = true;
		form.submit();
	}
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
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
	</nav>
</header>

<div class="img"></div>

<div class="menu_box left">
	<div class="mypage">문의사항</div>
</div>

<section class="question_box">
	<div class="question_container">
		<form action="../article/doinquirywrite" method="POST" onsubmit="InquiryWrite__submit(this); return false;">
			<input type="hidden" name="body">
			<table class="write-box table-box-1" border="1">
				<tbody>
					<tr>
						<th class="box_title">제목</th>
						<td><input class="input input-bordered" autocomplete="off" type="text" placeholder="제목을 입력해주세요" name="title" /></td>
					</tr>
					<tr>
						<th class="box_content">내용</th>
						<td>
							<div class="toast-ui-editor">
								<script type="text/x-template">
      </script>
							</div>
						</td>
					</tr>


					<tr>
						<th></th>
						<td>
							<button class="btn write_btn" type="submit" value="등록">등록</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
</section>

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

.img {
	position: absolute;
	width: 100%;
	height: 150px;
	left: 0;
	top: 57px;
	background:
		url('https://velog.velcdn.com/images/vrslxowe/post/ba2f5fd8-3c2c-4a9a-baa4-2d31c48be056/image.jpg')
		no-repeat;
	background-size: cover;
}

.menu_box {
	width: 130px;
	height: 80px;
	border-radius: 18px;
	background: #00256c;
	color: white;
	text-align: center;
	display: inline-block;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
	font-size: 17px;
	line-height: 82px;
}

.left {
	position: absolute;
	left: 112.5px;
	top: 155px;
}

.question_box {
	
}

.question_container {
	position: relative;
	top: 240px;
	left: 21%;
}

.input-bordered {
	width: 1000px;
}

.box_title, .box_content {
	display: block;
	border: 1px solid #C7CBCF;
	border-radius: 5px;
	width: 100px;
}
.box_title {
	height: 48.5px;
	line-height: 43.5px;
}
.box_content {
	margin-top:3px;
	height: 600px;
	line-height: 520px;
}

.write_btn {
	position: relative;
	width: 100px;
	height: 60px;
	top: 20px;
	left: 40%;
	border-radius: 18px;
	background-color: #00256c;
	color: white;
	text-align: center;
}

</style>
