
package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import java.util.NoSuchElementException;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchWindowException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler4_GUS {
	public static void main(String[] args) {
		int i = 1;

		System.setProperty("webdriver.chrome.driver",
				"C:/work/chromedriver-win64 (1)/chromedriver-win64/chromedriver.exe");

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver();

		// 네이버 기차표 검색 페이지 URL
		String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&device=c&network=g&adid=695788229412&rand=2893338334644664789&expid=&adpos=&aud=kwd-304551434341&gclid=Cj0KCQjw_qexBhCoARIsAFgBlevSo6nth5UoZYtTjxbyMdsMGb9e5H1wMGNKOHqatzyxXCnCCISQUGEaApAaEALw_wcB&checkIn=2024-05-10&checkOut=2024-05-18&adults=1&rooms=1&pslc=1&ds=pWGoz1iyjxyzPJEv";

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

		System.out.println(0);

		WebElement hotelNameElement = wait_web.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(
				"#contentContainer > div:nth-child(4) > ol > li:nth-child(1) > div > a > div > div.Itemstyled__Item-sc-12uga7p-0.ewNxOO.PropertyCard__Section.PropertyCard__Section--propertyInfo > div > header > div:nth-child(2) > h3")));
		String hotelName = hotelNameElement.getText();
		System.out.println(hotelName);

//		WebElement imgElement1 = driver.findElement(By.xpath("//ol[@class='hotel-list-container']//li[contains(@class,'PropertyCard') and contains(@class,'PropertyCardItem')]//a//div[@class='Overlay']//button//img"));

		String imageUrl = "";
		// 이미지의 src 속성값 가져오기
		WebElement srcElement1 = null;
		WebElement srcElement2 = null;
		try {
			srcElement1 = wait_web
					.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(".HeroImage.HeroImage--s")));
			srcElement2 = wait_web
					.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector("sc-kstrdz.sc-hBEYos.kmUwlj")));
		} catch (Exception e) {
			// 이미지가 없는 경우 imageURL을 공백으로 설정
			System.out.println("요소를 찾을 수 없습니다.");

		}
		if (srcElement2 == null) {
			imageUrl = srcElement1.getAttribute("src");
		} else {
			imageUrl = srcElement2.getAttribute("src");
		}
		System.out.println("이미지 url : " + imageUrl);

		// ol 태그 안의 li 태그를 모두 가져오기
		List<WebElement> liElements = driver.findElements(By.xpath(
				"//ol[@class='hotel-list-container']//li[contains(@class,'PropertyCard') and contains(@class,'PropertyCardItem')]"));
		System.out.println(liElements.size());
		// li 태그를 순회하면서 해당 클래스명을 가진 데이터 가져오기
		for (WebElement liElement : liElements) {
			// li 태그 안에서 클래스명이 ".a5bf9-box.a5bf9-fill-inherit.a5bf9-text-inherit"인 요소 찾기
			WebElement starElement = liElement
					.findElement(By.xpath(".//div[contains(@class,'a5bf9-box') and contains(@class,'a5bf9-fill-inherit') and contains(@class,'a5bf9-text-inherit')]"));
		  System.out.println(starElement);
			// 요소가 존재하는 경우 해당 요소의 텍스트 가져오기
			if (starElement != null) {
				String ariaLabel = starElement.getAttribute("aria-label");
				System.out.println("aria-label 값: " + ariaLabel);
			}
		}

		List<WebElement> elements = driver
				.findElements(By.cssSelector(".a5bf9-box.a5bf9-fill-inherit.a5bf9-text-inherit      "));

		System.out.println(elements);
		System.out.println(elements.size());
		// 요소가 존재할 경우 첫 번째 요소의 aria-label 속성값 출력
		if (!elements.isEmpty()) {
			WebElement element = elements.get(0);
			String ariaLabel = element.getAttribute("aria-label");
			System.out.println("aria-label 값: " + ariaLabel);
		} else {
			System.out.println("해당 클래스를 가진 요소를 찾을 수 없습니다.");
		}

		System.out.println(2);
		List<WebElement> hotelList = driver.findElements(By.xpath(
				"//div[contains(@class,'Box-sc-kv6pi1-0')and contains(@class,'hRUYUu')and contains(@class,'JacketContent')and contains(@class,'JacketContent--Empty')]"));
		System.out.println(hotelList.size());
		System.out.println(hotelList);

//		for (int j = 0; j < hotelList.size(); j++) {
//			WebElement hotelElement = hotelList.get(j);
//			// 여기서 element를 사용하여 작업 수행
//
////			WebElement hotelElement = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//your/xpath/for/hotelElement")));
//			WebElement linkElement = wait_web
//					.until(ExpectedConditions.visibilityOf(hotelElement.findElement(By.tagName("a"))));
//			String hotelLink = linkElement.getAttribute("href");
//
//			// 학술행사에 대한 상세 페이지로 이동
//			driver.get(hotelLink);
//
////			WebElement titleImgElement = driver.findElement(By.xpath(
////					"//div[contains(@class,'Box-sc-kv6pi1-0')and contains(@class,'hRUYUu')and contains(@class,'Mosaic__Sq1')and contains(@class,'Mosaic__Sq1--7')]"));
//
//			// CSS 선택자를 사용하여 요소 찾기
////			WebElement srcElement = wait_web.until(ExpectedConditions
////					.visibilityOfElementLocated(By.cssSelector("#property-critical-root div.Mosaic__Container > img")));
////
////			String imageUrl = "";
//			// 요소의 src 속성값 가져오기
////			try {
////				imageUrl = srcElement.getAttribute("src");
////			} catch (NoSuchElementException e) {
////				// 이미지가 없는 경우 imageURL을 공백으로 설정
////				imageUrl = "";
////			}
//			WebElement titleElement = wait_web.until(ExpectedConditions
//					.visibilityOfElementLocated(By.cssSelector("#property-main-content div:nth-child(1) > p")));
//			String 호텔이름 = titleElement.getText();
//
//			WebElement starElement = wait_web.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(
//					"#property-main-content > div.Box-sc-kv6pi1-0.cJiLOx.sc-higXBA.bnRlSb > div.HeaderCerebrum > div:nth-child(1) > div > span > div > div > div")));
//			String 몇성 = starElement.getAttribute("aria-label");
//
//			WebElement mapElement = wait_web.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(
//					"#property-main-content span.Spanstyled__SpanStyled-sc-16tp9kb-0.gwICfd.kite-js-Span.HeaderCerebrum__Address")));
//			String 호텔위치 = mapElement.getText();
//			System.out.println("번호 : " + i);
//			System.out.println("호텔이름 : " + 호텔이름);
//			System.out.println(몇성 + "호텔");
//			System.out.println("호텔위치 : " + 호텔위치);
//
//			System.out.println("이미지 url : " + imageUrl);
//			i++;
//			driver.navigate().back();

//			WebElement priceElement = driver.findElement(By.cssSelector("#hotelNavBar > div > div > div > span > div > span:nth-child(5)"));
//			String 최저가 = priceElement.getText();
//			System.out.println(최저가);

	}

