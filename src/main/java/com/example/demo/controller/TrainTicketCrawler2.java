package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
//        String url = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EA%B8%B0%EC%B0%A8%ED%91%9C+%EC%98%88%EB%A7%A4";
//          String url = "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=기차표+예매";
		String url = "https://map.naver.com/p/directions/-/-/-/transit?c=15.00,0,0,0,dh";
//        String url = "https://map.naver.com/p/settings?c=15.00,0,0,0,dh";
		// 기차표 검색 페이지로 이동
		driver.get(url);
		// 출발지와 도착지 정보
		String departure = "서울역";
		String arrival = "부산역";



		// 스크롤 내리기
		JavascriptExecutor js = (JavascriptExecutor) driver;
		js.executeScript("window.scrollBy(0, 300)");

		// 시간표 조회 버튼 클릭
		WebElement searchButton = driver.findElement(By.xpath("//button[contains(@class, 'EkxmVtPgf4qaNumd_yo2')]"));
		searchButton.click();

		// 기차 시간표 데이터 크롤링
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
		WebElement timetable = wait
				.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='_3-5Oc']")));
		List<WebElement> scheduleRows = timetable.findElements(By.xpath(".//ul[@class='_3tdEo']//li"));
		for (WebElement row : scheduleRows) {
			System.out.println(row.getText());
		}

		// WebDriver 종료
		driver.quit();
	}
}