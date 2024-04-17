<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #F9B563;">학술연구정보</a>
		<a href="#" class="list-board-item">학술행사</a>
		<a href="#" class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<form class="search-form">
				<!-- Search form -->
				<!-- Your search form HTML here -->
			</form>
			<div>
				<div>학술행사</div>
				<div class="detail-top-bar">
					<div>한국비임상기술지원센터 웨비나</div>
					<ul class="top-bar-count">
						<li>조회수</li>
						<li>즐겨찾기수</li>
					</ul>
				</div>

				<section className="flex flex-col pt-7 mt-2.5 w-full border-t-2 border-orange-300 border-solid max-md:max-w-full">
					<div className="flex gap-5 justify-between px-px w-full max-md:flex-wrap max-md:max-w-full">
						<article className="flex flex-col px-5">

							<div className="flex justify-center items-center mt-4 max-md:pr-5">
								<img
									src="https://cdn.builder.io/api/v1/image/assets/TEMP/4b4d3c0b3dc5f1af72fd00ecebc19f8948b486a3bcc5bbc29f9e8984d45912b6?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
									alt="" loading="lazy" className="aspect-[7.69] w-[252px]" />
							</div>
						</article>
						<FavoriteButton
							imageUrl="https://cdn.builder.io/api/v1/image/assets/TEMP/946738d0c21d981c43f3521a578b3ee864baa212bc7d6a2433e25b40881c4e4f?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
							text="즐겨찾기" />
					</div>

				</section>

				<table class="table">
					<tbody>
						<tr>
							<td>행사기간</td>
							<td>24.06.27 14:00 ~ 24.06.28 15:00</td>
							<td>접수기간</td>
							<td>24.04.15 ~ 24.05.31 자정</td>
						</tr>
						<tr>
							<td>참가비</td>
							<td>무료</td>
							<td>관련 홈페이지</td>
							<td>
								<a href="">바로가기</a>
							</td>
						</tr>
						<tr>
							<td>담당자 연락처</td>
							<td>
								<span>063-530-9432</span>
							</td>
							<td>담당자 이메일</td>
							<td>hj1234@1894.or.kr</td>
						</tr>
					</tbody>


					<!-- 추가적인 데이터 행들을 여기에 추가 -->

				</table>

				<div
					className="flex flex-col items-center px-16 pb-20 mt-11 w-full bg-slate-100 max-md:px-5 max-md:mt-10 max-md:max-w-full">
					<img
						src="https://cdn.builder.io/api/v1/image/assets/TEMP/9d0c542028057f20f2d45c75ba4004ec4f7ee9ad64ae8306ab3b4296555b3e30?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
						alt="" loading="lazy" className="w-full aspect-[0.69] max-w-[793px] max-md:max-w-full" />
				</div>
			</div>
		</div>
	</div>

	<div class="side-bar-container"></div>
</div>

<div class="bottom-bar">
	<div class="page-bar">
		<span>
			<button>
				<a href="" class="btn"><</a>
			</button>
		</span>
		<button>
			<a href="" class="btn">1</a>
		</button>
		<button>
			<a href="" class="btn">2</a>
		</button>
		<button>
			<a href="" class="btn">3</a>
		</button>
		<span>
			<button>
				<a href="" class="btn">></a>
			</button>
		</span>
	</div>
</div>





<style>
/* flex */
.list-container {
	display: flex;
}

.list-board {
	flex: 0.5;
}

.list-items-container {
	flex: 4;
	margin: 20px;
}

.side-bar-container {
	flex: 1;
	background-color: pink;
}


/* Sorting Options */
.sort-options {
	gap: 0.75rem;
	margin-top: 1.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
}

.detail-top-bar{

}

.top-bar-count{
	display: flex;
	background-color: red;
}

.top-bar-count > li{
	display:inline-block;
	background-color: yellow;
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

/* 하단 바 */
.bottom-bar {
	margin-top: 60px;
	border: solid 1px red;
	text-align: center;
}

.page-bar {
	background-color: yellow;
}

.page-bar>button {
	
}
</style>


<%@ include file="../common/foot.jspf"%>