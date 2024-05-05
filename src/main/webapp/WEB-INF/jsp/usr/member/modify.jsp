<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MEMBER MODIFY"></c:set>
<%@ include file="../common/head.jspf"%>
<!-- Member modify 관련 -->
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
	background-color: #7E9DD9;
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
	background-color: #7E9DD9;
	align-items: start;
	justify-content: center;
	padding: 21px 60px;
}

  .input-field div {
        color: white;  /* 글씨 색을 하얀색으로 설정 */
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
</script>

<div class="background_img"></div>
<section class="mt-8 text-xl px-4">
	<div class="signup-container">
		<form action="../member/doModify" method="POST" onsubmit="MemberModify__submit(this); return false;">
		
	
					<div class="input-field">
						<div>가입일</div>
						<div>${rq.loginedMember.regDate }</div>
					</div>
					<div class="input-field">
						<div><th>아이디</th>
						<td>${rq.loginedMember.loginId }</td>
						</div>
					</div>
					<div class="user-info-container">
					<div class="">
						새 비밀번호
						<div>
							<input class="input input-bordered w-full max-w-xs" autocomplete="off" type="text"
								placeholder="새 비밀번호를 입력해주세요" name="loginPw" />
						</div>
					</div>
					<tr>
						<th>새 비밀번호 확인</th>
						<div>
							<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text"
								placeholder="새 비밀번호 확인을 입력해주세요" name="loginPwConfirm" />
						</div>
					</tr>
					<tr>
						<th>이름</th>
						<div>
							<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이름을 입력해주세요" name="name" value="${rq.loginedMember.name }" />
						</div>
					</tr>
					<tr>
						<th>닉네임</th>
						<div>
							<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text"
								placeholder="닉네임을 입력해주세요" name="nickname" value="${rq.loginedMember.nickname }" />
						</div>
					</tr>
					<tr>
						<th>전화번호</th>
						<div>
							<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text"
								placeholder="전화번호를 입력해주세요" name="cellphoneNum" value="${rq.loginedMember.cellphoneNum }" />
						</div>
					</tr>
					<tr>
						<th>이메일</th>
						<div>
							<input class="input input-bordered  w-full max-w-xs" autocomplete="off" type="text"
								placeholder="이메일을 입력해주세요" name="email" value="${rq.loginedMember.email }" />
						</div>
					</tr>
					</div>
					<tr>
						<th></th>
						<td>
							<input class="signup-button" type="submit" value="수정" />
						</td>
					</tr>
	
		</form>
		<div class="btns">
			<button class="signup-button"type="button" onclick="history.back();">뒤로가기</button>
		</div>
	</div>
</section>



<%@ include file="../common/foot.jspf"%>