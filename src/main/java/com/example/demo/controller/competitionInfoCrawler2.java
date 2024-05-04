package com.example.demo.controller;

import java.time.Duration;
import java.util.List;
import java.util.NoSuchElementException;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class competitionInfoCrawler2 {
	private WebDriver driver;
	private String url;

	public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static String WEB_DRIVER_PATH = "C:\\Users\\hunt0\\Desktop\\Eclipse\\chromedriver-win64/chromedriver.exe";

	public static void main(String[] args) {
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

		// ChromeOptions 설정
		ChromeOptions options = new ChromeOptions();
		options.setCapability("ignoreProtectedModeSettings", true);

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver(options);

		// 하이브레인넷 학술행사 정보 페이지 URL
		String url = "https://www.hibrain.net/";

		// 학술행사 정보 페이지로 이동
		driver.get(url);

		
		
		// 학술행사 메뉴 클릭
		WebElement researchMenu = driver.findElement(By.xpath("//li[contains(@class, 'menuResearch')]/a"));
		researchMenu.click();

		// 학술행사 상세페이지로 이동
		WebElement conferenceLink = driver
				.findElement(By.xpath("//a[@href='/research/researches/486/recruitments/115/recruits?listType=ING']"));
		conferenceLink.click();
		// 모든 학술행사 목록을 가져옴
		List<WebElement> conferenceElements = driver.findElements(
				By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));

		// 각 학술행사에 대해 반복문 실행
		for (WebElement conferenceElement : conferenceElements) {

			WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
			String conferenceLink1 = linkElement.getAttribute("href");

			// 학술행사에 대한 상세 페이지로 이동
			driver.get(conferenceLink1);

			try {
				// 상세페이지에서 학회의 제목 추출
				WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
				String title = titleElement.getText();
				// 테이블에서 필요한 정보를 가져오기
				WebElement table = driver.findElement(By.className("contentSummaryInfo"));
				List<WebElement> rows = table.findElements(By.tagName("tr"));

				
				String applicationPeriod = "";
				String homepage = "";
				String totalPrizeMoney = "";
				String firstPrizeMoney = "";
				String contactNum = "";
				String contactEmail = "";

				for (WebElement row : rows) {
					List<WebElement> cells = row.findElements(By.tagName("td"));
					for (int i = 0; i < cells.size(); i += 2) {
						String label = cells.get(i).getText();
						String value = cells.get(i + 1).getText();
						switch (label) {
						case "접수기간":
							applicationPeriod = value;
							break;
						case "총시상금":
							totalPrizeMoney = value;
							break;
						case "1등시상금":
							firstPrizeMoney = value;
							break;
						case "관련 홈페이지":
							WebElement linkElement1 = cells.get(i + 1).findElement(By.tagName("a"));
							homepage = linkElement1.getAttribute("href");
							break;
						case "담당자 연락처":
							contactNum = value;
							break;
						case "담당자 이메일":
							contactEmail = value;
							break;
						}
					}
				}

				

				// 이미지 요소 찾기
				WebElement imageElement = driver.findElement(By.xpath("//div[@class='viewBody']//img"));
				// 이미지의 src 속성값 가져오기
				String imageURL = imageElement.getAttribute("src");

				// 결과 출력

				// 결과 출력
				 System.out.println("공모전제목: " + title);
				System.out.println("총시상금: " + totalPrizeMoney);
				System.out.println("접수기간: " + applicationPeriod);
				System.out.println("일등시상금: " + firstPrizeMoney);
				System.out.println("관련 홈페이지: " + homepage);
				System.out.println("담당자 연락처: " + contactNum);
				System.out.println("담당자 이메일: " + contactEmail);
				System.out.println("이미지 URL: " + imageURL);
				/*
				 * System.out.println("장소: " + 장소); // 추가된 출력 System.out.println("주소2: " + 주소2);
				 * // 추가된 출력
				 * 
				 */ // 결과 출력
				/*
				 * System.out.println("담당자 연락처: " + (담당자연락처.isEmpty() ? "" : 담당자연락처));
				 * System.out.println("담당자 이메일: " + (담당자이메일.isEmpty() ? "" : 담당자이메일));
				 */
				/* System.out.println("조회수: " + 조회수); */

				driver.navigate().back();

			} catch (Exception e) {
				System.out.println("공모전 정보를 가져오는 중에 오류가 발생했습니다.");
				e.printStackTrace();
			}
		}
	}
}