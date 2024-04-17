<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../common/head.jspf"%>

<div class="list-container">
	<div class="list-board">
		<a href="#" class="list-board-item" style="background-color: #F9B563;">학술연구정보</a>
		<a href="#" class="list-board-item">학술행사</a> <a href="#"
			class="list-board-item">공모전</a>
	</div>

	<div class="list-items-container">
		<div class="list-items-section">

			<div class="">학술행사</div>
			<div class="">공모전</div>
			<div class="sort-options ">
				<form>
					<input type="radio" id="option1" name="options" value="option1">
					<button type="button" onclick="selectRadio('option1')">등록/수정일순</button>
					&nbsp; <input type="radio" id="option2" name="options"
						value="option2">
					<button type="button" onclick="selectRadio('option2')">조회순</button>
					&nbsp; <input type="radio" id="option3" name="options"
						value="option3">
					<button type="button" onclick="selectRadio('option3')">마감순</button>
					&nbsp; <input type="radio" id="option4" name="options"
						value="option4">
					<button type="button" onclick="selectRadio('option4')">제목순</button>
				</form>

				<script>
					function selectRadio(optionId) {
						document.getElementById(optionId).checked = true;
					}
				</script>

				<script>
					function selectRadio(optionId) {
						document.getElementById(optionId).checked = true;
					}
				</script>

				<script>
					function selectRadio(optionId) {
						document.getElementById(optionId).checked = true;
					}
				</script>

			</div>

			<form class="search-form">
				<!-- Search form -->
				<!-- Your search form HTML here -->
			</form>

<img src="https://attachment.hibrain.io/recruits/3469412/1713143906596/제목 없음.png" style="height: 1234px; width: 900px;">
		import * as React from "react";

interface FavoriteButtonProps {
  imageUrl: string;
  text: string;
}

const FavoriteButton: React.FC<FavoriteButtonProps> = ({ imageUrl, text }) => {
  return (
    <div className="overflow-hidden relative flex-col justify-center items-start self-end px-5 py-2.5 mt-10 w-40 text-sm tracking-tighter leading-3 whitespace-nowrap aspect-[5.52] text-neutral-700 max-md:pr-5">
      <img src={imageUrl} alt="" className="object-cover absolute inset-0 size-full" />
      {text}
    </div>
  );
};

interface InfoRowProps {
  label: string;
  value: string;
}

const InfoRow: React.FC<InfoRowProps> = ({ label, value }) => {
  return (
    <>
      <div className="justify-center items-start p-3 whitespace-nowrap border-t border-b border-solid bg-neutral-100 border-neutral-200 max-md:pr-5">
        {label}
      </div>
      <div className="justify-center items-start px-5 py-3.5 border-t border-b border-solid border-neutral-200 leading-[160%] text-neutral-700">
        {value}
      </div>
    </>
  );
};

