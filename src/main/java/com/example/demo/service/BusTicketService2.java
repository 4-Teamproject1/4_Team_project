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
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import com.example.demo.vo.Bus;

public class BusTicketService2 {
	public static void main(String[] args) throws InterruptedException {
		System.setProperty("webdriver.chrome.driver",
				"C:\\work\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
		WebDriver driver = new ChromeDriver();
		WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(60));

		String url = "https://www.kobus.co.kr/mrs/rotinf.do";
		driver.get(url);

		// '출발지' 클릭
		WebElement searchInput = driver.findElement(By.cssSelector("ul.place li:first-child a"));
		searchInput.click();

		// 출발
		WebElement activatedSearchInput = wait.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));

		// 검색어 입력
		String searchText = "동서울";
		activatedSearchInput.sendKeys(searchText);
		activatedSearchInput.sendKeys(Keys.ENTER);

		// 도착
		WebElement activatedSearchInput2 = wait.until(ExpectedConditions.elementToBeClickable(By.id("terminalSearch")));

		// 검색어 입력
		String searchText2 = "대전복합";
		activatedSearchInput2.sendKeys(searchText2);
		activatedSearchInput2.sendKeys(Keys.ENTER);

		System.out.println("1");

		// WebDriverWait를 사용하여 닫기 버튼이 클릭 가능할 때까지 대기합니다.
		// WebElement closeButton =
		// wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button.remodal-close")));
		WebElement closeButton = wait.until(
				ExpectedConditions.elementToBeClickable(By.cssSelector("div.remodal-wrapper.full.remodal-is-opened")));
		// 닫기 버튼을 클릭합니다.
		closeButton.click();

		// CSS 선택자를 사용하여 다른 요소를 클릭 대상에서 제외, 위에 버튼기능이 정상작동하기위해 설정.
		// 여기는 조회버튼 클릭.
		WebElement clickableElement3 = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("p#alcnSrchBtn button.btn_confirm.noHover")));
		clickableElement3.click();


		// Alert을 다루기 위해 WebDriver의 switchTo() 메서드를 사용하여 Alert으로 전환합니다.
		Alert alert = driver.switchTo().alert();

		// 확인 버튼을 클릭합니다.
		alert.accept();

		// p 요소 추출
		List<WebElement> pElements = driver.findElements(By.cssSelector("div.bus_time > p"));

		// Bus 객체를 저장할 리스트 생성
		List<Bus> busList = new ArrayList<>();

		// p 요소 반복하여 정보 저장
		for (WebElement pElement : pElements) {
			// Bus 객체를 추출하여 리스트에 추가합니다.
			busList.add(extractBusInfo(pElement));
		}

		// Bus 리스트 출력
		for (Bus bus : busList) {
			System.out.println("-------------------------------------------");
			System.out.println(bus);
		}
	}

	// 각 p 요소에서 Bus 객체를 추출하는 메서드
	private static Bus extractBusInfo(WebElement pElement) {
		// p 요소 내의 span 요소 추출
//		List<WebElement> spanElements = pElement.findElements(By.tagName("span"));
		List<WebElement> spanElements = pElement.findElements(
				By.cssSelector("span[class^='start_time'], span[class^='bus_info'], span[class^='remain']"));
		// Bus 객체 생성
		Bus bus = new Bus();

		// span 요소 반복하여 정보 저장
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
		// CSS 선택자를 사용하여 모든 해당 요소를 찾습니다.
		List<WebElement> busInfoElements = pElement.findElements(By.cssSelector("p[data-time] > a > span.bus_info"));

		// 각 요소의 텍스트를 가져와 출력합니다.
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

//		// 'bus_com' 클래스에 속하는 요소들을 선택합니다.
//		List<WebElement> busComElements = pElement.findElements(By.cssSelector("*"));
//
//		// 각 요소에서 텍스트를 추출하여 출력합니다.
//		for (WebElement element : busComElements) {
//		    // 요소 내의 텍스트를 가져옵니다.
//		    String text = element.getText();
//		    // 텍스트가 비어있지 않다면 출력합니다.
//		    if (!text.isEmpty()) {
//		        System.out.println(text);
//		    }
//		}
		return bus;
	}
}
