<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="LOGIN"></c:set>
<%@ include file="../common/head.jspf"%>

<style>
.background_img {
	background-image:
		url('https://velog.velcdn.com/images/jungmoon2/post/e240172d-c361-4834-ad54-b3f0cc445542/image.png');
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
	margin: auto;
	border-radius: 30px;
	box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
	background-color: rgba(249, 181, 99, 0.8);
	display: flex;
	flex-direction: column;
	max-width: 550px;
	padding: 50px 48px;
	font-size: 20px;
	color: rgba(0, 0, 0, 0.4);
	font-weight: 400;
	text-align: center;
}

@media ( max-width : 991px) {
    .login-container {
        padding: 0 20px;
        margin: auto;
        margin-top: 40px; /* 미디어 쿼리에서 margin-top 조정 */
    }
}

.username-input, .password-input {
	display: flex;
	gap: 9px;
	padding: 10px 11px;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: #fff;
}

.username-input {
	border-radius: 10px 10px 0 0;
}

.password-input {
	border-top: none;
	border-radius: 0 0 10px 10px;
	padding: 7px 11px 13px;
}

@media ( max-width : 991px) {
	.username-input, .password-input {
		flex-wrap: wrap;
	}
}

.input-icon {
	width: 40px;
	aspect-ratio: 1;
	object-fit: contain;
	object-position: center;
}

.password-icon {
	align-self: start;
}

.input-label {
	font-family: Inter, sans-serif;
	flex-grow: 1;
	margin: auto 0;
}

.login-button {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: #9a6c4b;
	margin-top: 35px;
	padding: 19px 60px;
	color: rgba(0, 0, 0, 0.5);
	white-space: nowrap;
	justify-content: center;
	align-items: center;
}

@media ( max-width : 991px) {
	.login-button {
		max-width: 100%;
		padding: 0 20px;
	}
}

.forgot-password {
	color: rgba(0, 0, 0, 0.6);
	font-family: Inter, sans-serif;
	align-self: end;
	margin-top: 23px;
}

.signup-section {
	display: flex;
	gap: 9px;
	margin-top: 67px;
	align-self: center;
	color: rgba(0, 0, 0, 0.6);
}

@media ( max-width : 991px) {
	.signup-section {
		margin-top: 40px;
	}
}

.signup-text {
	font-family: Inter, sans-serif;
	flex-grow: 1;
}

.signup-link {
	font-family: Inter, sans-serif;
	text-decoration: underline;
	-webkit-text-stroke: 0.3px rgba(0, 0, 0, 0.6);
	border: 0 solid rgba(0, 0, 0, 0.6);
}
</style>

<!-- <div class="background_img"> -->
<!-- 	<img src="https://velog.velcdn.com/images/jungmoon2/post/e240172d-c361-4834-ad54-b3f0cc445542/image.png" alt="" /> -->
<!-- </div> -->
<div class="background_img"></div>

<main class="login-container">
	<form action="../member/doLogin" method="POST">
		<input type="hidden" name="afterLoginUri" value="${param.afterLoginUri }" />
		<div class="username-input">
			<img
				src="https://cdn.builder.io/api/v1/image/assets/TEMP/525021f3d702d64e0a0febcda6929d7262f8cefd84ffee578d2e4926a6810729?apiKey=a54dca681582431b82452a85866c4c07&"
				alt="Username icon" class="input-icon" />
			<input class="input-label input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
				placeholder="아이디를 입력해주세요" name="loginId" />
			<!--       <label for="username" class="input-label">아이디</label> -->
		</div>
		<div class="password-input">
			<img
				src="https://cdn.builder.io/api/v1/image/assets/TEMP/747f548bc5570840b614fcb7f856e7fe6085ae71d786ea4c811fd5f1c28503bd?apiKey=a54dca681582431b82452a85866c4c07&"
				alt="Password icon" class="input-icon password-icon" />
			<input class="input-label input-bordered input-primary w-full max-w-xs" autocomplete="off" type="text"
				placeholder="비밀번호를 입력해주세요" name="loginPw" />
			<!--       <label for="password" class="input-label">비밀번호</label> -->
		</div>
		<button type="submit" class="login-button">로그인</button>
	</form>
	<a href="#" class="forgot-password">아이디 찾기 / 비밀번호 찾기</a>
	<section class="signup-section">
		<p class="signup-text">아직 회원이 아니신가요?</p>
		<a href="#" class="signup-link">회원가입</a>
		<div class="">
			<button class="signup-link" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</section>
</main>



<%@ include file="../common/foot.jspf"%>