<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="checkPw"></c:set>
<%@ include file="../common/head.jspf"%>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
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

.signup-container {
	border-radius: 30px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
	background-color: #7E9DD9;;
	display: flex;
	max-width: 550px;
	flex-direction: column;
	font-size: 20px;
	color: rgba(0, 0, 0, 0.4);
	font-weight: 400;
	text-align: center;
	margin: auto;
	margin-top: 20px;
	padding: 76px 51px;
}

@media ( max-width : 991px) {
	.signup-container {
		padding: 0 20px;
		margin: auto;
		margin-top: 20px; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

.input-field {
	font-family: Inter, sans-serif;
	border-radius: 10px;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: white;
	align-items: start;
	justify-content: center;
	padding: 21px 30px;
	margin-bottom: 30px;
}

@media ( max-width : 991px) {
	.input-field {
		max-width: 100%;
		padding: 0 20px;
		margin: auto;
		margin-top: 20px; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

.user-info-container {
	border-radius: 10px;
	display: flex;
	margin-top: 13px;
	padding-bottom: 10px;
	flex-direction: column;
}

@media ( max-width : 991px) {
	.user-info-container {
		max-width: 100%;
	}
}

.signup-button {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: white;
	align-self: center;
	margin-top: 47px;
	width: 300px;
	max-width: 100%;
	align-items: center;
	color: rgba(0, 0, 0, 0.5);
	justify-content: center;
	padding: 16px 60px;
}

@media ( max-width : 991px) {
	.signup-button {
		margin-top: 20px;
		margin-bottom: 10px;
		padding: 0 20px;
	}
}
</style>


<div class="background_img"></div>
<section class="signup-container">
	<div class="mx-auto">
		<form action="../member/doCheckPw" method="POST">

			<div class="input-field">
				<th>아이디</th>
				<div>${rq.loginedMember.loginId }</div>
			</div>
			<div>
				<th>비밀번호</th>
				<div>
					<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text"
						placeholder="비밀번호를 입력해주세요" name="loginPw" />
				</div>
			</div>
			<div>
				<th></th>
				<div>
					<input class="signup-button" type="submit" value="확인" />
				</div>
			</div>
		</form>
		<div class="btns">
			<button class="signup-button" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>