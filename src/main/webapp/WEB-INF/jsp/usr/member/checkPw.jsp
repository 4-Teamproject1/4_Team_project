<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="check Password"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />


<div class="background_img"></div>
<header class="header">
	<a href="../home/main">
	 <img src="https://velog.velcdn.com/images/vrslxowe/post/e1dec4f9-6a81-42cc-8a9d-745e8eb99584/image.png" alt="Logo Image" class="logo_img">
	</a>
</header>

<div class="background_img"></div>
<section class="signup-container">
		<div class="title">비밀번호 변경하기
		<form action="../member/doCheckPw" method="POST">
			<div class="id_field">아이디<br>${rq.loginedMember.loginId }</div>
			<div class="change_pw">
				비밀번호 확인 <input class="pw_field"  name="loginPw"  autocomplete="off" type="password" placeholder="기존 비밀번호를 입력해주세요" />
			</div>
			<input class="signup-btn" type="submit" value="확인" />
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

.logo_img {
	position: absolute;
	width: 100%;
	max-width: 120px;
    height: auto;
	left: 20px;
	top: 15;
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
	height: 500px;
	width: 550px;
	margin: auto;
	margin-top: 3%;
	background-color: #00256c;
	opacity: 0.8;
	color: white;
	text-align: center;
	border-radius: 30px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
}
.title {
	position: relative;
	top: 50px;
	font-size: 19px;
}

.id_field {
	position: relative;
	display: flex;
	top: 0;
	width: 500px;
	height: 100px;
	font-size: 18px;
	border-radius: 10px;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: white;
	color: rgba(0, 0, 0, 0.7);
	justify-content: center;
	align-items: center;
	margin: 20px auto;
}

.pw_field {
	position: relative;
	display: flex;
	top: 15px;
	width: 500px;
	height: 70px;
	font-size: 17px;
	border-radius: 10px;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: white;
	color: rgba(0, 0, 0, 0.7);
	text-align: center;
	justify-content: center;
	align-items: center;
}

.change_pw {
	position: relative;
	display: flex;
	flex-direction: column;
	align-items: center;
	top: 20px;
}

.user-info-container {
	border-radius: 10px;
	display: flex;
	margin-top: 13px;
	padding-bottom: 10px;
	flex-direction: column;
}
.signup-btn, .back-btn {
	position: relative;
    top: 50px;
    left: 120px;
    width: 220px;
    height: 70px;
    font-size: 17px;
    background-color: #243F92;
    color: white;
    border-radius: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 20px auto;
    transition: background-color 0.3s, box-shadow 0.3s;
}
.signup-btn:hover {
	background-color: #CBCBCB;
}
.signup-btn:active {
	background-color: #243F92;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.back-btn {
	position: relative;
	left: -120px;
	top: -40px;
}
.back-btn:hover {
    background-color: #CBCBCB;
}

.back-btn:active {
    background-color: #243F92;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

@media ( max-width : 991px) {
	.signup-container {
		padding: 0 20px;
		margin: auto;
		margin-top: 20px; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

@media ( max-width : 991px) {
	.id_field {
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

<%@ include file="../common/foot.jspf"%>