package com.example.demo.controller;

import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler2 {

	public static void main(String[] args) {
		// 크롬 드라이버 경로 설정
		System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();
		// 네이버 기차표 검색 페이지 URL
		String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&device=c&network=g&adid=695827820287&rand=4503536931058910549&expid=&adpos=&aud=kwd-304551434341&gclid=Cj0KCQjw8pKxBhD_ARIsAPrG45lLdMb_4IW3wJ6-QBpNh2CcPRLxz36RLBmJOG_7mMzXovKgyBHRVhcaAmIuEALw_wcB&pslc=1&ds=JNryncziEDwLm8PF#packages";

		// 기차표 검색 페이지로 이동
		driver.get(url);
		// 검색창 요소 찾기
		WebElement searchInput = driver.findElement(By.cssSelector("div.input_box input.input_search"));

		// WebDriverWait 인스턴스 생성
		WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(10));

		// 검색창이 활성화될 때까지 기다림
		WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

		// 검색어 입력
		String searchText = "경기도 성남시 분당구 하오개로 323";
		activatedSearchInput.sendKeys(searchText);

		// 엔터 입력 (검색 실행)
		activatedSearchInput.sendKeys(Keys.ENTER);

		// 도착 버튼 찾기
		WebElement arrivalButton = wait_web.until(ExpectedConditions
				.elementToBeClickable(By.cssSelector("div.btn_area div.btn_box.direction button.btn_goal")));
		// 도착 버튼 클릭
		arrivalButton.click();

		// WebDriverWait를 사용하여 출발지 입력란이 활성화될 때까지 기다립니다.
		WebElement searchInput_start = wait_web.until(ExpectedConditions
				.elementToBeClickable(By.cssSelector("div.search_input_wrap div.search_input input.input_search")));
		// 검색창을 클릭하여 활성화합니다.
		searchInput_start.click();
		// 검색어 입력
		String searchText_start = "대전광역시 서구 둔산로 52 미라클빌딩 3층";
		// 검색어 입력란에 값을 입력합니다.
		searchInput_start.sendKeys(searchText_start);
		searchInput_start.sendKeys(Keys.ENTER);

		// 길찾기 버튼 요소 찾기
		WebElement findPathButton = driver.findElement(By.cssSelector(".search_btn_area .btn_direction.search.active"));

		// 길찾기 버튼 클릭
		findPathButton.click();

		// WebDriver 종료
		driver.quit();
	}

}