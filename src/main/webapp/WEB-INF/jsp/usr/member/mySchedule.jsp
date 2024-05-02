<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Schedule"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<div id="calendar"></div>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<script>
	!(function() {
		var today = moment();
		// 캘린더 생성자 함수 정의
		function Calendar(selector, events) {
			this.el = document.querySelector(selector);
			this.events = events;
			this.current = moment().date(1);
			this.draw();
			var current = document.querySelector(".today");
			if (current) {
				var self = this;
				window.setTimeout(function() {
					self.openDay(current);
				}, 500);
			}
			// 페이지 로드 시 이벤트를 모두 표시하는 함수 호출
			this.showAllEvents();
			// 스크롤 가능한 컨테이너 요소
			this.scrollContainer = this.el.querySelector(".scroll-container")
		}
		// 캘린더 다음 달로 이동 함수
		Calendar.prototype.nextMonth = function() {
			this.current.add("months", 1);
			this.next = true;
			this.draw();
			this.adjustScrollContainerPosition(); // 스크롤 컨테이너 위치 조정
		};
		// 캘린더 이전 달로 이동 함수
		Calendar.prototype.prevMonth = function() {
			this.current.subtract("months", 1);
			this.next = false;
			this.draw();
			this.adjustScrollContainerPosition(); // 스크롤 컨테이너 위치 조정
		};
		// 스크롤 컨테이너 위치 조정 함수
		Calendar.prototype.adjustScrollContainerPosition = function() {
			var self = this;
			// 월 전환 애니메이션이 완료된 후 조정되도록 지연
			setTimeout(function() {
				// 현재 월의 위치를 기반으로 새로운 위치 계산
				var calendarRect = self.el.getBoundingClientRect();
				var scrollContainerRect = self.scrollContainer
						.getBoundingClientRect();
				var newTop = scrollContainerRect.top - calendarRect.top;
				// 스크롤 컨테이너의 새로운 상단 위치 설정
				self.scrollContainer.style.top = newTop + "px";
			}, 500); // 애니메이션 기간에 맞춰 지연 조정
		};
		// 캘린더 그리기 함수
		Calendar.prototype.draw = function() {
			// 헤더 생성
			this.drawHeader();
			// 달 그리기
			this.drawMonth();
			// 스크롤 컨테이너의 내용을 지우기
			this.scrollContainer.innerHTML = '';
			// 현재 달의 이벤트들을 그리고 스크롤 컨테이너에 추가
			this.showAllEvents();
		};
		// 헤더 그리기 함수
		Calendar.prototype.drawHeader = function() {
			var self = this;
			if (!this.header) {
				// 헤더 요소 생성
				this.header = createElement("div", "header");
				this.header.className = "header";
				this.title = createElement("h1");
				var right = createElement("div", "right");
				right.addEventListener("click", function() {
					self.nextMonth();
				});
				var left = createElement("div", "left");
				left.addEventListener("click", function() {
					self.prevMonth();
				});
				// 요소 추가
				this.header.appendChild(this.title);
				this.header.appendChild(right);
				this.header.appendChild(left);
				this.el.appendChild(this.header);
				// 주단위 요일 이름 그리기 (추가)
				this.drawWeekdays();
			}
			this.title.innerHTML = this.current.format("MMM YYYY");
		};
		// 달 그리기 함수
		Calendar.prototype.drawMonth = function() {
			var self = this;
			// 이벤트를 각 날짜에 랜덤하게 배치
			this.events.forEach(function(ev) {
				ev.date = self.current.clone().date(
						Math.random() * (29 - 1) + 1);
			});
			// 이미 존재하는 경우 이전 달에 대한 처리
			if (this.month) {
				this.oldMonth = this.month;
				this.oldMonth.className = "month out "
						+ (self.next ? "next" : "prev");
				this.oldMonth
						.addEventListener(
								"webkitAnimationEnd",
								function() {
									self.oldMonth.parentNode
											.removeChild(self.oldMonth);
									self.month = createElement("div", "month");
									self.backFill();
									self.currentMonth();
									self.fowardFill();
									self.el.appendChild(self.month);
									window
											.setTimeout(
													function() {
														self.month.className = "month in "
																+ (self.next ? "next"
																		: "prev");
													}, 16);
								});
			} else {
				// 새로운 달 생성
				this.month = createElement("div", "month");
				this.el.appendChild(this.month);
				this.backFill();
				this.currentMonth();
				this.fowardFill();
				this.month.className = "month new";
			}
		};
		// 이전 달 채우기 함수
		Calendar.prototype.backFill = function() {
			var clone = this.current.clone();
			var dayOfWeek = clone.day();
			if (!dayOfWeek) {
				return;
			}
			clone.subtract("days", dayOfWeek + 1);
			for (var i = dayOfWeek; i > 0; i--) {
				this.drawDay(clone.add("days", 1));
			}
		};
		// 다음 달 채우기 함수
		Calendar.prototype.fowardFill = function() {
			var clone = this.current.clone().add("months", 1).subtract("days",
					1);
			var dayOfWeek = clone.day();
			if (dayOfWeek === 6) {
				return;
			}
			for (var i = dayOfWeek; i < 6; i++) {
				this.drawDay(clone.add("days", 1));
			}
		};
		// 현재 달을 그리는 함수
		Calendar.prototype.currentMonth = function() {
			var clone = this.current.clone();
			while (clone.month() === this.current.month()) {
				this.drawDay(clone);
				clone.add("days", 1);
			}
		};
		// 주 단위 요소를 생성하는 함수
		Calendar.prototype.getWeek = function(day) {
			if (!this.week || day.day() === 0) {
				this.week = createElement("div", "week");
				this.month.appendChild(this.week);
			}
		};
		// 주단위 요일 이름 배열
		var weekdays = [ "일", "월", "화", "수", "목", "금", "토" ];
		// 요일 레이블을 그리는 함수
		Calendar.prototype.drawWeekdays = function() {
			// 요일 행 요소 생성
			var weekdaysRow = createElement("div", "weekdays-row");
			// 각 요일에 대해 반복
			weekdays.forEach(function(weekday) {
				// 요일 레이블 요소 생성
				var weekdayLabel = createElement("div", "weekday-label",
						weekday);
				// 요일 행에 요일 레이블 추가
				weekdaysRow.appendChild(weekdayLabel);
			});
			// 캘린더 요소에 요일 행 추가
			this.el.appendChild(weekdaysRow);
		};
		// 날짜를 그리는 함수
		Calendar.prototype.drawDay = function(day) {
			var self = this;
			this.getWeek(day);
			// 날짜 외부 요소 생성
			var outer = createElement("div", this.getDayClass(day));
			outer.addEventListener("click", function() {
				self.openDay(this);
			});
			// 날짜
			var number = createElement("div", "day-number", day.format("DD"));
			// 이벤트
			var events = createElement("div", "day-events");
			this.drawEvents(day, events);
			outer.appendChild(number);
			outer.appendChild(events);
			this.week.appendChild(outer);
		};
		// 날짜에 해당하는 이벤트를 그리는 함수
		Calendar.prototype.drawEvents = function(day, element) {
			if (day.month() === this.current.month()) {
				var todaysEvents = this.events.reduce(function(memo, ev) {
					if (ev.date.isSame(day, "day")) {
						memo.push(ev);
					}
					return memo;
				}, []);
				todaysEvents.forEach(function(ev) {
					var evSpan = createElement("span", ev.color);
					var eventNameSpan = createElement("span", "event-name",
							ev.eventName); // 이벤트 이름을 포함하는 요소 생성
					evSpan.appendChild(eventNameSpan); // 이벤트 이름을 이벤트 동그라미 요소에 추가
					element.appendChild(evSpan);
				});
			}
		};
		// 날짜에 따라 클래스를 설정하는 함수
		Calendar.prototype.getDayClass = function(day) {
			classes = [ "day" ];
			if (day.month() !== this.current.month()) {
				classes.push("other");
			} else if (today.isSame(day, "day")) {
				classes.push("today");
			}
			return classes.join(" ");
		};
		// 페이지가 로드될 때 모든 이벤트를 표시하는 함수
		Calendar.prototype.showAllEvents = function() {
			var self = this;
			// 스크롤 가능한 컨테이너 생성
			var scrollContainer = createElement("div", "scroll-container");
			// 현재 월의 각 날짜에 대해 반복
			var daysInMonth = this.current.daysInMonth();
			for (var dayNumber = 1; dayNumber <= daysInMonth; dayNumber++) {
				var day = this.current.clone().date(dayNumber);
				var todaysEvents = this.events.filter(function(ev) {
					return ev.date.isSame(day, "day");
				});
				// 전체 월에 대한 이벤트 표시
				if (todaysEvents.length > 0) {
					// 날짜에 해당하는 이벤트를 함께 표시하기 위해 scrollContainer에 날짜도 추가
					var dayElement = createElement("div",
							"day-events-container");
					var dayNumberElement = createElement("div", "day-number",
							day.format("DD일"));
					dayElement.appendChild(dayNumberElement);
					self.renderEvents(todaysEvents, dayElement);
					scrollContainer.appendChild(dayElement);
					// 날짜 요소에 선 추가
					dayNumberElement.style.borderBottom = "1px solid #ccc";
					// 날짜 요소에 더 많은 상단과 하단 여백 추가
					dayNumberElement.style.paddingTop = "20px";
					dayNumberElement.style.paddingBottom = "20px";
					dayNumberElement.style.marginTop = "20px";
					dayNumberElement.style.marginBottom = "20px";
				}
			}
			// scrollContainer를 캘린더 요소의 자식 요소로 삽입
			this.el.appendChild(scrollContainer);
		};

		// 날짜를 클릭했을 때 상세 정보를 표시하는 함수
		Calendar.prototype.openDay = function(el) {
			var details;
			var dayNumber = +el.querySelector(".day-number").innerText
					|| +el.querySelector(".day-number").textContent;
			var day = this.current.clone().date(dayNumber);
			// 현재 열려 있는 디테일 창을 찾고 없으면 null 반환
			var currentOpened = document.querySelector(".details");
			// 클릭된 날짜에 디테일 창이 열려 있지 않은 경우에만 디테일 창 열기
			if (!currentOpened || currentOpened.parentNode !== el.parentNode) {
				// 이전에 열려 있던 디테일 창 있다면 닫기
				if (currentOpened) {
					//애니메이션이 종료시 디테일 창 제거
					currentOpened.addEventListener("animationend",
							function() {
								if (currentOpened.parentNode) {
									currentOpened.parentNode
											.removeChild(currentOpened);
								}
							});
					currentOpened.className = "details out";
				}
				// 새로운 디테일 창을 생성
				details = createElement("div", "details in");
				var eventsWrapper = createElement("div", "events");
				details.appendChild(eventsWrapper);
				// 디테일 창을 body 요소에 추가
				document.body.appendChild(details);
				// 클릭된 날짜에 해당하는 이벤트 찾기
				var todaysEvents = this.events.filter(function(ev) {
					return ev.date.isSame(day, "day");
				});
				// 클릭된 날짜의 이벤트 렌더링
				this.renderEvents(todaysEvents, eventsWrapper);
			}
		};
		// 이벤트 렌더링 함수
		Calendar.prototype.renderEvents = function(events, ele) {
			// 현재 상세 정보 요소에 있는 이벤트 제거
			var currentWrapper = ele.querySelector(".events");
			var wrapper = createElement("div", "events in"
					+ (currentWrapper ? " new" : ""));
			events
					.forEach(function(ev) {
						var div = createElement("div", "event");
						var square = createElement("div", "event-category "
								+ ev.color);
						var span = createElement("span", "", ev.eventName);
						div.appendChild(square);
						div.appendChild(span);
						wrapper.appendChild(div);
					});
			if (!events.length) {
				var div = createElement("div", "event empty");
				var span = createElement("span", "", "오늘 일정이 없습니다");
				div.appendChild(span);
				wrapper.appendChild(div);
			}
			if (currentWrapper) {
				currentWrapper.className = "events out";
				currentWrapper.addEventListener("animationend", function() {
					if (currentWrapper.parentNode) {
						currentWrapper.parentNode.removeChild(currentWrapper);
					}
				});
			}
			ele.appendChild(wrapper);
		};
		// 다음 달로 이동 함수
		Calendar.prototype.nextMonth = function() {
			this.current.add("months", 1);
			this.next = true;
			this.draw();
		};
		// 이전 달로 이동 함수
		Calendar.prototype.prevMonth = function() {
			this.current.subtract("months", 1);
			this.next = false;
			this.draw();
		};
		window.Calendar = Calendar;

		function createElement(tagName, className, innerText) {
			var ele = document.createElement(tagName);
			if (className) {
				ele.className = className;
			}
			if (innerText) {
				ele.innerText = ele.textContent = innerText;
			}
			return ele;
		}
	})();
	!(function() {
		var data = [ {
			eventName : "한일차세대학세미나",
			calendar : "conference",
			color : "blue"
		}, {
			eventName : "한국미디어문화학회 학술대회",
			calendar : "conference",
			color : "blue"
		}, {
			eventName : "국제성인역량조사(PIAAC) 학술대회",
			calendar : "conference",
			color : "blue"
		}, {
			eventName : "환태평양 정신의학회 학술대회",
			calendar : "conference",
			color : "blue"
		}, {
			eventName : "KT&G 상상실현 콘테스트",
			calendar : "contest",
			color : "gray"
		}, {
			eventName : "제6회 교육 공공데이터 분석·활용대회",
			calendar : "contest",
			color : "gray"
		}, {
			eventName : "CICA 미술관 국제전 “Drawing Now 2024” 공모",
			calendar : "contest",
			color : "gray"
		}, {
			eventName : "사하 수필공모전",
			calendar : "contest",
			color : "gray"
		} ];

		function addDate(ev) {
		}
		// draw 함수 내부
		Calendar.prototype.draw = function() {
			// 먼저 헤더를 표시
			this.drawHeader();
			// 그다음, 달을 표시
			this.drawMonth();
		};
		var calendar = new Calendar("#calendar", data);
	})();
