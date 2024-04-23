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

		// 엔터 입력 (검색 실행)
		activatedSearchInput.sendKeys(Keys.ENTER);

		
		// 검색 후 첫번째 요소 찾기
//        WebElement firstLiElement = driver.findElement(By.cssSelector(".Popup__content .AutocompleteList li:first-child"));
<<<<<<< HEAD

		try {
			// 페이지 로드를 위한 대기 시간 설정 (초 단위)
			driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
		} catch (TimeoutException e) {
			System.out.println("페이지 로드 시간이 초과되었습니다.");
		}

		try {
			// XPath로 모든 li 요소들을 찾습니다.
			List<WebElement> liElements = driver.findElements(By.xpath("//li[contains(@class,'Suggestion') and contains(@class,'Suggestion__categoryName')]"));
			List<WebElement> liElements_Box = driver.findElements(By.xpath("//ul[@class,'AutocompleteList']"));
			System.out.println(liElements_Box);
			System.out.println(liElements);
			// liElements가 비어있는지 확인합니다.
			if (!liElements.isEmpty()) {
				// 첫 번째 li 요소를 선택합니다.
				WebElement firstLi = liElements.get(0);

				// 해당 요소를 클릭합니다.
				firstLi.click();
			} else {
				System.out.println("li 요소를 찾을 수 없습니다.");
			}
		} catch (org.openqa.selenium.NoSuchElementException e) {
			// 요소를 찾을 수 없을 때 예외 처리합니다.
			System.out.println("li 요소를 찾을 수 없습니다.");
		}
		// time_taken과 time_unit 요소를 함께 찾는 XPath
=======
	           
		 try {
	            // 페이지 로드를 위한 대기 시간 설정 (초 단위)
	            driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
	        } catch (TimeoutException e) {
	            System.out.println("페이지 로드 시간이 초과되었습니다.");
	        }
	        
		// 모든 li 요소 찾기
		 List<WebElement> liElements = driver.findElements(By.xpath("//div[@class='Popup Autocomplete Autocomplete--with-dayuse']//ul[@class='AutocompleteList']/li"));
		 System.out.println(liElements);
		 // 각 요소의 data-text 속성 값을 비교하여 일치하는 요소 선택
		 for (WebElement liElement : liElements) {
		     String dataTextValue = liElement.getAttribute("data-text");
		     if (dataTextValue.equals(searchText)) {
		         // 일치하는 요소를 선택하거나 원하는 작업 수행
		         liElement.click(); // 예시로 클릭하는 동작 수행
		         break; // 일치하는 요소를 찾았으므로 반복문 종료
		     }
		 }
	        // time_taken과 time_unit 요소를 함께 찾는 XPath
>>>>>>> ca28777edf6281feb6f5ac944ef7108220671653
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
<<<<<<< HEAD

		// XPath를 사용하여 해당 요소를 찾습니다.
		WebElement ulElement = driver.findElement(By
				.xpath("//div[@class='Popup Autocomplete Autocomplete--with-dayuse']//ul[@class='AutocompleteList']"));

		// 해당 요소의 내용을 출력합니다.
		System.out.println("찾은 ul 요소의 내용: " + ulElement.getText());

		// ul 요소 내의 첫 번째 li 요소를 찾습니다.
		WebElement firstLiElement = driver.findElement(By.cssSelector(""));
=======
	        
		  // XPath를 사용하여 해당 요소를 찾습니다.
        WebElement ulElement = driver.findElement(By.xpath("//div[@class='Popup Autocomplete Autocomplete--with-dayuse']//ul[@class='AutocompleteList']"));

        // 해당 요소의 내용을 출력합니다.
        System.out.println("찾은 ul 요소의 내용: " + ulElement.getText());

		        
		  
	  
	// ul 요소 내의 첫 번째 li 요소를 찾습니다.
	WebElement firstLiElement = driver
				.findElement(By.cssSelector(""));
>>>>>>> ca28777edf6281feb6f5ac944ef7108220671653

	wait_web=new WebDriverWait(driver,Duration.ofSeconds(10));

	// 검색창이 활성화될 때까지 기다림
	activatedSearchInput=wait_web.until(ExpectedConditions.elementToBeClickable(firstLiElement));

	// 첫번째 요소 클릭
	firstLiElement.click();

	// WebDriverWait를 사용하여 출발지 입력란이 활성화될 때까지 기다립니다.
	WebElement searchInput_start = wait_web.until(ExpectedConditions
			.elementToBeClickable(By.cssSelector("div.search_input_wrap div.search_input input.input_search")));
	// 검색창을 클릭하여 활성화합니다.
	searchInput_start.click();
	// 검색어 입력
	String searchText_start = "대전광역시 서구 둔산로 52 미라클빌딩 3층";
	// 검색어 입력란에 값을 입력합니다.
	searchInput_start.sendKeys(searchText_start);searchInput_start.sendKeys(Keys.ENTER);

	// 도착 버튼 찾기
	WebElement arrivalButton2 = wait_web.until(ExpectedConditions
			.elementToBeClickable(By.cssSelector("div.search_btn_area button.btn_direction.search.active")));
	// 도착 버튼 클릭
	arrivalButton2.click();

	// 도착 버튼 찾기
	WebElement reservat_Button = wait_web.until(ExpectedConditions.elementToBeClickable(
			By.cssSelector("ol.list_pubtrans_directions_step li.is_selected button.btn_pubtrans_reserve")));
	// 도착 버튼 클릭
	reservat_Button.click();

	// 기차 시간표 데이터 크롤링
	WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
	WebElement timetable = wait
			.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='_3-5Oc']")));
	List<WebElement> scheduleRows = timetable.findElements(By.xpath(".//ul[@class='_3tdEo']//li"));for(
	WebElement row:scheduleRows)
	{
		System.out.println(row.getText());
	}

	// WebDriver 종료
	driver.quit();
}}