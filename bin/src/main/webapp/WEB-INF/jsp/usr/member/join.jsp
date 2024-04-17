<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="JOIN"></c:set>
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

.signup-container {
	border-radius: 30px;
	box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.25);
	background-color: rgba(249, 181, 99, 0.8);
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
	background-color: rgba(249, 181, 99, 0.8);
	align-items: start;
	justify-content: center;
	padding: 21px 60px;
}

@media ( max-width : 991px) {
	.input-field {
		max-width: 100%;
		padding: 0 20px;
		margin: auto;
		margin-top: 20px; /* 미디어 쿼리에서 margin-top 조정 */
	}
}

.input-field-top {
	border-radius: 10px 10px 0px 0px;
}

.input-field-bottom {
	border-radius: 0px 0px 10px 10px;
	border-top: none;
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

.user-info-field {
	font-family: Inter, sans-serif;
	border: 2px solid rgba(0, 0, 0, 0.2);
	background-color: #fff;
	align-items: start;
	justify-content: center;
	padding: 21px 59px;
}

@media ( max-width : 991px) {
	.user-info-field {
		max-width: 100%;
		padding: 0 20px;
	}
}

.user-info-field-top {
	border-radius: 10px 10px 0px 0px;
}

.gender-container {
	align-self: center;
	display: flex;
	margin-top: 10px;
	gap: 12px;
}

.gender-option {
	display: flex;
	flex: 1;
}

.signup-button {
	font-family: Inter, sans-serif;
	border-radius: 5px;
	background-color: #9a6c4b;
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

.input-icon {
	position: absolute;
	left: 0;
	width: 40px;
	aspect-ratio: 1;
	object-fit: contain;
	object-position: center;
}
</style>


<!-- lodash debounce -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script>
	let submitJoinFormDone = false;
	let validLoginId = "";

	function submitJoinForm(form) {
		if (submitJoinFormDone) {
			alert('처리중입니다');
			return;
		}
		form.loginId.value = form.loginId.value.trim();
		if (form.loginId.value == 0) {
			alert('아이디를 입력해주세요');
			return;
		}

		if (form.loginId.value != validLoginId) {
			alert('사용할 수 없는 아이디야');
			form.loginId.focus();
			return;
		}
		if (validLoginId == form.loginId.value) {
			return;
		}

		form.loginPw.value = form.loginPw.value.trim();
		if (form.loginPw.value == 0) {
			alert('비밀번호를 입력해주세요');
			return;
		}
		form.loginPwConfirm.value = form.loginPwConfirm.value.trim();
		if (form.loginPwConfirm.value == 0) {
			alert('비밀번호 확인을 입력해주세요');
			return;
		}
		if (form.loginPwConfirm.value != form.loginPw.value) {
			alert('비밀번호가 일치하지 않습니다');
			form.loginPw.focus();
			return;
		}
		form.name.value = form.name.value.trim();
		if (form.name.value == 0) {
			alert('이름을 입력해주세요');
			return;
		}
		form.nickname.value = form.nickname.value.trim();
		if (form.nickname.value == 0) {
			alert('닉네임을 입력해주세요');
			return;
		}
		form.email.value = form.email.value.trim();
		if (form.email.value == 0) {
			alert('이메일을 입력해주세요');
			return;
		}
		form.cellphoneNum.value = form.cellphoneNum.value.trim();
		if (form.cellphoneNum.value == 0) {
			alert('전화번호를 입력해주세요');
			return;
		}
		submitJoinFormDone = true;
		form.submit();
	}

	function checkLoginIdDup(el) {
		$('.checkDup-msg').empty();
		const form = $(el).closest('form').get(0);
		if (form.loginId.value.length == 0) {
			validLoginId = '';
			return;
		}
		$.get('../member/getLoginIdDup', {
			isAjax : 'Y',
			loginId : form.loginId.value
		}, function(data) {
			$('.checkDup-msg').html('<div class="mt-2">' + data.msg + '</div>')
			if (data.success) {
				validLoginId = data.data1;
			} else {
				validLoginId = '';
			}
		}, 'json');
	}

	const checkLoginIdDupDebounced = _.debounce(checkLoginIdDup, 600);
</script>
<div class="background_img"></div>
<main class="signup-container ">
	<div class=" input-field">
		<form class="" method="POST" action="../member/doJoin" onsubmit="submitJoinForm(this); return false;">
			<div>
				<input onkeyup="checkLoginIdDupDebounced(this);" name="loginId" class=" input mb-4 max-w-xs"
					placeholder="아이디를 입력해주세요" autocomplete="off" />
			</div>
			<div class="checkDup-msg mb-4"></div>
			<div>
				<input class="input max-w-xs mb-4" autocomplete="off" type="text" placeholder="비밀번호를 입력해주세요" name="loginPw" />
			</div>
			<!-- input-primary를 쓰면 파란색 테두리생김 -->
			<section class="user-info-container">
				<div>
					<div>
						<input class="input  mb-4  max-w-xs" autocomplete="off" type="text" placeholder="이름을 입력해주세요" name="name" />
					</div>
					<div>
						<input class="input  mb-4  max-w-xs" autocomplete="off" type="text" placeholder="닉네임을 입력해주세요" name="nickname" />
					</div>
					<div>
						<input class="input  mb-4  max-w-xs" autocomplete="off" type="text" placeholder="전화번호를 입력해주세요" name="cellphoneNum" />
					</div>
					<div>
						<input class="input  mb-4  max-w-xs" autocomplete="off" type="text" placeholder="이메일을 입력해주세요" name="email" />
					</div>
				</div>
			</section>
		</form>
		<div class="btns">
			<input class="btn signup-button " type="submit" value="가입" />
			<button class="btn signup-button" class="" type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</main>



<%@ include file="../common/foot.jspf"%>