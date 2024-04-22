package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;


import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
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


		// 출발지 입력
		// findElements방식을 사용하면 뒤에 .get[i]를 사용해서 요소를 넣어줘야 한다.
//        WebElement departureInput = (WebElement) driver.findElements(By.xpath("//input[@placeholder='출발 기차역']"));
//        departureInput.sendKeys("서울역");
//        WebElement departureInput = driver.findElement(By.xpath("//input[@placeholder='출발 기차역']"));
//        departureInput.sendKeys("서울역");
//
//        // 도착지 입력
//        WebElement arrivalInput = driver.findElement(By.xpath("//input[@placeholder='도착 기차역']"));
//        arrivalInput.sendKeys("부산역");
		// 출발지 입력 필드의 WebElement 객체 찾기
		//기존에 시험하던 코드
//		WebElement departureInput = driver.findElement(By.id("input_search:r4:"));
//		// 출발지 입력 필드에 값을 설정
//		((JavascriptExecutor) driver).executeScript("arguments[0].setAttribute('value', '서울역')", departureInput);
//
//		// 도착지 입력 필드의 WebElement 객체 찾기
//		WebElement arrivalInput = driver.findElement(By.xpath("//input[@placeholder='도착 기차역']"));
//		// 도착지 입력 필드에 값을 설정
//		((JavascriptExecutor) driver).executeScript("arguments[0].setAttribute('value', '부산역')", arrivalInput);
		// Ver.1
		
		// XPath를 사용하여 출발지 입력 필드를 찾습니다.
		WebElement departureInput = driver.findElement(By.xpath("//input[@id='input_search:r4:']"));
		// JavaScript를 사용하여 출발지 입력 필드의 값을 변경합니다.
		((JavascriptExecutor) driver).executeScript("arguments[0].value = '서울역'", departureInput);
		// XPath를 사용하여 도착지 입력 필드를 찾습니다.
		WebElement arrivalInput = driver.findElement(By.xpath("//input[@placeholder='도착 기차역']"));

		// JavaScript를 사용하여 도착지 입력 필드의 값을 변경합니다.
		((JavascriptExecutor) driver).executeScript("arguments[0].value = '부산역'", arrivalInput);
		
		
//        // 날짜 입력 (수정된 부분)
		LocalDate date = LocalDate.now().plusDays(3); // 예를 들어, 오늘로부터 3일 뒤로 설정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");
		String formattedDate = date.format(formatter);
		WebElement dateInput = driver.findElement(By.xpath("//dd[contains(@class, 'lx5CLVZizAnop1laHAqU')]"));
		dateInput.click(); // 클릭하여 날짜 선택 팝업 띄우기
		WebElement selectedDate = driver.findElement(By.xpath("//button[@aria-label='" + formattedDate + "']"));
		selectedDate.click(); // 선택한 날짜 클릭
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
