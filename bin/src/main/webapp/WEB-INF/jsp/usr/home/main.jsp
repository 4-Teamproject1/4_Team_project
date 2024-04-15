<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="MAIN"></c:set>
<%@ include file="../common/head.jspf"%>
<style>
/* 배경화면실험 */
/* 움직이는화면실행 */
*, *:before, *:after {
   box-sizing: border-box;
   margin: 0;
   padding: 0;
}

html, body {
   font-family: "Commissioner", sans-serif;
   line-height: 1.65;
   position: relative;
   /*     background-color: green; */
}

/* .slider { */
/*    height: 79vh; */
/*    width: 100vw; */
/*    background-color: #0a0908;   여기가 메인배경색 넣은 곳 */
/*    display: flex; */
/*    align-items: center; */
/*    justify-content: center; */
/*    color: black; */
/*    position: relative; */
/*    overflow: hidden; */
/*    transition: background-color 2s; */
/* } */
.slider {
   position: relative; /* 부모 요소에 대해 상대적인 위치 설정 */
   height: 79vh;
   width: 100vw;
   display: flex;
   align-items: center;
   justify-content: center;
   color: black;
   position: relative;
   overflow: hidden;
   transition: background-color 2s;
}

.slider .credits {
   position: absolute;
   top: 2rem;
   left: 2rem;
   line-height: 1.65;
   z-index: 10;
   max-width: 320px;
}

.slider .item .imgs {
   position: relative;
   width: 60%;
   padding-top: 60%;
}

.slider .item .imgs .grid {
   position: absolute;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   display: grid;
   grid-template-columns: repeat(12, 1fr);
   grid-template-rows: repeat(12, 1fr);
   grid-column-gap: 32px;
   grid-row-gap: 32px;
   transform: rotate(-20deg);
   opacity: 0.65;
}

.slider .item .imgs .grid .img {
   width: 100%;
   height: 100%;
   position: relative;
   will-change: transform, opacity;
}

.slider .item .imgs .grid .img img {
   position: absolute;
   top: 0;
   width: 100%;
   height: 100%;
   object-fit: cover;
   position: relative;
   -webkit-filter: contrast(110%) brightness(110%) saturate(130%);
   filter: contrast(110%) brightness(110%) saturate(130%);
}

.slider .item .content {
   position: absolute;
   z-index: 2;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   display: flex;
   align-items: center;
   justify-content: center;
   line-height: 1.15;
   font-size: 8rem;
   font-weight: 700;
}

.slider .item .content .wrap {
   text-align: center;
   text-shadow: 1px 1px 4px rgba(10, 9, 8, 0.2);
   width: 100%;
   max-width: 100%;
   line-height: 1;
}

.slider .item .content .wrap .letter {
   display: inline-block;
}

.slider .nav .next, .slider .nav .prev {
   height: 2rem;
   width: 2rem;
   position: absolute;
   top: calc(50% - 1rem);
   cursor: pointer;
   z-index: 3;
   transition: transform 0.3s;
}

.slider .nav .next {
   right: 2rem;
   background-image:
      url("data:image/svg+xml,%3C?xml version='1.0' encoding='utf-8'?%3E%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M 19 8 L 19 11 L 1 11 L 1 13 L 19 13 L 19 16 L 23 12 L 19 8 z' fill='white'/%3E%3C/svg%3E");
}

.slider .nav .next:hover {
   transform: translateX(0.5rem);
}

.slider .nav .prev {
   left: 2rem;
   background-image:
      url("data:image/svg+xml,%3C?xml version='1.0' encoding='utf-8'?%3E%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='white'%3E%3Cpath d='M 5 8 L 1 12 L 5 16 L 5 13 L 23 13 L 23 11 L 5 11 L 5 8 z' fill='white'/%3E%3C/svg%3E");
}

.slider .nav .prev:hover {
   transform: translateX(-0.5rem);
}

