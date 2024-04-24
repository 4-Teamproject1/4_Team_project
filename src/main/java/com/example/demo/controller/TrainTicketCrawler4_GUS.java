package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.openqa.selenium.By;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler4_GUS {
	public static void main(String[] args) {
		// 크롬 드라이버 경로 설정
		System.setProperty("webdriver.chrome.driver",
				"C:/work/chromedriver-win64 (1)/chromedriver-win64/chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();

		// 네이버 기차표 검색 페이지 URL
//        String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=f7739694-dbb7-41bd-aa27-be7c942ce354&gad_source=1&device=c&network=g&adid=695827820287&rand=7846428391314568431&expid=&adpos=&aud=kwd-6927948326&gclid=Cj0KCQjwlZixBhCoARIsAIC745BvF5aSyMA_QOWdSeqBil67b7Xx3zExuBbJP1Y2QtJ0ehVU8kW6aX8aAl0HEALw_wcB&pslc=1&ds=suPN3WV%2Fo7g%2BbofO";

		// 아고다 검색 페이지 url
		String url = "https://url.kr/prnsqx";

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

		try {
			// 페이지 로드를 위한 대기 시간 설정 (초 단위)
			driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
		} catch (TimeoutException e) {
			System.out.println("페이지 로드 시간이 초과되었습니다.");
		}

		String combinedXPath2 = "//ul[@class='AutocompleteList']//li";

		List<WebElement> timeElements2 = wait_web
				.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(combinedXPath2)));

//		 가져온 리스트
//		 System.out.println(timeElements);
//		 for (WebElement element : timeElements) {
//			    System.out.println(element.getText());
//			}
		// timeElements 리스트에서 첫 번째 요소 가져오기

		WebElement firstElement = timeElements2.get(0);

		// 첫 번째 요소 클릭
		firstElement.click();

		System.out.println("asd");

		// 원하는 날짜 설정
		String targetDate = "Thu May 02 2024";

		// 웹 요소 찾기

		String monthStr = "//div[contains(@class,'DayPicker-Caption') and contains(@class,'DayPicker-Caption-Wide')]";

		List<WebElement> monthElements = wait_web
				.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(monthStr)));

		// 찾은 웹 요소의 텍스트 값 출력
		for (WebElement element : monthElements) {
			System.out.println("텍스트 값: " + element.getText());
		}
		// 기본 달 값
		System.out.println(monthElements.get(0).getText());

		LocalDate currentDate = LocalDate.now();
		int year = currentDate.getYear();
		int month = currentDate.getMonthValue();

		// 합친 년도와 달 문자열 생성
		String currentYearMonth = year + "년 " + month + "월";
		
		System.out.println(currentYearMonth);
		System.out.println(monthElements.get(0).getText());
		if (currentYearMonth.equals(monthElements.get(0).getText())) {
			
			System.out.println("현재 달과 일치");
		}else {
//			if(month)
			System.out.println("현재 달과 일치하지않음");
		}
			

		String calendarElementsStr = "//div[@class='DayPicker-Week-Wide']";
		List<WebElement> calendarElements = wait_web
				.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(calendarElementsStr)));

		for (WebElement element : calendarElements) {
			System.out.println(element.getText());

		}

//		 // div 안에 있는 값으로 요소 찾기
//	        String divText = "5";
//	        WebElement elementInsideDiv = driver.findElement(By.xpath("//div[text()='" + divText + "']"));

//		 startDay.click();
		System.out.println("asd");

		WebElement endDay = driver.findElement(By.xpath("//div[@aria-label='Wed May 04 2024 ']"));

		endDay.click();

//		try {
//			// XPath로 모든 li 요소들을 찾습니다.
//			List<WebElement> liElements = driver.findElements(
//					By.xpath("//div[@class='Popup')]//li"));
//
//			System.out.println(liElements);
//			// liElements가 비어있는지 확인합니다.
//			if (!liElements.isEmpty()) {
//				// 첫 번째 li 요소를 선택합니다.
//				WebElement firstLi = liElements.get(0);
//
//				// 해당 요소를 클릭합니다.
//				firstLi.click();
//			} else {
//				System.out.println("li 요소를 찾을 수 없습니다.");
//			}
//		} catch (org.openqa.selenium.NoSuchElementException e) {
//			// 요소를 찾을 수 없을 때 예외 처리합니다.
//			System.out.println("li 요소를 찾을 수 없습니다.");
//		}
		// time_taken과 time_unit 요소를 함께 찾는 XPath
//
//		try {
//			// 페이지 로드를 위한 대기 시간 설정 (초 단위)
//			driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
//		} catch (TimeoutException e) {
//			System.out.println("페이지 로드 시간이 초과되었습니다.");
//		}

//		// 모든 li 요소 찾기
//		List<WebElement> liElements = driver.findElements(By.xpath(
//				"//div[@class='Popup Autocomplete Autocomplete--with-dayuse']//ul[@class='AutocompleteList']/li"));
//		System.out.println(liElements);
//		// 각 요소의 data-text 속성 값을 비교하여 일치하는 요소 선택
//		for (WebElement liElement : liElements) {
//			String dataTextValue = liElement.getAttribute("data-text");
//			if (dataTextValue.equals(searchText)) {
//				// 일치하는 요소를 선택하거나 원하는 작업 수행
//				liElement.click(); // 예시로 클릭하는 동작 수행
//				break; // 일치하는 요소를 찾았으므로 반복문 종료
//			}
//		}
		// time_taken과 time_unit 요소를 함께 찾는 XPath

//	        String combinedXPath = "//li[contains(@class, 'sc-1tj2a62') and contains(@class, 'eypxCR') and contains(@class, 'is_selected')]//span[@class='time_taken' or @class='time_unit']";
//
//	        // time_taken과 time_unit 요소 찾기
//	        List<WebElement> timeElements = wait_web.until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(combinedXPath)));
//
//	        // timeElements에서 각 요소의 텍스트를 가져와 구분합니다.
//	        String timeTakenText = "";
//	        String timeUnitText = "";
//
//	        for (WebElement element : timeElements) {
//	            String text = element.getText();
//	            if (element.getAttribute("class").equals("time_taken")) {
//	                timeTakenText = text;
//	            } else if (element.getAttribute("class").equals("time_unit")) {
//	                timeUnitText = text;
//	            }
//	        }

		// WebDriver 종료
//		driver.quit();
	}
}