$('select[data-value]').each(function(index, el) {
	const $el = $(el);

	defaultValue = $el.attr('data-value').trim();

	if (defaultValue.length > 0) {
		$el.val(defaultValue);
	}
});

//메인화면 슬라이드
//움직이는화면실행
function main_init() {
    // 슬라이더 요소와 버튼 요소, 슬라이드 항목들을 가져옵니다.
    const slider = document.querySelector(".slider");
    if (!slider) return; // slider가 없으면 함수 종료
    const nextBtn = slider.querySelector(".nav .next"); // 다음 버튼
    const prevBtn = slider.querySelector(".nav .prev"); // 이전 버튼
    const items = slider.querySelectorAll(".item"); // 슬라이드 항목들

	// 초기 슬라이드 인덱스 및 자동 넘김 상태 변수 설정
	let current = 0;
	let isPlaying = false;
	let intervalId;

	// 각 슬라이드 항목의 텍스트를 span 요소로 분할하여 애니메이션을 위한 준비를 합니다.
	items.forEach((item) => {
		const textWrapper = item.querySelector(".wrap");
		textWrapper.innerHTML = textWrapper.textContent.replace(/\S/g,"<span class='letter'>$&</span>"
		);
	});

	// 슬라이드 전환 애니메이션 함수
	function anim(current, next, callback) {
		const currentImgs = current.querySelectorAll(".img");
		const currentText = current.querySelectorAll(".content .letter");
		const nextImgs = next.querySelectorAll(".img");
		const nextText = next.querySelectorAll(".content .letter");

		const t = 400;
		const offset = "-=" + t * 0.4;

		const tl = anime.timeline({
			easing: "easeInOutQuint",
			duration: t,
			complete: callback
		});

		tl.add({
			targets: currentText,
			translateY: [0, "-.75em"],
			opacity: [1, 0],
			easing: "easeInQuint",
			duration: t,
			delay: (el, i) => 10 * (i + 1)
		})
			.add(
				{
					targets: currentImgs,
					translateY: -600,
					translateZ: 0,
					rotate: [0, "-15deg"],
					opacity: [1, 0],
					easing: "easeInCubic"
				},
				offset
			)
			.add({
				targets: current,
				opacity: 0,
				visibility: "hidden",
				duration: 10,
				easing: "easeInCubic"
			})
			.add(
				{
					targets: next,
					opacity: 1,
					visibility: "visible",
					duration: 10
				},
				offset
			)
			.add(
				{
					targets: nextImgs,
					translateY: [600, 0],
					translateZ: 0,
					rotate: ["15deg", 0],
					opacity: [0, 1],
					easing: "easeOutCubic"
				},
				offset
			)
			.add(
				{
					targets: nextText,
					translateY: [".75em", 0],
					translateZ: 0,
					opacity: [0, 1],
					easing: "easeOutQuint",
					duration: t * 1.5,
					delay: (el, i) => 10 * (i + 1)
				},
				offset
			);
	}

	// 슬라이드를 업데이트하는 함수
	function updateSlider(newIndex) {
		const currentItem = items[current];
		const newItem = items[newIndex];

		function callback() {
			currentItem.classList.remove("is-active");
			newItem.classList.add("is-active");
			current = newIndex;
			isPlaying = false;
		}

		anim(currentItem, newItem, callback);
	}

	// 다음 슬라이드로 이동하는 함수
	function next() {
		if (isPlaying) return;
		isPlaying = true;
		const newIndex = current === items.length - 1 ? 0 : current + 1;
		updateSlider(newIndex);
	}

	// 이전 슬라이드로 이동하는 함수
	function prev() {
		if (isPlaying) return;
		isPlaying = true;
		const newIndex = current === 0 ? items.length - 1 : current - 1;
		updateSlider(newIndex);
	}

	// 자동으로 슬라이드를 전환하는 함수
	function startAutoSlide() {
		intervalId = setInterval(() => {
			next();
		}, 3000); // 3초마다 전환
	}

	// 자동 슬라이드를 멈추는 함수
	function stopAutoSlide() {
		clearInterval(intervalId);
	}

	// 다음 버튼 클릭 시 자동 슬라이드 멈추고 다음 슬라이드로 이동
	nextBtn.addEventListener("click", () => {
		stopAutoSlide();
		next();
		startAutoSlide(); // 버튼 클릭 후 자동 슬라이드 재시작
	});

	// 이전 버튼 클릭 시 자동 슬라이드 멈추고 이전 슬라이드로 이동
	prevBtn.addEventListener("click", () => {
		stopAutoSlide();
		prev();
		startAutoSlide(); // 버튼 클릭 후 자동 슬라이드 재시작
	});

	// 페이지 로드 시 자동 슬라이드 시작
	startAutoSlide();
}

// DOMContentLoaded 이벤트가 발생하면 init 함수 실행
document.addEventListener("DOMContentLoaded", main_init);

//위의 자동슬라이드부분 설명.
//startAutoSlide() 함수를 통해 자동으로 슬라이드가 전환됩니다. 이 함수는 페이지 로드 시 자동으로 호출되며 4초마다 다음 슬라이드로 이동합니다.
//다음과 이전 버튼을 클릭하면 자동 슬라이드가 멈추고 해당 방향으로 슬라이드가 이동합니다.
//다음 버튼 클릭 시 stopAutoSlide() 함수를 호출하여 자동 슬라이드를 멈추고 next() 함수를 호출하여 다음 슬라이드로 이동합니다.
//이전 버튼 클릭 시도 마찬가지로 stopAutoSlide() 함수를 호출하여 자동 슬라이드를 멈추고 prev() 함수를 호출하여 이전 슬라이드로 이동합니다.
//마지막으로, 페이지 로드 시 DOMContentLoaded 이벤트가 발생하면 init() 함수를 호출하여 슬라이더를 초기화합니다.


