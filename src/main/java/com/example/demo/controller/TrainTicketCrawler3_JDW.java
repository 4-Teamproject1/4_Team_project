package com.example.demo.controller;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler3_JDW {
	public static void main(String[] args) {
		// 크롬 드라이버 경로 설정
		System.setProperty("webdriver.chrome.driver",
				"C:\\work\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();

		// 네이버 기차표 검색 페이지 URL
		String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";

		// 기차표 검색 페이지로 이동
		driver.get(url);
		// 검색창 요소 찾기
		WebElement searchInput = driver.findElement(By.cssSelector("div.input_box input.input_search"));

		// WebDriverWait 인스턴스 생성
		WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(30));

		// 검색창이 활성화될 때까지 기다림
		WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

		// 검색어 입력
		String searchText = "서울 용산구 한강대로 405";
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
		String searchText_start = "대전역";
		// 검색어 입력란에 값을 입력합니다.
		searchInput_start.sendKeys(searchText_start);
		searchInput_start.sendKeys(Keys.ENTER);

		// 도착 버튼 찾기
		WebElement arrivalButton2 = wait_web.until(ExpectedConditions
				.presenceOfElementLocated(By.cssSelector("div.search_btn_area button.btn_direction.search.active")));
		// 도착 버튼 클릭
		arrivalButton2.click();

		// 기차역 예매 버튼
		WebElement TrainlButton = wait_web.until(ExpectedConditions.presenceOfElementLocated(
				By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve")));
		// 기차역 예매 버튼 클릭
		TrainlButton.click();

		try {
			// 페이지 로드를 위한 대기 시간 설정 (초 단위)
			driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
		} catch (TimeoutException e) {
			System.out.println("페이지 로드 시간이 초과되었습니다.");
		}

		System.out.println("1");
		// WebDriverWait 인스턴스 생성
		// li 태그 요소들을 찾습니다.
		WebElement divElement = driver.findElement(By.xpath("//div[contains(@class, 'V3LGixwGqucLqgDNv06h')]"));
		List<WebElement> liElements = divElement.findElements(By.xpath(".//li[contains(@class, 'Iit8EKCtdTAoAXHIf7w9')]"));
		

		// 각 li 태그 요소들을 순회하면서 span 태그들을 출력합니다.
		for (WebElement liElement : liElements) {
		    // li 태그 안에 포함된 모든 span 태그들을 찾습니다.
		    List<WebElement> spanElements = liElement.findElements(By.tagName("span"));
		    
		    // 각 span 태그들을 순회하면서 텍스트를 출력합니다.
		    for (WebElement spanElement : spanElements) {
		        System.out.println(spanElement.getText());
		    }
		}

	}
}