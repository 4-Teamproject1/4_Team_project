package com.example.demo.controller;

import java.time.Duration;
import java.util.List;
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

		  // 검색 결과 리스트 요소 가져오기
        List<WebElement> searchResults = driver.findElements(By.xpath("//ul[@claa='AutocompleteList']/li"));
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
		
		 // li 요소들 선택
//        Elements liElements = doc.select("div.Popup__content > ul.AutocompleteList > li.Suggestion");
//
//        // 각 li 요소에서 정보 추출
//        for (Element li : liElements) {
//            // 데이터 추출
//            String text = li.attr("data-text");
//            String objectID = li.attr("data-objectid");
//            String placeType = li.attr("data-element-place-type");
//            String searchType = li.attr("data-element-search-type");
//
//            // 출력 또는 필요한 작업 수행
//            System.out.println("Text: " + text);
//            System.out.println("Object ID: " + objectID);
//            System.out.println("Place Type: " + placeType);
//            System.out.println("Search Type: " + searchType);
//            System.out.println("--------------------");
//        }
//
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