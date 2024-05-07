<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Info"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<c:set var="loggedInMemberName" value="${rq.loginedMember.name}"></c:set>
<c:set var="loggedInMemberId" value="${rq.loginedMember.loginId}"></c:set>


<header class="header">
  <a href="../home/main">
    <button class="logo">로고</button>
  </a>
  <nav class="header_menu">
    <a href="../member/myInfo">
  <button class="username">${loggedInMemberName}님</button>
</a>

    <a href="../conference/list">
      <button class="hd_info">학회 정보</button>
    </a>
    <a href="../competition/list">
      <button class="hd_contest">공모전</button>
    </a>
    <a href="../member/myQuestion">
      <button class="hd_question">문의사항</button>
    </a>
    <c:if test="${rq.isLogined() }">
			<a onclick="if(confirm('로그아웃 하시겠어요?') == false) return false;" class="hd_logout" href="../member/doLogout">로그아웃</a>
		</c:if>
  </nav>
</header>

<div class="img"></div>
<div class="menu_box1 left">
	<div class="mypage">마이 페이지</div>
</div>
<div class="right">
	<a href="../member/mySchedule">
		<button class="menu_box2 myschedule">내 일정</button>
	</a>
	<a href="../member/myInfo">
		<button class="menu_box2 myinfo">내 정보</button>
	</a>
	<a href="../member/myQuestion">
		<button class="menu_box2 myquestion">내 문의</button>
	</a>
</div>

<div class="info_box info_name">
	<div class="info1">이름</div>
	<div class="info2">${rq.loginedMember.name }</div>
</div>

<div class="info_box info_id">
	<div class="info1">아이디</div>
	<div class="info2">${rq.loginedMember.loginId }</div>
</div>

<div class="info_box info_pw">
	<div class="info1">비밀번호</div>
	<button class="info2 pw_btn"><a href="../member/checkPw" >변경하기</a></button>
</div>

<div class="info_box info_pn">
	<div class="info1">핸드폰 번호</div>
	<div class="info2">${rq.loginedMember.cellphoneNum }</div>
</div>

<div class="info_box info_email">
	<div class="info1">이메일</div>
	<div class="info2">${rq.loginedMember.email }</div>
</div>


<button class="modify_btn"><a href="../member/checkPw" >수정하기</a></button>

<style>
body {
	width: 100%;
	hight: 130%;
	margin: 0;
	padding: 0;
}

