<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Schedule"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<header class="header">
  <button class="logo">로고</button>
  <nav class="header_menu">
    <button class="username">abc123님</button>
    <button class="hd_info">학회 정보</button>
    <button class="hd_contest">공모전</button>
    <button class="hd_question">문의사항</button>
    <button class="hd_logout">로그아웃</button>
  </nav>
</header>

<div class="img"></div>
<div class="menu_box1 left">
  <div class="mypage">마이 페이지</div>
</div>
<div class="right">
  <div class="menu_box2 myschedule">내 일정</div>
  <div class="menu_box2 myinfo">내 정보</div>
  <div class="menu_box2 myquestion">내 문의</div>
</div>

<style>
  body {
    width: 100%;
    hight: 130%;
    margin: 0;
    /* 바깥 여백 설정 */
    padding: 0;
    /* 안쪽 여백 설정 */
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
  }

  .header_menu {
    display: flex;
    gap: 20px;
  }

  .username {
    flex-grow: 1;
  }

  .img {
    position: absolute;
    width: 100%;
    height: 150px;
    left: 0px;
    top: 57px;
    background: url('https://velog.velcdn.com/images/vrslxowe/post/1ddba4e8-b0c3-4c29-8ed7-332eb6c06820/image.jpg') no-repeat;
    background-size: cover;
    
  }

  .menu_box1,
  .menu_box2 {
    border-radius: 18px;
    background: #f9b563;
    text-align: center;
    display: inline-block;
    /* 인라인 블록으로 설정하여 요소들이 한 줄에 나타나도록 함 */
  }

  .menu_box1 {
    width: 130px;
    height: 80px;
    font-size: 19px;
    line-height: 80px;
  }

  .menu_box2 {
    width: 110px;
    height: 70px;
    font-size: 19px;
    margin-right: 100px;
    line-height: 75px;
  }

  .menu_box2:last-child {
    margin-right: 0;
    /* 마지막 요소의 오른쪽 마진 제거 */
  }

  .left {
    position: absolute;
    left: 112.5px;
    top: 155px;
  }

  .right {
    display: flex;
    position: absolute;
    right: 112.5px;
    top: 165px;
  }
</style>

<%@ include file="../common/foot.jspf"%>