function MyComponent() {
  const infoRows = [
    { label: "접수기간", value: "24.04.26 13:30 ~ 24.04.26 17:30" },
    { label: "관련 홈페이지", value: "바로가기" },
    { label: "총시상금", value: "무료" },
    { label: "1등 시상금", value: "공고문참고" },
    { label: "담당자 연락처", value: "031-759-9934" },
    { label: "담당자 이메일", value: "overseas@kntsc.kr" },
  ];

  return (
    <div className="flex flex-col">
      <header className="flex gap-5 justify-between px-5 w-full text-lg font-bold tracking-tighter whitespace-nowrap text-neutral-700 max-md:flex-wrap max-md:max-w-full">
        <h1>학술행사</h1>
        <img
          src="https://cdn.builder.io/api/v1/image/assets/TEMP/3f57394a9858181dfe370165ca0d823e0e1c75714a59d77a5c1e07bb4a7fe4c8?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
          alt=""
          loading="lazy"
          className="shrink-0 self-start mt-1 w-52 max-w-full aspect-[11.11]"
        />
      </header>
      <section className="flex flex-col pt-7 mt-2.5 w-full border-t-2 border-orange-300 border-solid max-md:max-w-full">
        <div className="flex gap-5 justify-between px-px w-full max-md:flex-wrap max-md:max-w-full">
          <article className="flex flex-col px-5">
            <h2 className="text-2xl font-bold tracking-tighter leading-7 text-zinc-900">
              한국비임상기술지원센터 웨비나
            </h2>
            <div className="flex justify-center items-center mt-4 max-md:pr-5">
              <img
                src="https://cdn.builder.io/api/v1/image/assets/TEMP/4b4d3c0b3dc5f1af72fd00ecebc19f8948b486a3bcc5bbc29f9e8984d45912b6?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
                alt=""
                loading="lazy"
                className="aspect-[7.69] w-[252px]"
              />
            </div>
          </article>
          <FavoriteButton imageUrl="https://cdn.builder.io/api/v1/image/assets/TEMP/946738d0c21d981c43f3521a578b3ee864baa212bc7d6a2433e25b40881c4e4f?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&" text="즐겨찾기" />
        </div>
        <div className="flex flex-col justify-center w-full text-sm tracking-tighter leading-5 text-neutral-700 max-md:max-w-full">
          {infoRows.map(({ label, value }, index) => (
            <div
              key={index}
              className="flex gap-0 justify-center pr-20 w-full max-md:flex-wrap max-md:pr-5 max-md:max-w-full"
            >
              <InfoRow label={label} value={value} />
            </div>
          ))}
        </div>
      </section>
      <div className="flex flex-col items-center px-16 pb-20 mt-11 w-full bg-slate-100 max-md:px-5 max-md:mt-10 max-md:max-w-full">
        <img
          src="https://cdn.builder.io/api/v1/image/assets/TEMP/9d0c542028057f20f2d45c75ba4004ec4f7ee9ad64ae8306ab3b4296555b3e30?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
          alt=""
          loading="lazy"
          className="w-full aspect-[0.69] max-w-[793px] max-md:max-w-full"
        />
      </div>
      <div className="flex justify-center items-center px-16 py-5 w-full tracking-tighter text-center border-t border-b border-solid bg-neutral-100 border-neutral-200 max-md:px-5 max-md:max-w-full">
        <div className="flex gap-5 max-md:flex-wrap">
          <div className="flex gap-1.5 text-sm font-bold leading-6 text-red-400 whitespace-nowrap">
            <img
              src="https://cdn.builder.io/api/v1/image/assets/TEMP/8bf3dbae441a450ed83ed9ea11926ce18226cff07cf2fc34d471b3a47b990eb8?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
              alt=""
              loading="lazy"
              className="shrink-0 w-5 aspect-square"
            />
            <div className="my-auto">주의</div>
          </div>
          <div className="flex-auto text-base leading-6 text-zinc-800 max-md:max-w-full">
            : 본 기관 지원시 별도의 첨부서류가 있을 수 있으므로,{" "}
            <span className="text-red-400">
              반드시 다음 원본 사이트에서 확인후 지원바랍니다.
            </span>{" "}
            <span className="font-bold text-zinc-800">
              원본사이트 바로가기 &gt;
            </span>
          </div>
        </div>
      </div>
      <FavoriteButton
        imageUrl="https://cdn.builder.io/api/v1/image/assets/TEMP/6ff9a027b4fb3813d3209f560ac250e1d063a5bb256a9d0fc4f0be72e0ddef89?apiKey=5f9b07e7533e43b894b4d1dc88cef4e5&"
        text="즐겨찾기"
        className="overflow-hidden relative flex-col justify-center items-start self-center px-14 py-6 mt-6 w-48 max-w-full text-xl font-bold tracking-tighter text-center whitespace-nowrap border border-solid aspect-[2.95] border-stone-300 leading-[60.04px] text-neutral-500 max-md:pr-5 max-md:pl-8"
      />
      <footer className="justify-center px-5 py-3.5 w-full text-lg font-bold tracking-tighter text-black whitespace-nowrap border-b border-solid border-neutral-600 max-md:max-w-full">
        장소/교통편
      </footer>
    </div>
  );
}
			</div>
		</div>
	</div>
	<div class="side-bar-container"></div>
</div>

<div class="bottom-bar">
	<div class="page-bar">
		<span><button><a href="" class="btn"><</a></button> </span>
		<button><a href="" class="btn">1</a></button>
		<button><a href="" class="btn">2</a></button>
		<button><a href="" class="btn">3</a></button>
		<span><button><a href="" class="btn">></a></button> </span>
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

/* Search Form */
.search-form {
	gap: 0.375rem;
	align-items: center;
	margin-top: 1.75rem;
}

.search-input {
	height: 1.5rem;
	border: 1px solid #cbd5e0;
}

.search-btn {
	padding: 0.375rem 0.625rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #fff;
	background-color: #f9fafb;
	border: none;
	border-radius: 0.25rem;
}

/* Category Filters */
.category-filters {
	display: flex;
	justify-content: left;
	align-items: center;
	padding: 0.25rem 0.5rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #4a5568;
	white-space: nowrap;
	border-top: 2px solid #ed8936;
}

.category-filters>span {
	padding: 5px 10px 5px 10px;
}

.category-item {
	display: flex;
	gap: 0.625rem;
	align-items: center;
}

.category-count {
	font-weight: bold;
	color: #3182ce;
}

/* Table */
.table-box {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.875rem 1.25rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #1a202c;
	white-space: nowrap;
	border-bottom: 1px solid #cbd5e0;
}

.table-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 0.625rem 0.875rem;
	font-size: 0.875rem;
	line-height: 1rem;
	color: #1a202c;
	white-space: nowrap;
	border-bottom: 1px solid #cbd5e0;
}

.list-table {
	background-color: #F9B563;
}

.list-table th {
	text-align: center;
}

.list-board-item {
	display: block;
	background-color: white;
	padding: 10px;
	border-radius: 5px;
}

/* 테이블 행 hover 시 배경색 변경 */
.table tbody tr:hover {
	background-color: #EAD8C0;
}

tr {
	justify-content: center;
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