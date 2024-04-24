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

public class exhibitInfoCrawler5 {
	private WebDriver driver;
	private String url;

	public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

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
				String 공모전제목 = titleElement.getText();
				// 테이블에서 필요한 정보를 가져오기
				WebElement table = driver.findElement(By.className("contentSummaryInfo"));
				List<WebElement> rows = table.findElements(By.tagName("tr"));

				
				String 접수기간 = "";
				String 관련홈페이지 = "";
				String 총시상금 = "";
				String 일등시상금 = "";
				String 담당자연락처 = "";
				String 담당자이메일 = "";

				for (WebElement row : rows) {
					List<WebElement> cells = row.findElements(By.tagName("td"));
					for (int i = 0; i < cells.size(); i += 2) {
						String label = cells.get(i).getText();
						String value = cells.get(i + 1).getText();
						switch (label) {
						case "접수기간":
							접수기간 = value;
							break;
						case "총시상금":
							총시상금 = value;
							break;
						case "1등시상금":
							일등시상금 = value;
							break;
						case "관련 홈페이지":
							WebElement linkElement1 = cells.get(i + 1).findElement(By.tagName("a"));
							관련홈페이지 = linkElement1.getAttribute("href");
							break;
						case "담당자 연락처":
							담당자연락처 = value;
							break;
						case "담당자 이메일":
							담당자이메일 = value;
							break;
						}
					}
				}

				/*
				 * // WebDriverWait를 사용하여 페이지가 완전히 로드될 때까지 대기 WebDriverWait wait = new
				 * WebDriverWait(driver, Duration.ofSeconds(10));
				 * wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath(
				 * "//div[@class='titleWrap']/h4")));
				 */
				/*
				 * WebElement detailLink = driver .findElement(By.
				 * xpath("//a[contains(@title, '동북아역사재단 영문저널 JNAH 21-1호 영문 논문 모집')]"));
				 * detailLink.click();
				 */
				/*
				 * // 상세페이지에서 학회의 제목 추출 WebElement titleElement =
				 * driver.findElement(By.xpath("//div[@class='titleWrap']/h4")); String 학회제목 =
				 * titleElement.getText();
				 * 
				 * // 상세페이지에서 조회수 요소를 찾기 위해 <li> 태그의 클래스가 "cnt"인 요소를 찾고 그 안에 있는 <span> 태그의 클래스가
				 * // "bold"인 요소를 찾습니다. WebElement cntElement =
				 * driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
				 * String 조회수 = cntElement.getText();
				 * 
				 * // 접수기간 WebElement dateElement =
				 * driver.findElement(By.xpath("//td[text()='접수기간']/following-sibling::td"));
				 * String date = dateElement.getText();
				 * 
				 * // 관련 홈페이지 WebElement websiteElement =
				 * driver.findElement(By.xpath("//td[text()='관련 홈페이지']/following-sibling::td/a")
				 * ); String website = websiteElement.getAttribute("href");
				 * 
				 * // 담당자 연락처 String contact = ""; try { WebElement contactElement =
				 * driver.findElement(By.
				 * xpath("//td[text()='담당자 연락처']/following-sibling::td/span")); contact =
				 * contactElement.getText(); } catch (NoSuchElementException e) { // 담당자 연락처 정보가
				 * 없을 경우 공백으로 처리 contact = ""; }
				 * 
				 * // 담당자 이메일 String email = ""; try { WebElement emailElement =
				 * driver.findElement(By.xpath("//td[text()='담당자 이메일']/following-sibling::td"));
				 * email = emailElement.getText(); } catch (NoSuchElementException e) { // 담당자
				 * 이메일 정보가 없을 경우 공백으로 처리 email = ""; }
				 */

				// 이미지 요소 찾기
				WebElement imageElement = driver.findElement(By.xpath("//div[@class='viewBody']//img"));
				// 이미지의 src 속성값 가져오기
				String imageURL = imageElement.getAttribute("src");

				// 결과 출력

				// 결과 출력
				 System.out.println("공모전제목: " + 공모전제목);
				System.out.println("총시상금: " + 총시상금);
				System.out.println("접수기간: " + 접수기간);
				System.out.println("일등시상금: " + 일등시상금);
				System.out.println("관련 홈페이지: " + 관련홈페이지);
				System.out.println("담당자 연락처: " + 담당자연락처);
				System.out.println("담당자 이메일: " + 담당자이메일);
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
				System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다.");
				e.printStackTrace();
			}
		}
	}
}