</script>

<header class="header_logo">
	<a href="../home/main">
		<button class="logo">로고</button>
	</a>
	<nav class="header_menu">
		<a href="../member/myInfo">
			<button class="username">abc123님</button>
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
		<button class="hd_logout">로그아웃</button>
	</nav>
</header>

<div class="img"></div>
<div class="menu_box1 menu_left">
	<div class="mypage">마이 페이지</div>
</div>
<div class="menu_right">
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

<style type="text/css">
body {
	width: 100%;
	height: 112%;
	margin: 0;
	padding: 0;
}

.header_logo {
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

.hd_logout {
	font-size: 12.5px;
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

.menu_left {
	position: absolute;
	left: 112.5px;
	top: 155px;
}

.menu_right {
	display: flex;
	gap: 100px;
	position: absolute;
	right: 112.5px;
	top: 165px;
}

/* 캘린더 컨테이너 */
#calendar {
	position: absolute;
	top: 245px;
	left: 10%;
	width: 600px;
	height: 750px;
	margin: 0 auto 0;
}

/* 헤더 */
.header {
	padding: 20px 0 40px;
	height: 14px;
	width: 215px;
	text-align: center;
	position: relative;
	z-index: 2;
}

/* 헤더 제목 */
.header h1 {
	margin: 0px;
	padding: 10px;
	padding-left: 10px;
	margin-left: 35px;
	font-size: 1em;
	font-weight: bold;
	line-height: 0px;
	letter-spacing: 1px;
}

/* 네비게이션 화살표 */
.left, .right {
	position: absolute;
	width: 0;
	height: 0;
	top: 30px;
	margin-top: -7.5px;
	cursor: pointer;
}

/* 왼쪽 화살표 */
.left {
	border-width: 7.5px 10px 7.5px 0;
	border-color: transparent rgba(160, 159, 160, 1) transparent transparent;
	left: 40px;
}

/* 오른쪽 화살표 */
.right {
	border-width: 7.5px 0 7.5px 10px;
	border-color: transparent transparent transparent rgba(160, 159, 160, 1);
	right: 5px;
}

/* 새로운 월 애니메이션 */
.month.new {
	-webkit-animation: fadeIn 1s ease-out;
	opacity: 1;
}

/* 다음 월 애니메이션 */
.month.in.next {
	-webkit-animation: moveFromTopFadeMonth 0.4s ease-out;
	-moz-animation: moveFromTopFadeMonth 0.4s ease-out;
	animation: moveFromTopFadeMonth 0.4s ease-out;
	opacity: 1;
}

/* 다음 월 나가기 애니메이션 */
.month.out.next {
	-webkit-animation: moveToTopFadeMonth 0.4s ease-in;
	-moz-animation: moveToTopFadeMonth 0.4s ease-in;
	animation: moveToTopFadeMonth 0.4s ease-in;
	opacity: 1;
}

/* 이전 월 입장 애니메이션 */
.month.in.prev {
	-webkit-animation: moveFromBottomFadeMonth 0.4s ease-out;
	-moz-animation: moveFromBottomFadeMonth 0.4s ease-out;
	animation: moveFromBottomFadeMonth 0.4s ease-out;
	opacity: 1;
}

/* 이전 월 나가기 애니메이션 */
.month.out.prev {
	-webkit-animation: moveToBottomFadeMonth 0.4s ease-in;
	-moz-animation: moveToBottomFadeMonth 0.4s ease-in;
	animation: moveToBottomFadeMonth 0.4s ease-in;
	opacity: 1;
}

/* 날짜 */
.day {
	display: inline-block;
	width: 85.7px;
	height: 108.3px;
	padding: 10px;
	text-align: center;
	vertical-align: top;
	cursor: pointer;
	position: relative;
	z-index: 2;
	border-top: 1px solid #ccc;
}

/* 요일 */
.weekday-label {
	height: 50px;
	display: inline-block;
	width: 85.7px;
	padding: 10px;
	text-align: center;
	vertical-align: top;
	position: relative;
	z-index: 2;
}

/* 다른 달의 날짜 */
.day.other {
	color: #bfbfbf;
}

/* 오늘 날짜 */
.day.today {
	color: #8ab1fe;
}

/* 이벤트 날짜 */
.day-number {
	font-size: 20px;
	letter-spacing: 1.5px;
}

/* 날짜 이벤트 동그라미 위치 */
.day .day-events {
	margin-top: 13px;
	padding-top: 7px;
	margin-left: -8px;
	height: 48px;
	width: 79px;
	line-height: 6px;
	overflow: hidden;
	overflow-y: scroll;
	scrollbar-width: none;
	/* 스크롤바 숨김 */
	-ms-overflow-style: none;
	/* Firefox IE 10+ */
}

/* 이벤트 이름 스타일 */
.day .day-events span.event-name {
	font-size: 12px;
	color: black;
	margin-left: 13px;
	width: 30px;
	white-space: nowrap;
}

/* 캘린더 이벤트 동그라미 */
.day .day-events span {
	display: block;
	padding: 0;
	width: 8px;
	height: 8px;
	line-height: 5px;
	margin-bottom: 5px;
	border-radius: 5px;
}

/* 이벤트 카테고리 색상 */
.blue {
	background: #2D5DB9;
}

.gray {
	background: rgba(119, 119, 119, 1);
}

/* 세부 정보 컨테이너 */
.details {
	font-size: 8px;
	position: absolute;
	width: 415px;
	height: auto;
	top: 27.5%;
	left: 25%;
}

/* 이벤트 목록 */
.events {
/* position: relative;
    top: -20px; /* 위로 올리고 싶은 만큼의 값 */
    right: -20px; /* 우측으로 이동하고 싶은 만큼의 값 */ */
	height: auto;
	width: auto;
	padding: 7px 0;
	overflow-x: hidden;
	overflow-y: scroll;
	scrollbar-width: none;
	/* 스크롤바 숨김 */
	-ms-overflow-style: none;
	/* Firefox IE 10+ */
/* 	border: 3px solid red; */
}

/* 이벤트 목록 입장 애니메이션 */
.events.in {
	-webkit-animation-delay: 0.3s;
	-moz-animation-delay: 0.3s;
	animation-delay: 0.3s;
}

.events.in {
	-webkit-animation: fadeIn 0.3s ease both;
	-moz-animation: fadeIn 0.3s ease both;
	animation: fadeIn 0.3s ease both;
}

/* 이벤트 목록 나가기 애니메이션 */
.details.out .events {
	-webkit-animation: fadeOutShrink 0.4s ease both;
	-moz-animation: fadeOutShink 0.4s ease both;
	animation: fadeOutShink 0.4s ease both;
}

/* 이벤트 목록 나가기 애니메이션 */
.events.out {
	-webkit-animation: fadeOut 0.3s ease both;
	-moz-animation: fadeOut 0.3s ease both;
	animation: fadeOut 0.3s ease both;
}

/* 스크롤 가능한 영역에 스타일 적용 */
.scroll-container {
	position: absolute;
	top: 9%;
	left: 950px;
	width: 450px;
	max-height: 500px;
	/* 필요한 만큼 최대 높이 조정 */
	overflow-y: scroll;
	scrollbar-width: none;
	/* 스크롤바 숨김 */
	-ms-overflow-style: none;
	/* Firefox IE 10+ */
}

/* 이벤트 */
.event {
	font-size: 16px;
	line-height: 22px;
	letter-spacing: 0.5px;
	padding: 2px 16px;
	vertical-align: top;
}

/* 빈 이벤트 */
.event.empty {
	color: #777;
}

/* 이벤트 카테고리 */
.event-category {
	height: 10px;
	width: 10px;
	display: inline-block;
	margin: 6px 0 0;
	vertical-align: top;
	border-radius: 10px;
}

/* 이벤트 텍스트 */
.event span {
	display: inline-block;
	padding: 0 0 0 7px;
}

/* 이벤트 동그라미 */
.legend {
	position: absolute;
	bottom: 0;
	width: 100%;
	height: 30px;
	background: rgba(60, 60, 60, 1);
	line-height: 30px;
}

/* 이벤트 동그라미 항목 */
.entry {
	position: relative;
	padding: 0 0 0 25px;
	font-size: 13px;
	line-height: 30px;
	background: transparent;
}

/* 이벤트 동그라미 아이콘 */
.entry:after {
	position: absolute;
	content: "";
	height: 5px;
	width: 5px;
	top: 12px;
	left: 14px;
}

/* 회색 이벤트 아이콘 */
.entry.gray:after {
	background: rgba(119, 119, 119, 1);
}

/* 파란색 이벤트 아이콘 */
.entry.blue:after {
	background: #7E9DD9;
}

  /* 애니메이션 */
  /*화면 위에서 아래로 이동하면서 페이드 인되는 애니메이션(WebKit(Chrome, Safari 등)에서 작동)*/
  @-webkit-keyframes moveFromTopFade {
    from {
      opacity: 0.3;
      height: 0px;
      margin-top: 0px;
      -webkit-transform: translateY(-100%);
    }
  }

  /*화면 위에서 아래로 이동하면서 페이드 인되는 애니메이션*/
  @-webkit-keyframes moveToTopFade {
    to {
      opacity: 0.3;
      height: 0px;
      margin-top: 0px;
      opacity: 0.3;
      -webkit-transform: translateY(-100%);
    }
  }

  /*화면 위에서 위로 이동하면서 페이드 아웃되는 애니메이션(월별)*/
  @-webkit-keyframes moveToTopFadeMonth {
    to {
      opacity: 0;
      -webkit-transform: translateY(-30%) scale(0.95);
    }
  }

  /* 화면 아래에서 위로 이동하면서 페이드 인되는 애니메이션(월별)*/
  @-webkit-keyframes moveFromTopFadeMonth {
    from {
      opacity: 0;
      -webkit-transform: translateY(30%) scale(0.95);
    }
  }

  /* 화면 위에서 아래로 이동하면서 페이드 아웃되는 애니메이션(월별)*/
  @-webkit-keyframes moveToBottomFadeMonth {
    to {
      opacity: 0;
      -webkit-transform: translateY(30%) scale(0.95);
    }
  }

  /*화면 아래에서 위로 이동하면서 페이드 인되는 애니메이션(월별)*/
  @-webkit-keyframes moveFromBottomFadeMonth {
    from {
      opacity: 0;
      -webkit-transform: translateY(-30%) scale(0.95);
    }
  }

  /*화면에 나타나면서 서서히 나타나는 애니메이션*/
  @-webkit-keyframes fadeIn {
    from {
      opacity: 0;
    }
  }

  /*화면에서 사라지면서 서서히 사라지는 애니메이션*/
  @-webkit-keyframes fadeOut {
    to {
      opacity: 0;
    }
  }

  /*요소가 사라지면서 크기가 축소되는 애니메이션*/
  @-webkit-keyframes fadeOutShink {
    to {
      opacity: 0;
      padding: 0px;
      height: 0px;
    }
  }
</style>

<%@ include file="../common/foot.jspf"%>