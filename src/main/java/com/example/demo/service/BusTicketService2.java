package com.example.demo.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.Alert;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.example.demo.vo.Bus;

@Service
public class BusTicketService2 {
	public List<Bus> getBusservice(String departureBus, String arriveBus) {
		
		 System.err.println("Departure Bus: " + departureBus);
		 System.err.println("arriveBus Bus: " + arriveBus);
		buscrawl buscrawler = new buscrawl(departureBus, arriveBus);
		return buscrawler.buscrawl();
	}
	
	private static void handlePopup(WebDriverWait wait) {
	    try {
	        Alert alert = wait.until(ExpectedConditions.alertIsPresent());
	        alert.accept();
	    } catch (Exception e) {
	        // 팝업이 나타나지 않는 경우 무시
	    }
	}
	static class buscrawl {
		private String departureBus;
		private String arriveBus;
		
		public buscrawl(String departureBus, String arriveBus) {
			this.departureBus = departureBus;
			this.arriveBus = arriveBus;
		}

		public List<Bus> buscrawl() {
//			System.setProperty("webdriver.chrome.driver",
//					"C:/work/chromedriver-win64/chromedriver-win64/chromedriver.exe");
			System.setProperty("webdriver.chrome.driver",
					"C:\\Users\\hunt0\\Desktop\\Eclipse\\chromedriver-win64\\chromedriver.exe");
			WebDriver driver = new ChromeDriver();
			WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(30));

			String url = "https://www.kobus.co.kr/mrs/rotinf.do";
			driver.get(url);

			WebElement searchInput = driver.findElement(By.cssSelector("ul.place li:first-child a"));
			searchInput.click();
			WebElement activatedSearchInput = wait
					.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));

			String searchText = departureBus;
			activatedSearchInput.sendKeys(searchText);
			activatedSearchInput.sendKeys(Keys.ENTER);

			WebElement activatedSearchInput2 = wait
					.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));
			
			String searchText2 = arriveBus;
			activatedSearchInput2.sendKeys(searchText2);
			activatedSearchInput2.sendKeys(Keys.ENTER);
			
			// 날짜를 선택하기 위해 달력 클래스 상위 영역 요소 찾기
			WebElement dateElement = wait.until(ExpectedConditions.elementToBeClickable(By.className("text_date")));
			// 요소 클릭
			dateElement.click();
			
			
			//날짜 선택
			String targetNumber = "10"; // 클릭하고 싶은 날짜의 숫자
			List<WebElement> dateLinks = wait.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(By.xpath("//table[@class='ui-datepicker-calendar']//a[@class='ui-state-default']")));
			for (WebElement dateLink : dateLinks) {
			    if (dateLink.getText().equals(targetNumber)) {
			        dateLink.click();
			        break; // 클릭 후 반복문 종료
			    }
			}
		

			// 조회 버튼 클릭
			WebElement nextButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.route_box div.tab_cont.clear p.check button.btn_confirm.noHover")));
			nextButton.click();
				
			
			Alert alert = wait.until(ExpectedConditions.alertIsPresent());
			alert.accept();

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

			Bus bus = new Bus();
			bus.setDeparturePlace(departureText);
			bus.setArrivePlace(arriveText);
			bus.setTakesumTime(takeDrtmText);

			busList.add(bus);
			List<WebElement> spanElements = wait
					.until(ExpectedConditions.visibilityOfAllElementsLocatedBy(By.cssSelector("div.bus_time > p")));
			for (WebElement spanElement : spanElements) {
				Bus bus2 = extractBusInfo(spanElement);
				busList.add(bus2);
			}

			driver.quit();
			return busList;
		}

		private static Bus extractBusInfo(WebElement pElement) {
			List<WebElement> spanElements = pElement.findElements(
					By.cssSelector("span[class^='start_time'], span[class^='bus_info'], span[class^='remain']"));
			Bus bus = new Bus();
			for (WebElement spanElement : spanElements) {
				String spanClass = spanElement.getAttribute("class");
				String text = spanElement.getText();
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