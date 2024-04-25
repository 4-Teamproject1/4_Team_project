package com.example.demo.controller;

import java.time.Duration;

import java.util.List;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TrainTicketCrawler4_GUS {
	public static void main(String[] args) {
		// 크롬 드라이버 경로 설정
		System.setProperty("webdriver.chrome.driver",
				"C:/work/chromedriver-win64 (1)/chromedriver-win64/chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();

		// 아고다 검색 페이지 url
		String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=f7739694-dbb7-41bd-aa27-be7c942ce354&gad_source=1&device=c&network=g&adid=695827820287&rand=7846428391314568431&expid=&adpos=&aud=kwd-6927948326&gclid=Cj0KCQjwlZixBhCoARIsAIC745BvF5aSyMA_QOWdSeqBil67b7Xx3zExuBbJP1Y2QtJ0ehVU8kW6aX8aAl0HEALw_wcB&pslc=1&ds=rsjlTo6c2PdQF7zG";


		// 아고다 검색 페이지로 이동
		driver.get(url);

		// 검색창 요소 찾기
		WebElement searchInput = driver.findElement(By.cssSelector("#autocomplete-box #textInput"));

		// WebDriverWait 인스턴스 생성
		WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(10));

		// 검색창이 활성화될 때까지 기다림
		WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

		// 검색어 입력
		String searchText = "서울";
		activatedSearchInput.sendKeys(searchText);
	
//		// 엔터 입력 (검색 실행)
//		activatedSearchInput.sendKeys(Keys.ENTER);

		  // 검색 결과 리스트 요소 가져오기
        List<WebElement> searchResults = driver.findElements(By.xpath("//ul[@class='AutocompleteList']//li"));
        System.out.println(searchResults);
        // 검색 결과 출력
        for (WebElement result : searchResults) {
            System.out.println(result.getText());
        }
		try {
			// 페이지 로드를 위한 대기 시간 설정 (초 단위)
			driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
		} catch (TimeoutException e) {
			System.out.println("페이지 로드 시간이 초과되었습니다.");
		}
		
		
		String combinedXPath = "//ul[@class='AutocompleteList']//li";

		 List<WebElement> timeElements = wait_web.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(combinedXPath)));
		 
		
//		 가져온 리스트
//		 System.out.println(timeElements);
//		 for (WebElement element : timeElements) {
//			    System.out.println(element.getText());
//			}
		// timeElements 리스트에서 첫 번째 요소 가져오기

//		 // div 안에 있는 값으로 요소 찾기
//	        String divText = "5";
//	        WebElement elementInsideDiv = driver.findElement(By.xpath("//div[text()='" + divText + "']"));
		 
		 
//		 startDay.click();
