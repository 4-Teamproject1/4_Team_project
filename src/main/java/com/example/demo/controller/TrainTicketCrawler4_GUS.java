
package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.example.demo.vo.Hotel;

public class TrainTicketCrawler4_GUS {
	public static void main(String[] args) {

		System.setProperty("webdriver.chrome.driver",
				"C:/work/chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();

		// 네이버 기차표 검색 페이지 URL
		String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&device=c&network=g&adid=695788229412&rand=2893338334644664789&expid=&adpos=&aud=kwd-304551434341&gclid=Cj0KCQjw_qexBhCoARIsAFgBlevSo6nth5UoZYtTjxbyMdsMGb9e5H1wMGNKOHqatzyxXCnCCISQUGEaApAaEALw_wcB&checkIn=2024-05-10&checkOut=2024-05-18&adults=1&rooms=1&pslc=1&ds=pWGoz1iyjxyzPJEv";

		// 아고다 검색 페이지로 이동
		driver.get(url);

		// 검색창 요소 찾기
		WebElement searchInput = driver.findElement(By.cssSelector("#autocomplete-box #textInput"));

		// WebDriverWait 인스턴스 생성
		WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(5));

		// 검색창이 활성화될 때까지 기다림
		WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

		// 검색어 입력
		String searchText = "";
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

		// 현재 탭의 핸들 가져오기
		String currentTabHandle = driver.getWindowHandle();

		// 모든 탭의 핸들 가져오기
		Set<String> allTabHandles = driver.getWindowHandles();

		// 두 번째 탭의 핸들 찾기
		String secondTabHandle = "";
		for (String handle : allTabHandles) {
			if (!handle.equals(currentTabHandle)) {
				secondTabHandle = handle;
				break;
			}
		}

		// 두 번째 탭으로 전환
		driver.switchTo().window(secondTabHandle);

		
		
		List<WebElement> liElements = driver.findElements(By.xpath(
				"//ol[@class='hotel-list-container']//li[contains(@class,'PropertyCard') and contains(@class,'PropertyCardItem')]"));
		System.out.println(liElements.size());

		
		// li 태그를 순회하면서 해당 클래스명을 가진 데이터 가져오기
		System.out.println("순회 시작");
		int i = 1;
		for (WebElement liElement : liElements) {
//		for (int i = 0; i <= 10; i++) {
//			WebElement liElement = liElements.get(i);
			int lastId = i + 1;
			WebElement imgElement = liElement.findElement(By.xpath(
					".//img[(contains(@class,'sc-kstrdz') and contains(@class,'sc-hBEYos') and contains(@class,'kmUwlj')) or (contains(@class,'HeroImage') and contains(@class,'HeroImage--s'))]"));
			String imgUrl = imgElement.getAttribute("src");
			WebElement hotelNameElement = liElement.findElement(By.xpath(
					".//h3[contains(@class,'sc-jrAGrp') and contains(@class,'sc-kEjbxe') and contains(@class,'eDlaBj') and contains(@class,'dscgss')]"));
			String hotelName = hotelNameElement.getText();

			// role이 img인 div 요소를 찾습니다.
			WebElement starElement = liElement.findElement(By.xpath(".//div[@role='img']"));
			// 요소가 존재하는 경우 해당 요소의 텍스트 가져오기
			String ariaLabel = starElement.getAttribute("aria-label");
			if (starElement == null) {
				System.out.println("등급 없음");

			}
			WebElement priceElement = liElement
					.findElement(By.xpath(".//div[@data-element-name='final-price']//span[last()]"));
			String price = priceElement.getText();

			System.out.println("번호 : " + lastId);
			System.out.println("이미지 url : " + imgUrl);
			System.out.println("호텔 이름 : " + hotelName);
			System.out.println("호텔 등급 : " + ariaLabel);
			System.out.println("가격 : " + price);
			
			
			

			JavascriptExecutor js = (JavascriptExecutor) driver;
			js.executeScript("window.scrollTo(0, 1000)"); // 수직 스크롤을 1000px 아래로 이동

		}

	}

}
