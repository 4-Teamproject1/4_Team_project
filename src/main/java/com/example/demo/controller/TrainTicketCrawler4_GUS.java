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
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

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
		WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(300));

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


		WebElement firstElement = timeElements2.get(0);

		// 첫 번째 요소 클릭
		firstElement.click();

		// 페이지 왼쪽 달력 년도하고 달
		String monthStr = "//div[contains(@class,'DayPicker-Caption') and contains(@class,'DayPicker-Caption-Wide')]";

		List<WebElement> monthElements = wait_web
				.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(monthStr)));

		// 찾은 웹 요소의 텍스트 값 출력
//		for (WebElement element : monthElements) {
//			System.out.println("텍스트 값: " + element.getText());
//		}

		// monthElements.get(0).getText()로 얻어온 텍스트
		String pageYearMonth = monthElements.get(0).getText();

		// 년도와 월을 추출할 정규 표현식 패턴 설정
		Pattern pattern = Pattern.compile("(\\d{4})년 (\\d{1,2})월");
		Matcher matcher = pattern.matcher(pageYearMonth);
	
		int pageYear = 0;
		int pageMonth = 0;

		// 검색했을때 나온 달력의 년도와 월을 구하는 코드
		// 매치되는 부분이 있다면 년도와 월 추출
		if (matcher.find()) {
			pageYear = Integer.parseInt(matcher.group(1));
			pageMonth = Integer.parseInt(matcher.group(2));
			System.out.println("년도: " + pageYear);
			System.out.println("월: " + pageMonth);
		} else {
			System.out.println("매치되는 부분이 없습니다.");
		}

		// 이전 달 버튼 요소 찾기
		WebElement previousMonthButton = driver.findElement(By.cssSelector("button[aria-label='Previous Month']"));

		// 다음 달 버튼 요소 찾기
		WebElement nextMonthButton = driver.findElement(By.cssSelector("button[aria-label='Next Month']"));

		// 현재 날짜 구하는 코드
		LocalDate currentDate = LocalDate.now();
		int nowYear = currentDate.getYear();
		int nowMonth = currentDate.getMonthValue();

		// 합친 년도와 달 문자열 생성
		String currentYearMonth = nowYear + "년 " + nowMonth + "월";

//		현재날짜와 페이지날짜 출력
//		System.out.println(currentYearMonth);
//		System.out.println(monthElements.get(0).getText());
		if (currentYearMonth == pageYearMonth) {

		}
		while (true) {

			if (pageYear == nowYear && pageMonth > nowMonth) {
				previousMonthButton.click();
				break;

			} else {
				System.out.println("값이 일치하지 않음");
				break;
			}

		}
		// 날짜 포맷 지정
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE MMM dd yyyy", Locale.ENGLISH);

		// 현재 날짜를 원하는 형식으로 파싱
		// 이걸로 날짜 찾아서 선택해줄예정
		String startDate = currentDate.format(formatter);

		// 현재 날짜 요소 찾기
		String startDateStr = "//div[@class='DayPicker-Week-Wide']/div[contains(@aria-label, '" + startDate + "')]";
		WebElement startDateElement = driver.findElement(By.xpath(startDateStr));

		// 찾은 현재 날짜 클릭(시작 날짜)
		startDateElement.click();

		// 다음날 날짜 구하기
		LocalDate plusNowDate = currentDate.plusDays(1);

		String nextDate = plusNowDate.format(formatter);
		String endDateStr = "//div[@class='DayPicker-Week-Wide']/div[contains(@aria-label, '" + nextDate + "')]";
		WebElement endDateElement = driver.findElement(By.xpath(endDateStr));

		endDateElement.click();

		// 버튼 요소를 포함하는 div 요소의 XPath
		String buttonXPathStr = "//div[@class='Box-sc-kv6pi1-0 hRUYUu TabContent__Search--button']//button[@data-test='SearchButtonBox']";

		// 버튼 요소 찾기
		WebElement buttonElement = driver.findElement(By.xpath(buttonXPathStr));

		// 검색하기 클릭
		buttonElement.click();

		// <ol> 요소 선택
		List<WebElement> hotelListElements = wait_web.until(ExpectedConditions.presenceOfAllElementsLocatedBy(
			    By.xpath("//ol[@class='hotel-list-container']/li[position() <= 10]")));

		if (hotelListElements != null) {
			 // 최대 10개의 요소만 가져오기
		    int count = Math.min(hotelListElements.size(), 10);
		    System.out.println("뭐가 들어있긴해");
		    System.out.println(hotelListElements);
		    for (int i = 0; i < count; i++) {
		        WebElement element = hotelListElements.get(i);
		        System.out.println("텍스트 값: " + element.getText());
		    }
		} else {
			System.out.println("해당하는 <ol> 요소를 찾을 수 없습니다.");
		}

	}
}

//		 // div 안에 있는 값으로 요소 찾기
//	        String divText = "5";
//	        WebElement elementInsideDiv = driver.findElement(By.xpath("//div[text()='" + divText + "']"));
		 
		 
//		 startDay.click();

