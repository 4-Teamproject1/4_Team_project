package com.example.demo.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.example.demo.vo.Bus;

@Service
public class BusTicketService2 {

	// 출발지, 도착지, 출발일을 받아서 버스 정보를 가져오는 메서드
	public List<Bus> getBusservice(String departureBus, String arriveBus, String ondate) {
		// 버스 크롤러 인스턴스 생성
		BusCrawler busCrawler = new BusCrawler(departureBus, arriveBus, ondate);
		// 버스 정보 가져오기
		return busCrawler.buscrawl();
	}

	// 버스 크롤러 클래스 정의
	static class BusCrawler {
		private String departureBus;
		private String arriveBus;
		private String ondate;

		// 생성자, controller의 디폴트값밑 JSP쪽의 데이터를 전달받기 위함.
		public BusCrawler(String departureBus, String arriveBus, String ondate) {
			this.departureBus = departureBus;
			this.arriveBus = arriveBus;
			this.ondate = ondate;
		}

		// 버스 정보 가져오는 메서드
		public List<Bus> buscrawl() {
			// WebDriver 설정
			System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");
			WebDriver driver = new ChromeDriver();
			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));

			// 이동할 URL 설정
			String url = "https://www.kobus.co.kr/mrs/rotinf.do";
			driver.get(url);

			// 출발지 입력란 클릭
			WebElement searchInput = driver.findElement(By.cssSelector("ul.place li:first-child a"));
			searchInput.click();
			// 출발지 입력란 활성화
			WebElement activatedSearchInput = wait
					.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));

			// 도착지 입력란 활성화
			String searchText = departureBus;
			activatedSearchInput.sendKeys(searchText);
			// ENTER 키 입력
			activatedSearchInput.sendKeys(Keys.ENTER);

			// 도착지 입력란 활성화
			WebElement activatedSearchInput2 = wait
					.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));
			String searchText2 = arriveBus;
			activatedSearchInput2.sendKeys(searchText2);
			activatedSearchInput2.sendKeys(Keys.ENTER);

			// 날짜 선택
//			WebElement dateElement = wait.until(ExpectedConditions.elementToBeClickable(By.className("text_date")));
//			dateElement.click();
			WebElement element = driver.findElement(By.className("text_date"));
			((JavascriptExecutor) driver).executeScript("arguments[0].click();", element);
			String targetNumber = ondate; // 클릭하고 싶은 날짜의 숫자
			List<WebElement> dateLinks = wait.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(
					By.xpath("//table[@class='ui-datepicker-calendar']//a[@class='ui-state-default']")));
			// 반복문으로 날짜를 찾기
			for (WebElement dateLink : dateLinks) {
				if (dateLink.getText().equals(targetNumber)) {
					dateLink.click();
					break; // 클릭 후 반복문 종료
				}
			}

			// 조회 버튼 클릭
			WebElement nextButton = wait.until(ExpectedConditions.elementToBeClickable(
					By.cssSelector("div.route_box div.tab_cont.clear p.check button.btn_confirm.noHover")));
			nextButton.click();

			// 팝업 처리
			handlePopup(wait);

			List<Bus> busList = new ArrayList<>();

			// routeElements를 가져와서 첫 번째 routeElement만 사용
			List<WebElement> routeElements = wait
					.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(By.cssSelector("div.route_wrap")));
			WebElement routeElement = routeElements.get(0);
			WebElement departureElement = routeElement.findElement(By.cssSelector("p.departure"));
			WebElement arriveElement = routeElement.findElement(By.cssSelector("p.arrive"));
			WebElement takeDrtmElement = routeElement.findElement(By.id("takeDrtm"));

			String departureText = departureElement.getText();
			String arriveText = arriveElement.getText();
			String takeDrtmText = takeDrtmElement.getText();

			// Bus 객체 생성 및 정보 설정
			Bus bus = new Bus();
			bus.setDeparturePlace(departureText);
			bus.setArrivePlace(arriveText);
			bus.setTakesumTime(takeDrtmText);

			busList.add(bus);// bus정보를 list에 추가

			// 버스 시간 정보를 가져와서 busList에 추가
			List<WebElement> spanElements = wait
					.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(By.cssSelector("div.bus_time > p")));
			for (WebElement spanElement : spanElements) {
				Bus bus2 = extractBusInfo(spanElement);
				busList.add(bus2);
			}

			driver.quit();
			return busList;
		}

		// 팝업 처리하는 메서드
		private static void handlePopup(WebDriverWait wait) {
			try {
				Alert alert = wait.until(ExpectedConditions.alertIsPresent());
				alert.accept();
			} catch (Exception e) {
				// 팝업이 나타나지 않는 경우 무시
			}
		}

		// 버스 정보를 추출하는 메서드
		private static Bus extractBusInfo(WebElement pElement) {
			List<WebElement> spanElements = pElement.findElements(
					By.cssSelector("span[class^='start_time'], span[class^='bus_info'], span[class^='remain']"));
			Bus bus = new Bus();
			for (WebElement spanElement : spanElements) {
				String spanClass = spanElement.getAttribute("class");
				String text = spanElement.getText();
				// 태그에 해당하는 요소값을 가져온다.
				if ("start_time".equals(spanClass)) {
					bus.setStartTime(text);
				}
				if ("grade_mo".equals(spanClass)) {
					bus.setGrade(text);
				}
				if ("remain".equals(spanClass)) {
					bus.setRemainingSeats(text);
				}
			}
			// 버스 회사 이름과 등급 정보 추출
			List<WebElement> busInfoElements = pElement
					.findElements(By.cssSelector("p[data-time] > a > span.bus_info"));
			for (WebElement busInfoElementName : busInfoElements) {
				String text = busInfoElementName.getText();
				bus.setCompanyName(text);
			}
			List<WebElement> busInfoElementgrade = pElement
					.findElements(By.cssSelector("p[data-time] > a > span.bus_info > span.grade_mo"));
			for (WebElement busInfoElementName : busInfoElementgrade) {
				String text = busInfoElementName.getText();
				bus.setGrade(text);
			}
			return bus;
		}
	}
}
