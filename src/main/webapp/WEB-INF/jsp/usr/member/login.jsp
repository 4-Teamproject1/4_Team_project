<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Login"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<div class="background_img"></div>
<header class="header">
	<a href="../home/main">
	 <img src="https://velog.velcdn.com/images/vrslxowe/post/e1dec4f9-6a81-42cc-8a9d-745e8eb99584/image.png" alt="Logo Image" class="logo_img">
	</a>
</header>
<main class="login-container">
	<form action="../member/doLogin" method="POST">
		<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
		<div class="input-group">
			<span class="material-symbols-outlined">person</span>
			<input class="username-input max-w-xs" autocomplete="off" type="text" placeholder="아이디를 입력해주세요" name="loginId" />
		</div>
		<div class="input-group">
			<span class="material-symbols-outlined">lock</span>
			<input class="password-input max-w-xs" autocomplete="off" type="password" placeholder="비밀번호를 입력해주세요" name="loginPw" />
		</div>
		<input class="login_button" type="submit" value="로그인" />
	</form>
	<a href="#" class="forgot-password">아이디 찾기 / 비밀번호 찾기</a>
	<section class="signup-section">
		<p class="signup-text">아직 회원이 아니신가요?</p>
		<a href="../member/join" class="signup-link">회원가입</a>
		<button class="signup-link back" type="button" onclick="history.back();">뒤로가기</button>
	</section>
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

.logo_img {
	position: absolute;
	width: 100%;
	max-width: 120px;
    height: auto;
	left: 20px;
	top: 15px;
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

.login-container {
	width: 550px;
	height: 460px;
	margin: auto;
	padding-top: 4%;
	margin-top: 6%;
	background-color: #00256c;
	opacity: 0.8;
	color: rgba(0, 0, 0, 0.4);
	text-align: center;
	border-radius: 30px;
	box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.25);
}

.input-group {
	position: relative;
	display: inline-block;
}

.username-input, .password-input {
	position: relative;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: white;
	padding-left: 10%;
	justify-content: center;
	width: 450px;
	height: 64px;
}

.username-input {
	border-radius: 10px 10px 0px 0px;
}

.password-input {
	border-top: none;
	border-radius: 0px 0px 10px 10px;
}

.login_button {
	width: 170px;
	height: 60px;
	margin-top: 35px;
	color: white;
	background-color: #243F92; border-radius : 5px;
	justify-content: center;
	align-items: center;
	transition: background-color 0.3s, box-shadow 0.3s;
	border-radius: 5px;
}

.login_button:hover {
	background-color: #CBCBCB;
}

.login_button:active {
	background-color: #243F92;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.forgot-password {
	color: white;
	opacity: 0.9;
	align-self: end;
	margin-top: 23px;
}

.forgot-password:hover {
	color: pink;
	border-bottom: 1px solid pink;
}

.signup-section {
	position: relative;
	margin-top: 67px; color : white;
	opacity: 0.9;
	color: white;
}

.signup-text {
	margin-right: 7%;
}

.signup-link {
	margin-left: 10px;
}

.signup-text, .signup-link {
	display: inline-block;
}

.signup-link {
	-webkit-text-stroke: 0.3px rgba(0, 0, 0, 0.6);
	border: 0 solid rgba(0, 0, 0, 0.6);
}

.signup-link:hover {
	color: pink;
	border-bottom: 1px solid pink;
}

.signup-link.back:hover {
	color: pink;
	border-bottom: 1px solid pink;
}

/*아이콘*/
.material-symbols-outlined {
	font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
	position: absolute;
	top: 50%;
	transform: translateY(-50%);
	left: 10px;
	pointer-events: none;
	z-index: 3;
}

/* 뷰포트 조정 */
@media ( max-width : 991px) {
	.login-container {
		padding: 0 20px;
		margin: auto;
		margin-top: 40px; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

@media ( max-width : 991px) {
	.username-input, .password-input {
		flex-wrap: wrap;
		margin-top: 20px;
	}
}

@media ( max-width : 991px) {
	.login_button {
		max-width: 100%;
		padding: 0 20px;
	}
}

@media ( max-width : 991px) {
	.signup-section {
		margin-top: 40px;
	}
}
</style>
