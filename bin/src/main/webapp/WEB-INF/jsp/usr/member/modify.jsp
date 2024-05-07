<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Login"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<script type="text/javascript">
	let MemberModify__submitFormDone = false;
	function MemberModify__submit(form) {
		if (MemberModify__submitFormDone) {
			return;
		}
		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value.length > 0) {
			form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
			if (form.loginPwConfirm.value.length == 0) {
				alert('비번 확인 써라');
				form.loginPwConfirm.focus();
				return;
			}
			if (form.loginPw.value != form.loginPwConfirm.value) {
				alert('비번 불일치');
				form.loginPw.focus();
				return;
			}
		}
		form.name.value = form.name.value.trim();
		form.nickname.value = form.nickname.value.trim();
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		form.email.value = form.email.value.trim();

		MemberModify__submitFormDone = true;
		form.submit();
	}

	// 가입일을 년월일 형식으로 변환하는 함수
	function formatDate(dateString) {
		const date = new Date(dateString);
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0');
		const day = String(date.getDate()).padStart(2, '0');
		return `${year}년 ${month}월 ${day}일`;
	}

	// 가입일을 년월일 형식으로 표시
	const regDateElement = document.getElementById('regDate');
	const regDate = '${rq.loginedMember.regDate }'; // 여기에 실제 가입일 데이터를 삽입
	regDateElement.textContent = formatDate(regDate);
</script>

<div class="background_img"></div>
<header class="header">
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
</header>

<div class="background_img"></div>
<section class="mt-8 text-xl px-4">
	<div class="modify-container">
		<form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">

			<div class="input_id_field">
				<div>
					아이디
					<br>${rq.loginedMember.loginId }</div>
			</div>

			<div class="user_container">
				<div class="new_pw_modify">새 비밀번호</div>
				<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text" placeholder="새 비밀번호를 입력해주세요"
					name="loginPw" />

				<div class="re_new_pw_modify">새 비밀번호 확인</div>
				<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text" placeholder="새 비밀번호 확인을 입력해주세요"
					name="loginPwConfirm" />

				<div class="name_modify">이름</div>
				<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text" name="name"
					value="${rq.loginedMember.name }" />

				<div class="nicname_modify">닉네임</div>
				<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text" name="nickname"
					value="${rq.loginedMember.nickname }" />

				<div class="pnum_modify">전화번호</div>
				<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text" name="cellphoneNum"
					oninput="this.value = this.value.replace(/[^0-9]/g, '')" value="${rq.loginedMember.cellphoneNum }" />

				<div class="email_modify">이메일</div>
				<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text" name="email"
					value="${rq.loginedMember.email }" />

				<div class="input_date_field">
					<div>
						가입일
						<br>${rq.loginedMember.regDate }</div>
				</div>

			</div>
			<input class="modify-btn" type="submit" value="수정" />
		</form>
		<button class="back-btn" type="button" onclick="history.back();">뒤로가기</button>
	</div>
</section>

<style>
body {
	font-size: 16px;
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
	background-color: white;
	border-radius: 7px;
	width: 40px;
	height: 30px;
}

.background_img {
	background-image:
		url('https://images.unsplash.com/photo-1540575467063-178a50c2df87?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
	background-size: cover;
	background-position: center;
	width: 100%;
	height: 100%;
	position: fixed;
	top: 0;
	left: 0;
	z-index: -1;
}

.modify-container {
	height: 800px;
	width: 600px;
	margin: auto;
	background-color: #00256c;
	opacity: 0.8;
	color: white;
	text-align: center;
	border-radius: 30px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.input_id_field, .input_date_field {
	position: relative;
	display: flex;
	width: 300px;
	border-radius: 10px;
	background-color: #7E9DD9;
	text-align: center;
	align-items: center;
	justify-content: center;
	border-radius: 10px;
}

.input_id_field {
	top: 30px;
	left: 25.4%;
	height: 80px;
}

.input_date_field {
	top: 10px;
	height: 50px;
}

.input-bordered {
	color: black;
	width: 300px;
	margin-bottom: 10px;
}

.user_container {
	position: relative;
	top: 40px;
	display: flex;
	width: auto;
	height: auto;
	border-radius: 10px;
	align-items: center;
	justify-content: center;
	margin-top: 13px;
	padding-bottom: 10px;
	flex-direction: column;
	border-radius: 10px;
	display: flex;
}

.back-btn, .modify-btn {
	position: relative;
	top: 70px;
	width: 200px;
	height: 60px;
	color: white;
	border-radius: 5px;
	background-color: #243F92;
	transition: background-color 0.3s, box-shadow 0.3s;
}

.back-btn:hover, .modify-btn:hover {
	background-color: #CBCBCB;
}

.back-btn:active, .modify-btn:active {
	background-color: #243F92;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.modify-btn {
	left: -20%;
}

.back-btn {
	top: -6.5px;
	left: 20%;
}

@media ( max-width : 991px) {
	.signup-container {
		padding: 0 20px;
		margin: auto;
		margin-top: 20px;
	}
}

@media ( max-width : 991px) {
	.input-field {
		max-width: 100%;
		padding: 0 20px;
		margin: auto;
		margin-top: 20px;
	}
}

@media ( max-width : 991px) {
	.user-info-container {
		max-width: 100%;
	}
}

@media ( max-width : 991px) {
	.signup-button {
		margin-top: 20px;
		margin-bottom: 10px;
		padding: 0 20px;
	}
}
</style>

<%@ include file="../common/foot.jspf"%>