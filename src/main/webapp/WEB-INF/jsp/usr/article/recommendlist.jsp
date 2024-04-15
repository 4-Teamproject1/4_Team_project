<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="#{board.code } ARTICLE LIST"></c:set>
<%@ include file="../common/head.jspf"%>

<style>

.outer-box{
  width: 100%;
display: flex;
  border: 3px solid;
}


.accommodation-nav {
  background-color: #f9b563;
  display: flex;
  max-width: 557px;
  align-items: center;
  font-size: 17px;
  color: #2a2a2e;
  font-weight: 500;
  justify-content: center;
  padding: 7px 60px;
}

@media (max-width: 991px) {
  .accommodation-nav {
    padding: 0 20px;
  }
}

.accommodation-nav-list {
  display: flex;
  width: 337px;
  max-width: 100%;
  align-items: center;
  gap: 20px;
  justify-content: space-between;
}

.accommodation-nav-divider {
  border: 1px solid rgba(0, 0, 0, 1);
  width: 1px;
  height: 46px;
}

.accommodation-nav-item {
  font-family: Inter, sans-serif;
  margin: auto 0;
}

.container {
	background-color: #fff;
	display: flex;
	flex-direction: column;
	align-items: start;
	color: #5a5b5b;
	font-weight: 400;
	padding: 30px 80px 80px 33px;
}

.container2 {
	background-color: #fff;
	display: flex;
	flex-direction: column;
	align-items: start;
	color: #5a5b5b;
	font-weight: 400;
	padding: 30px 80px 80px 33px;
  border: 3px solid;
}

@media ( max-width : 991px) {
	.container {
		padding: 0 20px;
	}
}

.header {
	align-self: stretch;
	display: flex;
	width: 100%;
	gap: 20px;
	color: #000;
	justify-content: space-between;
}

@media ( max-width : 991px) {
	.header {
		max-width: 100%;
		margin-right: 10px;
		flex-wrap: wrap;
	}
}

.logo {
	text-align: center;
	font: 23px Exo 2, sans-serif;
}

.user-info {
	display: flex;
	gap: 20px;
	font-size: 19px;
	justify-content: space-between;
}

.username {
	font-family: Inter, sans-serif;
}

.society-info, .inquiries, .logout {
	font-family: Inter, sans-serif;
}

.search-container {
	justify-content: center;
	align-items: start;
	border-radius: 18px;
	border: 1px solid rgba(115, 115, 115, 1);
	background-color: #f8f7f9;
	display: flex;
	width: 263px;
	max-width: 100%;
	flex-direction: column;
	font-size: 14px;
	color: #737373;
	margin: 176px 0 0 13px;
	padding: 12px 38px;
}

@media ( max-width : 991px) {
	.search-container {
		margin: 40px 0 0 10px;
		padding: 0 20px;
	}
}

.search-text {
	font-family: Inter, sans-serif;
	justify-content: center;
}

.accommodation-type {
	margin: 28px 0 0 21px;
	font: 700 14px/143% Inter, sans-serif;
}

@media ( max-width : 991px) {
	.accommodation-type {
		margin-left: 10px;
	}
}

.accommodation-list {
	display: flex;
	width: 247px;
	max-width: 100%;
	flex-direction: column;
	font-size: 12px;
	line-height: 180%;
	justify-content: center;
	margin: 18px 0 0 21px;
	padding: 4px 0;
}

@media ( max-width : 991px) {
	.accommodation-list {
		margin-left: 10px;
	}
}

.accommodation-item {
	justify-content: center;
	display: flex;
	flex-direction: column;
	padding: 4px 0;
}

.accommodation-option {
	display: flex;
	gap: 10px;
}

.checkbox {
	border-radius: 2px;
	border: 1px solid rgba(232, 232, 232, 1);
	background-color: #fff;
	width: 16px;
	height: 16px;
}

.accommodation-name {
	font-family: Inter, sans-serif;
	flex-grow: 1;
	flex-basis: auto;
	margin: auto 0;
}

/* 성급 기준*/
.image-wrapper1 {
	display: flex;
	max-width: 75px;
	flex-direction: column;
	justify-content: center;
}

