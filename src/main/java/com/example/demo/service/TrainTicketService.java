package com.example.demo.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.demo.vo.Article;

@Service
public class TrainTicketService {

	public List<Article> gettrainservice() {
		crawl crawler = new crawl();
		return crawler.crawl();
	}

	static class crawl {
		public List<Article> crawl() {
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
			WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(10));

			// 검색창이 활성화될 때까지 기다림
			WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

			// 검색어 입력
			String searchText = "서울 용산구 한강대로 405";
			activatedSearchInput.sendKeys(searchText);

			// 엔터 입력 (검색 실행)
			activatedSearchInput.sendKeys(Keys.ENTER);

			// 도착 버튼 클릭
			clickArrivalButton(wait_web);

			// 출발지 입력
			enterDepartureLocation(wait_web);

			// 길찾기 버튼 클릭
			clickFindPathButton(wait_web);

			// 기차역 예매 버튼 클릭
			clickTrainReservationButton(wait_web);

			// 대기 시간을 추가하여 iframe을 찾음
			WebElement iframeElement = wait_web
					.until(ExpectedConditions.presenceOfElementLocated(By.id("trainScheduleIframe")));

			// iframe으로 전환
			driver.switchTo().frame(iframeElement);

			// 기차 시간표 조회 결과 출력

			printTrainTimetable(driver, wait_web);

			// 기차 시간표 조회 결과 출력

			List<Article> spanTexts = printTrainTimetable(driver);
	        // 브라우저 닫기
	        driver.quit();
			return spanTexts; // 크롤링 결과를 반환하도록 수정해야 함
		}

		private static void clickArrivalButton(WebDriverWait wait_web) {
			WebElement arrivalButton = wait_web.until(ExpectedConditions
					.elementToBeClickable(By.cssSelector("div.btn_area div.btn_box.direction button.btn_goal")));
			arrivalButton.click();
		}

		private static void clickFindPathButton(WebDriverWait wait_web) {
			WebElement findPathButton = wait_web.until(
					ExpectedConditions.elementToBeClickable(By.cssSelector("button.btn_direction.search.active")));
			findPathButton.click();
		}

		private static void enterDepartureLocation(WebDriverWait wait_web) {
			WebElement searchInput_start = wait_web.until(ExpectedConditions
					.elementToBeClickable(By.cssSelector("div.search_input_wrap div.search_input input.input_search")));
			searchInput_start.click();
			searchInput_start.clear(); // 입력란을 비웁니다.
			String searchText_start = "대전역";
			searchInput_start.sendKeys(searchText_start);
			searchInput_start.sendKeys(Keys.ENTER);
		}

		private static void clickTrainReservationButton(WebDriverWait wait_web) {
			WebElement trainButton = wait_web.until(ExpectedConditions.elementToBeClickable(
					By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve")));
//        trainButton.click();
			trainButton.sendKeys(Keys.ENTER);

		}

		private static void printTrainTimetable(WebDriver driver, WebDriverWait wait_web) {
			// 시간표를 감싸는 부모 요소의 CSS 선택자를 수정합니다.

			String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa ";

			// 시간표를 감싸는 부모 요소가 로딩될 때까지 대기
			WebElement parentElement = wait_web
					.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(cssSelector)));

			// 부모 요소 아래에 있는 모든 span 요소를 가져옵니다.
			List<WebElement> spanElements = parentElement.findElements(By.tagName("li"));
			if (spanElements.size() > 0) {
				// 각 span 요소에 대해 반복하여 텍스트를 출력합니다.
				for (WebElement spanElement : spanElements) {
					// 해당 span 요소의 텍스트를 출력합니다.
					System.out.println("텍스트: " + spanElement.getText());
				}
			} else {
				System.out.println("li 요소를 찾지 못했습니다.");
			}
		}

		private static List<Article> printTrainTimetable(WebDriver driver) {
		    // 시간표를 감싸는 부모 요소의 CSS 선택자를 수정합니다.
		    String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa li";

		    // 부모 요소 아래에 있는 모든 li 요소를 가져옵니다.
		    List<WebElement> liElements = driver.findElements(By.cssSelector(cssSelector));

		    // span 요소의 텍스트를 저장할 리스트 생성
		    List<Article> spanTexts = new ArrayList<>();

		    // 각 li 요소에 대해 반복하여 span 태그의 정보를 저장합니다.
		    for (WebElement liElement : liElements) {
		        // li 요소에서 span 태그의 정보만을 가져옵니다.
		        List<WebElement> spanElements = liElement.findElements(By.tagName("span"));

		        // Article 객체 생성
		        Article article = new Article();

		        // 각 span 요소에 대해 반복하여 정보를 저장합니다.
		        for (WebElement spanElement : spanElements) {
		            // span 태그의 클래스가 특정한 클래스인 경우에만 정보를 저장합니다.
		            String spanClass = spanElement.getAttribute("class");
		            if (spanClass.equals("H13fR_En7MQuoMExYcWk")) {
		                // 해당 span 요소의 텍스트를 Article 객체에 추가합니다.
		                article.setTrainName(spanElement.getText());
		            } else if (spanClass.equals("qkW1KAbn7fcP07KPJ9EA")) {
		                // 해당 span 요소의 텍스트를 Article 객체에 추가합니다.
		                article.setDepartureTime(spanElement.getText());
		            }
		        }

		        // Article 객체를 spanTexts 리스트에 추가합니다.
		        spanTexts.add(article);
		    }

		    return spanTexts;
		}
	}
}