<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="My Schedule"></c:set>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
<div id="calendar"></div>
<link href='https://fonts.googleapis.com/css?family=Exo+2:400,100' rel='stylesheet' type='text/css'>
<!-- daisy ui 불러오기 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/daisyui/4.6.1/full.css" />

<script>
    // moment.js 라이브러리를 사용하여 날짜 및 시간을 쉽게 다룰 수 있습니다.
    // 이 자바스크립트 코드는 달력을 생성하고 이벤트를 표시하는 기능을 구현합니다.
    // Calendar 객체를 생성합니다.
    // selector는 캘린더를 표시할 DOM 요소를 지정합니다.
    // events는 캘린더에 표시할 이벤트 목록입니다.
    function Calendar(selector, events) {
        // 캘린더를 표시할 DOM 요소를 선택합니다.
        this.el = document.querySelector(selector);
        // 이벤트 목록을 저장합니다.
        this.events = events;
        // 현재 날짜를 기준으로 moment 객체를 생성합니다.
        this.current = moment().date(1);
        // 캘린더를 그립니다.
        this.draw();
        // 현재 날짜를 표시하는 요소를 찾습니다.
        var current = document.querySelector(".today");
        if (current) {
            var self = this;
            // 페이지 로드 후 500ms 지연 후 현재 날짜의 이벤트를 표시합니다.
            window.setTimeout(function () {
                self.openDay(current);
            }, 500);
        }
        // 페이지 로드 시 모든 이벤트를 표시합니다.
        this.showAllEvents();
        // 스크롤 가능한 컨테이너 요소를 선택합니다.
        this.scrollContainer = this.el.querySelector(".scroll-container")
    }

    // Calendar 객체의 다음 달로 이동하는 메서드입니다.
    Calendar.prototype.nextMonth = function () {
        this.current.add("months", 1);
        this.next = true;
        this.draw();
        this.adjustScrollContainerPosition(); // 스크롤 컨테이너 위치 조정
    };

    // Calendar 객체의 이전 달로 이동하는 메서드입니다.
    Calendar.prototype.prevMonth = function () {
        this.current.subtract("months", 1);
        this.next = false;
        this.draw();
        this.adjustScrollContainerPosition(); // 스크롤 컨테이너 위치 조정
    };

    // 스크롤 컨테이너의 위치를 조정하는 메서드입니다.
    Calendar.prototype.adjustScrollContainerPosition = function () {
        var self = this;
        // 월 전환 애니메이션이 완료된 후 조정되도록 지연
        setTimeout(function () {
            // 현재 월의 위치를 기반으로 새로운 위치 계산
            var calendarRect = self.el.getBoundingClientRect();
            var scrollContainerRect = self.scrollContainer.getBoundingClientRect();
            var newTop = scrollContainerRect.top - calendarRect.top;
            // 스크롤 컨테이너의 새로운 상단 위치를 설정합니다.
            self.scrollContainer.style.top = newTop + "px";
        }, 500); // 애니메이션 기간에 맞춰 지연 조정
    };

    // 캘린더를 그리는 메서드입니다.
    Calendar.prototype.draw = function () {
        // 헤더를 생성합니다.
        this.drawHeader();
        // 달을 그립니다.
        this.drawMonth();
        // 스크롤 컨테이너의 내용을 지웁니다.
        this.scrollContainer.innerHTML = '';
        // 현재 달의 이벤트를 그리고 스크롤 컨테이너에 추가합니다.
        this.showAllEvents();
    };

    // 헤더를 그리는 메서드입니다.
    Calendar.prototype.drawHeader = function () {
        var self = this;
        if (!this.header) {
            // 헤더 요소를 생성합니다.
            this.header = createElement("div", "header");
            this.header.className = "header";
            this.title = createElement("h1");
            var right = createElement("div", "right");
            right.addEventListener("click", function () {
                self.nextMonth();
            });
            var left = createElement("div", "left");
            left.addEventListener("click", function () {
                self.prevMonth();
            });
            // 요소를 추가합니다.
            this.header.appendChild(this.title);
            this.header.appendChild(right);
            this.header.appendChild(left);
            this.el.appendChild(this.header);
            // 주단위 요일 이름을 그립니다.
            this.drawWeekdays();
        }
        this.title.innerHTML = this.current.format("MMM YYYY");
    };

    // 달을 그리는 메서드입니다.
    Calendar.prototype.drawMonth = function () {
        var self = this;
        // 이벤트를 각 날짜에 랜덤하게 배치합니다.
        this.events.forEach(function (ev) {
            ev.date = self.current.clone().date(Math.random() * (29 - 1) + 1);
        });
        // 이미 존재하는 경우 이전 달에 대한 처리를 합니다.
        if (this.month) {
            this.oldMonth = this.month;
            this.oldMonth.className = "month out " + (self.next ? "next" : "prev");
            this.oldMonth.addEventListener("webkitAnimationEnd", function () {
                self.oldMonth.parentNode.removeChild(self.oldMonth);
                self.month = createElement("div", "month");
                self.backFill();
                self.currentMonth();
                self.fowardFill();
                self.el.appendChild(self.month);
                window.setTimeout(function () {
                    self.month.className = "month in " + (self.next ? "next" : "prev");
                }, 16);
            });
        } else {
            // 새로운 달을 생성합니다.
            this.month = createElement("div", "month");
            this.el.appendChild(this.month);
            this.backFill();
            this.currentMonth();
            this.fowardFill();
            this.month.className = "month new";
        }
    };

    // 이전 달을 채우는 메서드입니다.
    Calendar.prototype.backFill = function () {
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

    // 다음 달을 채우는 메서드입니다.
    Calendar.prototype.fowardFill = function () {
        var clone = this.current.clone().add("months", 1).subtract("days", 1);
        var dayOfWeek = clone.day();
        if (dayOfWeek === 6) {
            return;
        }
        for (var i = dayOfWeek; i < 6; i++) {
            this.drawDay(clone.add("days", 1));
        }
    };

    // 현재 달을 그리는 메서드입니다.
    Calendar.prototype.currentMonth = function () {
        var clone = this.current.clone();
        while (clone.month() === this.current.month()) {
            this.drawDay(clone);
            clone.add("days", 1);
        }
    };

    // 주 단위 요소를 생성하는 메서드입니다.
    Calendar.prototype.getWeek = function (day) {
        if (!this.week || day.day() === 0) {
            this.week = createElement("div", "week");
            this.month.appendChild(this.week);
        }
    };

    // 요일 레이블을 그리는 메서드입니다.
    Calendar.prototype.drawWeekdays = function () {
        var weekdaysRow = createElement("div", "weekdays-row");
        weekdays.forEach(function (weekday) {
            var weekdayLabel = createElement("div", "weekday-label", weekday);
            weekdaysRow.appendChild(weekdayLabel);
        });
        this.el.appendChild(weekdaysRow);
    };

    // 날짜를 그리는 메서드입니다.
    Calendar.prototype.drawDay = function (day) {
        var self = this;
        this.getWeek(day);
        var outer = createElement("div", this.getDayClass(day));
        outer.addEventListener("click", function () {
            self.openDay(this);
        });
        var number = createElement("div", "day-number", day.format("DD"));
        var events = createElement("div", "day-events");
        this.drawEvents(day, events);
        outer.appendChild(number);
        outer.appendChild(events);
        this.week.appendChild(outer);
    };

    // 날짜에 해당하는 이벤트를 그리는 메서드입니다.
    Calendar.prototype.drawEvents = function (day, element) {
        if (day.month() === this.current.month()) {
            var todaysEvents = this.events.reduce(function (memo, ev) {
                if (ev.date.isSame(day, "day")) {
                    memo.push(ev);
                }
                return memo;
            }, []);
            todaysEvents.forEach(function (ev) {
                var evSpan = createElement("span", ev.color);
                var eventNameSpan = createElement("span", "event-name", ev.eventName);
                evSpan.appendChild(eventNameSpan);
                element.appendChild(evSpan);
            });
        }
    };

    // 날짜에 따라 클래스를 설정하는 메서드입니다.
    Calendar.prototype.getDayClass = function (day) {
        classes = ["day"];
        if (day.month() !== this.current.month()) {
            classes.push("other");
        } else if (today.isSame(day, "day")) {
            classes.push("today");
        }
        return classes.join(" ");
    };

    // 페이지가 로드될 때 모든 이벤트를 표시하는 메서드입니다.
    Calendar.prototype.showAllEvents = function () {
        var self = this;
        var scrollContainer = createElement("div", "scroll-container");
        var daysInMonth = this.current.daysInMonth();
        for (var dayNumber = 1; dayNumber <= daysInMonth; dayNumber++) {
            var day = this.current.clone().date(dayNumber);
            var todaysEvents = this.events.filter(function (ev) {
                return ev.date.isSame(day, "day");
            });
            if (todaysEvents.length > 0) {
                var dayElement = createElement("div", "day-events-container");
                var dayNumberElement = createElement("div", "day-number", day.format("DD일"));
                dayElement.appendChild(dayNumberElement);
                self.renderEvents(todaysEvents, dayElement);
                scrollContainer.appendChild(dayElement);
                dayNumberElement.style.borderBottom = "1px solid #ccc";
                dayNumberElement.style.paddingTop = "20px";
                dayNumberElement.style.paddingBottom = "20px";
                dayNumberElement.style.marginTop = "20px";
                dayNumberElement.style.marginBottom = "20px";
            }
        }
        this.el.appendChild(scrollContainer);
    };

    // 날짜를 클릭했을 때 상세 정보를 표시하는 메서드입니다.
    Calendar.prototype.openDay = function (el) {
        var details;
        var dayNumber = +el.querySelector(".day-number").innerText || +el.querySelector(".day-number").textContent;
        var day = this.current.clone().date(dayNumber);
        var currentOpened = document.querySelector(".details");
        if (!currentOpened || currentOpened.parentNode !== el.parentNode) {
            if (currentOpened) {
                currentOpened.addEventListener("animationend", function () {
                    if (currentOpened.parentNode) {
                        currentOpened.parentNode.removeChild(currentOpened);
                    }
                });
                currentOpened.className = "details out";
            }
            details = createElement("div", "details in");
            var eventsWrapper = createElement("div", "events");
            details.appendChild(eventsWrapper);
            document.body.appendChild(details);
            var todaysEvents = this.events.filter(function (ev) {
                return ev.date.isSame(day, "day");
            });
            this.renderEvents(todaysEvents, eventsWrapper);
        }
    };

    // 이벤트를 렌더링하는 메서드입니다.
    Calendar.prototype.renderEvents = function (events, ele) {
        var currentWrapper = ele.querySelector(".events");
        var wrapper = createElement("div", "events in" + (currentWrapper ? " new" : ""));
        events.forEach(function (ev) {
            var div = createElement("div", "event");
            var square = createElement("div", "event-category " + ev.color);
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
            currentWrapper.addEventListener("animationend", function () {
                if (currentWrapper.parentNode) {
                    currentWrapper.parentNode.removeChild(currentWrapper);
                }
            });
        }
        ele.appendChild(wrapper);
    };

    // 다음 달로 이동하는 메서드입니다.
    Calendar.prototype.nextMonth = function () {
        this.current.add("months", 1);
        this.next = true;
        this.draw();
    };

    // 이전 달로 이동하는 메서드입니다.
    Calendar.prototype.prevMonth = function () {
        this.current.subtract("months", 1);
        this.next = false;
        this.draw();
    };

    // DOM 요소를 생성하는 도우미 함수입니다.
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

    // Calendar 객체를 생성합니다.
    var calendar = new Calendar("#calendar", data);
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