.image {
	aspect-ratio: 5.88;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.image-wrapper2 {
	display: flex;
	max-width: 59px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper2 >.image {
	aspect-ratio: 4.55;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.image-container {
	width: 100%;
	max-width: 43px;
}

.product-image {
	aspect-ratio: 3.33;
	object-fit: auto;
	object-position: center;
	width: 100%;
	fill: #ffa726;
}

.image-wrapper4 {
	display: flex;
	max-width: 28px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper4 >.image {
	aspect-ratio: 2.33;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}

.image-wrapper5 {
	display: flex;
	max-width: 13px;
	flex-direction: column;
	justify-content: center;
}

.image-wrapper5 >.image {
	aspect-ratio: 1;
	object-fit: cover;
	width: 100%;
	fill: #ffa726;
}






.accommodation-nav {
  background-color: #f9b563;
  display: flex;
  max-width: 557px;
  align-items: center;
  font-size: 17px;
  color: #2a2a2e;
  font-weight: 500;
  justify-content: center;
  padding: 7px 60px;
}

@media (max-width: 991px) {
  .accommodation-nav {
    padding: 0 20px;
  }
}

.accommodation-nav-list {
  display: flex;
  width: 337px;
  max-width: 100%;
  align-items: center;
  gap: 20px;
  justify-content: space-between;
}

.accommodation-nav-divider {
  border: 1px solid rgba(0, 0, 0, 1);
  width: 1px;
  height: 46px;
}

.accommodation-nav-item {
  font-family: Inter, sans-serif;
  width: 100px;
  margin: auto 0;
    background-color: #f9b563;
}


.searchBox1{
  border: 3px solid green;
  width: 100%;
  height: 150px;
  display:flex;
  justify-content: center;
}

.searchBox2{
  border: 3px solid red;
 width: 100%;
  height: 150px;
  
   display:flex;
  justify-content: center;
}

.outer-searchBox{
  display: flex;
  border: 3px solid yellow;
   justify-content: center; /* 수평 가운데 정렬 */
  width: 100%;
  height: 400px;
  flex-direction: column; /* 요소들을 세로로 배치합니다. */
}

.searchClickBox{
  width: 400px;
  border: 3px solid pink;
}



  .container {
    widthL 300px;
    border-radius: 8px;
    border: 1px solid rgba(221, 223, 226, 1);
    background-color: #fff;
    display: flex;
    max-width: 965px;
    align-items: center;
    gap: 20px;
    font-size: 14px;
    font-weight: 500;
    line-height: 143%;
  }

  @media (max-width: 991px) {
    .container {
      flex-wrap: wrap;
    }
  }

  .sort-criteria {
    align-self: stretch;
    display: flex;
    gap: 0;
    padding: 0 20px;
  }

  .sort-label {
    font-family: Inter, sans-serif;
    justify-content: center;
    align-items: start;
    border-radius: 7px 0 0 7px;
    border-right: 1px solid rgba(221, 223, 226, 1);
    background-color: #f8f7f9;
    color: #737373;
    padding: 16px;
  }

  @media (max-width: 991px) {
    .sort-label {
      padding-right: 20px;
    }
  }

  .best-match {
    font-family: Inter, sans-serif;
    justify-content: center;
    background-color: #5392f9;
    color: #fff;
    text-align: center;
    padding: 16px 41px;
  }

  @media (max-width: 991px) {
    .best-match {
      padding: 0 20px;
    }
  }

  .divider {
    background-color: #dddfe2;
    width: 1px;
    height: 30px;
    margin: auto 0;
  }

  .guest-rating,
  .lowest-price {
    color: #2a2a2e;
    text-align: center;
    font-family: Inter, sans-serif;
    align-self: stretch;
    margin: auto 0;
  }

  .distance-container {
    align-self: stretch;
    display: flex;
    gap: 0;
    color: #2a2a2e;
    white-space: nowrap;
    text-align: center;
    margin: auto 0;
  }

  @media (max-width: 991px) {
    .distance-container {
      white-space: initial;
    }
  }

  .distance-image-wrapper {
    display: flex;
    flex-direction: column;
    font-family: Inter, sans-serif;
    position: relative;
    overflow: hidden;
    z-index: 10;
    aspect-ratio: 3.54;
    justify-content: center;
    margin: auto 0;
  }

  @media (max-width: 991px) {
    .distance-image-wrapper {
      white-space: initial;
    }
  }

  .distance-image {
    position: absolute;
    inset: 0;
    height: 100%;
    width: 100%;
    object-fit: cover;
    object-position: center;
  }

  .special-deal {
    color: #2a2a2e;
    text-align: center;
    font-family: Inter, sans-serif;
    align-self: stretch;
    flex-grow: 1;
    flex-basis: auto;
    margin: auto 0;
  }

</style>


  <header class="header">
  <div class="logo">로고</div>
  <div class="user-info">
    <span class="username">
      <span class="black-text">abc123</span>
      <span class="black-text">님</span>
    </span>
    <div class="society-info">학회정보</div>
    <div class="inquiries">문의사항</div>
    <div class="logout">로그아웃</div>
  </div>
</header>
<div class="outer-box">
  <div class="searchClickBox">
    <div class="container">

      <div class="search-container">
        <div class="search-text">텍스트 검색</div>
      </div>

      <div class="accommodation-type">숙소 종류</div>

      <div class="accommodation-list">
        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">아파트먼트 (50)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">서비스 아파트먼트 (4)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">호텔 (51)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">게스트하우스 / 비앤비 (5)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">모텔 (66)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">호스텔 (2)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">펜션 (9)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">프라이빗 하우스 (21)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">프라이빗 빌라 (4)</div>
          </div>
        </div>
      </div>

      <div class="accommodation-type">숙소 거리 기준</div>

      <div class="accommodation-list">
        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">역 근거리 기준 (50)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">버스정류장 근거리 기준 (4)</div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">터미널 근거리 기준 (51)</div>
          </div>
        </div>

      </div>

      <div class="accommodation-type">숙소 성급 기준</div>

      <div class="accommodation-list">
        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">
              <div class="image-wrapper1">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/c00140c5f4f915eecc6c973c5c54957a44fc3d09424f81da67aca0727c78a993?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="" class="image" />
                (50)
              </div>
            </div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">
              <div class="image-wrapper2">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/34f34578e4a29f61e50fb63dde5e2e72c599f1b34d735cc947a59d062c58be01?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="Decorative image" class="decorative-image" />
              </div>
              (4)
            </div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="image-container">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/79f9ed25195baf775e5e8e5a32e99f36f5135d9d0822bb57a29e8c51c1ce1926?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="Product Image" class="product-image" loading="lazy" />
              (4)
            </div>
          </div>
        </div>

        <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">
              <div class="image-wrapper4">
                <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/5625a76d5b98a0b8fb761b56091791718e2e83d4e9eac1e7ebd3caf630c798ad?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="Decorative image" class="image" />
                (51)
              </div>
            </div>
          </div>
        </div>

      </div>

       <div class="accommodation-item">
          <div class="accommodation-option">
            <input type="checkbox" class="checkbox" />
            <div class="accommodation-name">
            <div class="image-wrapper5">
              <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/e97d2a18dce70cbe646949b2afc52ad3e640111a2c9f908c36e467de6f7b6ecd?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="" class="image" />

              (51)
            </div>
            </div>
          </div>
        </div>

    </div>
  </div>

  <div class="outer-searchBox">
    <div class="searchBox1">
      <nav class="accommodation-nav">
        <ul class="accommodation-nav-list">

          <div tabindex="0" role="button" class="accommodation-nav-item btn m-1">숙소</div>
          <div class="dropdown">
            <div tabindex="0" role="button" class="accommodation-nav-item btn m-1">교통</div>
            <ul tabindex="0" class="dropdown-content z-[1] menu p-2 shadow bg-base-100 rounded-box w-52">
              <li><a>항공</a></li>
              <li><a>기차</a></li>
              <li><a>버스</a></li>
            </ul>
          </div>

        </ul>
      </nav>
    </div>

    <div class="searchBox2">
      <div class="container2">
        <div class="sort-criteria">
          <div class="sort-label">정렬 기준</div>
          <div class="best-match">BEST 매치</div>
          <div class="divider"></div>
        </div>
        <div class="guest-rating">투숙객 평점순</div>
        <div class="lowest-price">낮은 요금 먼저</div>
        <div class="distance-container">
          <div class="distance-image-wrapper">
            <img src="https://cdn.builder.io/api/v1/image/assets/TEMP/0e221abac785c502dcf4fbd21a15e1ada0c31e4e8f333cf90882bc96b4ad1a01?apiKey=f834c4360ac549c5b5237c00b19938c4&" alt="" class="distance-image" />
            거리
          </div>
          <div class="divider"></div>
        </div>
        <div class="special-deal">초특가 상품!</div>
      </div>
    </div>

  </div>

</div>






<%@ include file="../common/foot.jspf"%>