.slider .nav .explore-btn {
   z-index: 4;
   position: absolute;
   bottom: 2rem;
   left: calc(50% - 4rem);
   width: 8em;
   text-align: center;
   padding: 1rem 0;
   border: solid 2px white;
   background: transparent;
   color: white;
   transition: background-color 0.3s;
   cursor: pointer;
}

.slider .nav .explore-btn:hover {
   /*    color: #0a0908; */
   color: black;
   background: black;
}

.slider .item:not(.is-active) {
   opacity: 0;
   pointer-events: none;
}

/* 메인검색영역 */
.search_box_main {
   position: absolute; /* slider에 대해 절대적인 위치 설정 */
   top: 50%; /* 원하는 위치로 조절 */
   left: 50px; /* 원하는 위치로 조절 */
   width: 60%;
   height: 400px;
   background-color: #ffa500;
   background-color: rgba(255, 165, 0, 0.9); /* 배경색과 투명도 설정 */
   width: 50%;
   border-radius: 50px;
   margin-left: 24%;
   box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.4);
   z-index: 2; /* slider 위에 겹치도록 설정 */
}

.search_box {
   position: absolute; /* 절대적인 위치 설정 */
   top: 50%; /* 상단에서 50% */
   left: 50%; /* 왼쪽에서 50% */
   transform: translate(-50%, -50%); /* 가운데 정렬을 위한 변환 */
   z-index: 3;
   height: 60px;
}

.box_date, .select {
   margin-top: 60px; /* 원하는 만큼의 여백을 설정하여 요소를 밑으로 내립니다. */
}

.search_box_custom {
   position: absolute; /* 절대적인 위치 설정 */
   top: 50%; /* 상단에서 50% */
   left: 50%; /* 왼쪽에서 50% */
   transform: translate(-50%, -50%); /* 가운데 정렬을 위한 변환 */
   width: 20%; /* 너비 조정 */
   height: 60px;
   background-color: white;
   z-index: 3;
   display: flex; /* 내부 요소를 수평으로 정렬하기 위해 */
   align-items: center; /* 수직 정렬 */
   justify-content: center; /* 수평 정렬 */
}

.SearchBoxTextEditor {
   width: 350px; /* 부모 요소의 너비에 따라 너비를 조정합니다. */
   height: 40px; /* 높이 설정 */
   padding: 10px; /* 내부 여백 설정 */
   font-size: 16px; /* 글꼴 크기 설정 */
   box-sizing: border-box; /* padding을 포함하여 요소의 크기를 설정합니다. */
}
</style>

<div class="main_background">
   <div class="slider">
      <div class="nav">
         <div class="next" style=""></div>
         <div class="prev"></div>
      </div>
      <div class="item is-active">
         <div class="content">
            <img class="wrap" src="https://url.kr/prk3yu" alt="" />
         </div>
      </div>
      <div class="item">
         <div class="content">
            <img class="wrap" src="https://url.kr/lxz4iu" alt="" />
         </div>
      </div>
      <div class="item">
         <div class="content">
            <img class="wrap" src="https://url.kr/zxkg8d" alt="" />
         </div>
      </div>
      <div class="item">
         <div class="content">
            <img class="wrap" src="https://url.kr/u2brfm" alt="" />
         </div>
      </div>
   </div>
</div>

<div class="search_box_custom rounded">
   <div class=" ">
      <div class="">
         <input type="text" class="SearchBoxTextEditor " placeholder="어디로 떠나시나요?" id="textInput" value="">
      </div>
   </div>
</div>
<section>
   <div class="search_box_main">
      <div class="search_box ">
         <!--       <div class="box_start"> -->
         <!--          <input type="text" /> -->
         <!--          1 -->
         <!--       </div> -->
         <!--       <div class="box_end"> -->
         <!--          <input type="text" /> -->
         <!--          2 -->
         <!--       </div> -->
         <!--       <div class="box_date"> -->
         <!--          <input type="text" /> -->
         <!--          3 -->
         <!--       </div> -->
         <select class="select select-bordered select-xs w-32 max-w-xs">
            <option disabled selected>인원 수</option>
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
         </select>
      </div>
   </div>
</section>


<%@ include file="../common/foot.jspf"%>