.header {
	display: flex;
	position: absolute;
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
.header_menu button:hover {
    border-bottom: 1px solid;
}

.hd_logout {
	margin-top: 3.5px;
	font-size: 12.5px;
}
.hd_logout:hover {
    border-bottom: 1px solid;
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
	background:
		url('https://velog.velcdn.com/images/vrslxowe/post/ba2f5fd8-3c2c-4a9a-baa4-2d31c48be056/image.jpg')
		no-repeat;
	background-size: cover;
}

.menu_box1, .menu_box2 {
	border-radius: 18px;
	background: #00256c;
	color: white;
	text-align: center;
	display: inline-block;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.menu_box1 {
	width: 130px;
	height: 80px;
	font-size: 17px;
	line-height: 82px;
}

.menu_box2 {
	width: 110px;
	height: 70px;
	font-size: 16px;
	margin-right: 100px;
	line-height: 72px;
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
	gap: 100px;
	position: absolute;
	right: 112.5px;
	top: 165px;
}

.modify_btn {
	width: 110px;
	height: 70px;
	font-size: 16px;
	line-height: 72px;
	position: fixed;
	left: 50%;
	transform: translateX(-50%);
	bottom: 7%;
	border-radius: 18px;
	background: #00256c;
	color: white;
	text-align: center;
	box-shadow: 4px 4px 4px 0px rgba(0, 0, 0, 0.25);
}

.info_box {
	top: 300px;
	left: 25%;
	height: 87px;
	width: 1000px;
	position: relative;
	border-bottom-width: 1px;
	border-color: #878787;
}

.info1 {
	width: 160px;
	height: 87px;
	background: #7E9DD9;
	color: white;
	position: relative;
	display: flex;
	justify-content: center;
	align-items: center;
	text-align: center;
	border-bottom-width: 1px;
	border-color: #878787;
}

.info2 {
	top: -55px;
	left: 19%;
	width: 200px;
	position: relative;
}

.info_name {
	height: 89px;
	border-top-width: 2px;
	border-top-color: #535353;
}

.pw_btn {
	top: -65px;
	width: 95px;
	height: 38px;
	font-size: 14px;
	border-radius: 10px;
	background: #7E9DD9;
	color: white;
	box-shadow: 4px 3px 3px 0px rgba(0, 0, 0, 0.25);
}
</style>

<%@ include file="../common/foot.jspf"%>
=======
# 테스트 DB 생성
DROP DATABASE IF EXISTS acc_app_2024_04__test;
CREATE DATABASE acc_app_2024_04__test;
USE acc_app_2024_04__test;

# 개발 DB 생성
DROP DATABASE IF EXISTS acc_app_2024_04__dev;
CREATE DATABASE acc_app_2024_04__dev;
USE acc_app_2024_04__dev;

SELECT *
FROM `member`;

SELECT *
FROM `song`;
SELECT *
FROM `product`;

SELECT *
FROM `cart_item`;

SELECT *
FROM `cash_log`;

SELECT *
FROM `product_order`;

SELECT *
FROM `order_item`;

#####
DROP DATABASE IF EXISTS `batch_ex_24_04`;
CREATE DATABASE `batch_ex_24_04`;
USE `batch_ex_24_04`;

SHOW TABLES;

SELECT *
FROM product;

SELECT *
FROM rebate_order_item;


# 개선 - 2
SELECT ROI.order_item_id AS `주문 품목 번호`,
DATE(ROI.order_item_create_date) AS `주문 날짜`,
CONCAT(FORMAT(ROI.pay_price - ROI.refund_price,0),'원') AS `결제금액`,
ROI.product_name AS `상품명`,
ROI.product_option_color AS `색상`,
ROI.product_option_size AS `사이즈`,
ROI.quantity - ROI.refund_quantity AS `수량`
FROM rebate_order_item AS ROI
ORDER BY ROI.order_item_id ASC;

#####

DROP DATABASE IF EXISTS `Spring_AM_01`;
CREATE DATABASE `Spring_AM_01`;
USE `Spring_AM_01`;

# article 테이블 생성
CREATE TABLE article(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    title CHAR(100) NOT NULL,
    `body` TEXT NOT NULL
);

# member 테이블 생성
CREATE TABLE `member`(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    loginId CHAR(20) NOT NULL,
    loginPw CHAR(80) NOT NULL,
    `authLevel` SMALLINT(2) UNSIGNED DEFAULT 3 COMMENT '권한 레벨 (3=일반,7=관리자)',
    `name` CHAR(20) NOT NULL,
    nickname CHAR(20) NOT NULL,
    cellphoneNum CHAR(20) NOT NULL,
    email CHAR(50) NOT NULL,
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴 여부 (0=탈퇴 전, 1=탈퇴 후)',
    delDate DATETIME COMMENT '탈퇴 날짜'
);


# article TD 생성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목1',
`body` = '내용1';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목2',
`body` = '내용2';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목3',
`body` = '내용3';

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
title = '제목4',
`body` = '내용4';

# member TD 생성
# (관리자)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'admin',
loginPw = 'admin',
`authLevel` = 7,
`name` = '관리자',
nickname = '관리자',
cellphoneNum = '01012341234',
email = 'abcd@gmail.com';

# (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test1',
loginPw = 'test1',
`name` = '회원1',
nickname = '회원1',
cellphoneNum = '01043214321',
email = 'abcde@gmail.com';

# (일반)
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'test2',
loginPw = 'test2',
`name` = '회원2',
nickname = '회원2',
cellphoneNum = '01056785678',
email = 'abcdef@gmail.com';

ALTER TABLE article ADD COLUMN memberId INT(10) UNSIGNED NOT NULL AFTER updateDate;

UPDATE article
SET memberId = 2
WHERE id IN (1,2);

UPDATE article
SET memberId = 3
WHERE id IN (3,4);


# board 테이블 생성
CREATE TABLE board(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `code` CHAR(50) NOT NULL UNIQUE COMMENT 'notice(공지사항), free(자유), QnA(질의응답) ...',
    `name` CHAR(20) NOT NULL UNIQUE COMMENT '게시판 이름',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제 여부 (0=삭제 전, 1=삭제 후)',
    delDate DATETIME COMMENT '삭제 날짜'
);

# board TD 생성
INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'NOTICE',
`name` = '공지사항';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'FREE',
`name` = '자유';

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`code` = 'QnA',
`name` = '질의응답';

ALTER TABLE article ADD COLUMN boardId INT(10) UNSIGNED NOT NULL AFTER `memberId`;

UPDATE article
SET boardId = 1
WHERE id IN (1,2);

UPDATE article
SET boardId = 2
WHERE id = 3;

UPDATE article
SET boardId = 3
WHERE id = 4;

ALTER TABLE article ADD COLUMN hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 AFTER `body`;

# reactionPoint 테이블 생성
CREATE TABLE reactionPoint(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `point` INT(10) NOT NULL
);

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 1번 회원이 2번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'article',
relId = 2,
`point` = 1;

# 2번 회원이 1번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`point` = -1;

# 2번 회원이 2번 글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`point` = -1;

# 3번 회원이 1번 글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`point` = 1;

# article 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE article ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE article ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE article AS A
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON A.id = RP_SUM.relId
SET A.goodReactionPoint = RP_SUM.goodReactionPoint,
A.badReactionPoint = RP_SUM.badReactionPoint;

# reply 테이블 생성
CREATE TABLE reply (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    memberId INT(10) UNSIGNED NOT NULL,
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입 코드',
    relId INT(10) NOT NULL COMMENT '관련 데이터 번호',
    `body`TEXT NOT NULL
);

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 1';

# 2번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 2';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'article',
relId = 1,
`body` = '댓글 3';

# 3번 회원이 1번 글에 댓글 작성
INSERT INTO reply
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'article',
relId = 2,
`body` = '댓글 4';

# reply 테이블에 좋아요 관련 컬럼 추가
ALTER TABLE reply ADD COLUMN goodReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;
ALTER TABLE reply ADD COLUMN badReactionPoint INT(10) UNSIGNED NOT NULL DEFAULT 0;

# reactionPoint 테스트 데이터 생성
# 1번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 1번 회원이 2번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 1,
relTypeCode = 'reply',
relId = 2,
`point` = 1;

# 2번 회원이 1번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 1,
`point` = -1;

# 2번 회원이 2번 댓글에 싫어요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 2,
relTypeCode = 'reply',
relId = 2,
`point` = -1;

# 3번 회원이 1번 댓글에 좋아요
INSERT INTO reactionPoint
SET regDate = NOW(),
updateDate = NOW(),
memberId = 3,
relTypeCode = 'reply',
relId = 1,
`point` = 1;

# update join -> 기존 게시물의 good,bad RP 값을 RP 테이블에서 가져온 데이터로 채운다
UPDATE reply AS R
INNER JOIN (
    SELECT RP.relTypeCode,RP.relId,
    SUM(IF(RP.point > 0, RP.point, 0)) AS goodReactionPoint,
    SUM(IF(RP.point < 0, RP.point * -1, 0)) AS badReactionPoint
    FROM reactionPoint AS RP
    GROUP BY RP.relTypeCode, RP.relId
) AS RP_SUM
ON R.id = RP_SUM.relId
SET R.goodReactionPoint = RP_SUM.goodReactionPoint,
R.badReactionPoint = RP_SUM.badReactionPoint;

###############################################

SELECT * FROM article;

SELECT * FROM `member`;

SELECT * FROM `board`;

SELECT * FROM reactionPoint;

SELECT * FROM `reply`;



SELECT goodReactionPoint
FROM article 
WHERE id = 1

INSERT INTO article
(
    regDate, updateDate, memberId, boardId, title, `body`
)
SELECT NOW(),NOW(), FLOOR(RAND() * 2) + 2, FLOOR(RAND() * 3) + 1, CONCAT('제목_',RAND()), CONCAT('내용_',RAND())
FROM article;

SELECT IFNULL(SUM(RP.point),0)
FROM reactionPoint AS RP
WHERE RP.relTypeCode = 'article'
AND RP.relId = 3
AND RP.memberId = 1;


UPDATE article 
SET title = '제목5'
WHERE id = 5;

UPDATE article 
SET title = '제목11'
WHERE id = 6;

UPDATE article 
SET title = '제목45'
WHERE id = 7;

SELECT FLOOR(RAND() * 2) + 2

SELECT FLOOR(RAND() * 3) + 1


SHOW FULL COLUMNS FROM `member`;
DESC `member`;



SELECT LAST_INSERT_ID();

SELECT *
FROM article AS A
WHERE 1
AND boardId = 1
AND A.title LIKE CONCAT('%','0000','%')
OR A.body LIKE CONCAT('%','0000','%')
ORDER BY id DESC

SELECT COUNT(*)
FROM article AS A
WHERE 1
AND boardId = 1
AND A.title LIKE CONCAT('%','0000','%')
OR A.body LIKE CONCAT('%','0000','%')
ORDER BY id DESC


SELECT hitCount
FROM article
WHERE id = 374;

SELECT A.*
FROM article AS A
WHERE A.id = 1

SELECT A.*, M.nickname AS extra__writer
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
WHERE A.id = 1

# LEFT JOIN
SELECT A.*, M.nickname AS extra__writer, RP.point
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# 서브쿼리
SELECT A.*,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM (
    SELECT A.*, M.nickname AS extra__writer 
    FROM article AS A
    INNER JOIN `member` AS M
    ON A.memberId = M.id
    ) AS A
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;

# 조인
SELECT A.*, M.nickname AS extra__writer,
IFNULL(SUM(RP.point),0) AS extra__sumReactionPoint,
IFNULL(SUM(IF(RP.point > 0, RP.point, 0)),0) AS extra__goodReactionPoint,
IFNULL(SUM(IF(RP.point < 0, RP.point, 0)),0) AS extra__badReactionPoint
FROM article AS A
INNER JOIN `member` AS M
ON A.memberId = M.id
LEFT JOIN reactionPoint AS RP
ON A.id = RP.relId AND RP.relTypeCode = 'article'
GROUP BY A.id
ORDER BY A.id DESC;


SELECT *, COUNT(*)
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId

SELECT IF(RP.point > 0, '큼','작음')
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId

# 각 게시물의 좋아요, 싫어요 갯수
SELECT RP.relTypeCode, RP.relId,
SUM(IF(RP.point > 0,RP.point,0)) AS goodReactionPoint,
SUM(IF(RP.point < 0,RP.point * -1,0)) AS badReactionPoint
FROM reactionPoint AS RP
GROUP BY RP.relTypeCode,RP.relId



#학회 테이블 생성
CREATE TABLE `academy` (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`themeId` INT  NULL COMMENT '테마번호(학회/공모전)', 
	categoryId INT NOT NULL,
	`title`  VARCHAR(500) NULL,
	`hitCount`	INT	NULL,
	`eventPeriod` VARCHAR(500) NULL,
	`applicationPeriod`	 VARCHAR(500) NULL,
	`entryFee`	 VARCHAR(500) NULL ,
	`place`	 VARCHAR(500) NULL,
	`address`	 VARCHAR(500) NULL,
	`homepage`	 VARCHAR(500) NULL,
	`imageURL`	 VARCHAR(500) NULL,
	`regDate`    VARCHAR(100)  NULL COMMENT '등록날짜',
	`goodReactionPoint` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '스크랩수'
	
);
SELECT *
FROM `member`;

SELECT goodReactionPoint
FROM `academy`
WHERE id = 2
AND themeId =1;
 
SELECT *
FROM `academy`;

INSERT INTO `academy` (categoryId, title, hitCount, eventPeriod, applicationPeriod, entryFee, place, homepage, imageURL, regDate) 
VALUES (7, 'test학회1', 50, '2024-05-01', '2024-05-15', '10000원', '온라인', 'http://example.com', 'http://example.com/image.jpg', NOW());

INSERT INTO `academy` (categoryId, title, hitCount, eventPeriod, applicationPeriod, entryFee, place, homepage, imageURL, regDate) 
VALUES (7, 'test학회ㅈ', 50, '2024-05-01', '2024-05-15', '10000원', '온라인', 'http://example.com', 'http://example.com/image.jpg', DATE_ADD(NOW(), INTERVAL 2 DAY));


SELECT *
FROM `academy`
WHERE categoryId = 2
ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC;


SELECT *
FROM `academy`;


#공모전테이블 생성
CREATE TABLE `competition` (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`title`  VARCHAR(500) NULL,
	`themeId` INT  NULL COMMENT '테마번호(학회/공모전)', 
	`totalPrizeMoney` VARCHAR(500) NULL,
	`firstPrizeMoney` VARCHAR(500) NULL,
	`applicationPeriod`	 VARCHAR(500) NULL,
	`homepage`	 VARCHAR(500) NULL,
	`imageURL`	 VARCHAR(500) NULL,
	`contactNum`	 VARCHAR(500) NULL,
	`contactEmail`	 VARCHAR(500) NULL,
	`regDate`    VARCHAR(100)  NULL COMMENT '등록날짜',
	`goodReactionPoint` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '스크랩수'
);




SELECT *
FROM `competition`;

#호텔 테이블 생성
CREATE TABLE `hotel` (
	id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`imgURL` VARCHAR(500) NOT NULL,
	hotelName VARCHAR(500) NOT NULL,
	grade CHAR(100) NOT NULL,
	price CHAR(100) NOT NULL,
	service CHAR(100) NOT NULL,
	location CHAR(100) NOT NULL,
    href TEXT NOT NULL
);

DROP TABLE `hotel`;

SELECT *
FROM `hotel`;


CREATE TABLE scrap
(   id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `regDate` DATETIME NOT NULL COMMENT '찜 날짜', 
    `updateDate` DATETIME NOT NULL,
    `deleteDate` DATETIME NULL, 
    `memberId` INT(10) UNSIGNED NOT NULL COMMENT '회원 번호',
     themeId  INT(10) UNSIGNED NOT NULL  COMMENT '테마(학회/공모전) 번호',
    `academyId` INT(10) UNSIGNED NOT NULL  COMMENT '학회 번호', 
    `point` TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '스크랩 상태 찜 여부 (0=찜 취소, 1= 찜)'
);

SELECT *
FROM scrap;


DROP TABLE scrap;



CREATE TABLE inquiry(
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL , 
    updateDate DATETIME NOT NULL,
    memberId INT(10) NOT NULL,
    `body` VARCHAR(500) NOT NULL,
    title VARCHAR(500) NOT NULL
);

SELECT *
FROM inquiry;

DROP TABLE inquiry;

INSERT INTO
inquiry SET
regDate = NOW(),
updateDate = NOW(),
memberId = 2,
title = '123',
`body` = 'reqwrq';
>>>>>>> 069c959ff0c731b057eb9c0df1cbcf51586806c1
