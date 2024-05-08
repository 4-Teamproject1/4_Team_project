<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Join"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>



<div class="background_img"></div>
<header class="header">
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
</header>
<main class="signup-container">
	<div class="input-field">
		<form method="POST" action="../member/doJoin" onsubmit="submitJoinForm(this); return false;">
			<div class="input-group">
				<span class="material-symbols-outlined">person</span>
				<input onkeyup="checkLoginIdDupDebounced(this);" name="loginId" class="input input_id mb-4 max-w-xs"
					placeholder="아이디를 입력해주세요" autocomplete="off" />
			</div>
			<div class="checkDup-msg mb-4"></div>
			<div class="input-group">
				<span class="material-symbols-outlined">lock</span>
				<input class="input input_pw max-w-xs mb-4" autocomplete="off" type="text" placeholder="비밀번호를 입력해주세요" name="loginPw" />
			</div>
			<!-- input-primary를 쓰면 파란색 테두리생김 -->
			<div>
				<div class="input-group">
					<span class="material-symbols-outlined"> edit </span>
					<input class="input input_name mb-4  max-w-xs" autocomplete="off" type="text" placeholder="이름을 입력해주세요" name="name" />
				</div>
				<div class="input-group">
					<span class="material-symbols-outlined"> draw </span>
					<input class="input input_nikname mb-4  max-w-xs" autocomplete="off" type="text" placeholder="닉네임을 입력해주세요"
						name="nickname" />
				</div>
				<div class="input-group">
					<span class="material-symbols-outlined">phone_iphone</span>
					<input class="input input_pnum mb-4  max-w-xs" autocomplete="off" type="text" placeholder="전화번호를 입력해주세요"
						name="cellphoneNum" />
				</div>
				<div class="input-group input-group-email">
					<span class="material-symbols-outlined"> alternate_email </span>
					<input class="input input_email mb-4  max-w-xs" autocomplete="off" type="text" placeholder="이메일을 입력해주세요"
						name="email" />
				</div>
			</div>
			<div class="btns">
				<button class="signup-button" type="button" onclick="history.back();">뒤로가기</button>
				<input class="signup-button " type="submit" value="가입" />
			</div>
		</form>

	</div>
</main>


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

.signup-container {
	height: 660px;
	width: 550px;
	margin: auto;
	margin-top: 3%;
	background-color: #00256c;
	opacity: 0.8;
	color: rgba(0, 0, 0, 0.4);
	text-align: center;
	border-radius: 30px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.input-field {
	position: relative;
	top: 60px;
}

.input_id, .input_pw, .input {
	display: relative;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: white;
	padding-left: 10%;
	justify-content: center;
	width: 450px;
	height: 64px;
}

.input_id, .input_name {
	border-radius: 10px 10px 0px 0px;
}

.input_pw, .input_email {
	border-radius: 0px 0px 10px 10px;
	border-top: none;
}

.input_nikname, .input_pnum {
	border-radius: 0px 0px 0px 0px;
	border-top: none;
}

.input-group {
	position: relative;
	display: inline-block;
}

.input-group:nth-child(3) {
	margin-bottom: 20px;
}

.input-group-email {
	bottom: 20px;
}

.signup-button {
	width: 200px;
	height: 60px;
	margin-top: 47px;
	color: white;
	background-color: #243F92;
	border-radius: 5px;
	align-items: center;
	justify-content: center;
	transition: background-color 0.3s, box-shadow 0.3s;
	align-items: center;
}

.signup-button:hover {
	background-color: #CBCBCB;
}

.signup-button:active {
	background-color: #243F92;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

/*아이콘*/
.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	left: 10px;
	pointer-events: none;
}

/*뷰포트 조정*/
@media ( max-width : 991px) {
	.signup-container {
		padding: 0 20px;
		margin: auto;
		margin-top: 6%; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

@media ( max-width : 991px) {
	.input_id, .input_pw, .input {
		max-width: 100%;
		padding: 0 20px;
		margin: auto;
		margin-top: 20px; /* 미디어 쿼리에서 margin-top 조정 */
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
