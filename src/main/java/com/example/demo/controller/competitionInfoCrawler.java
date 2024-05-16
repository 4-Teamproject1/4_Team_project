package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Component;

import com.example.demo.vo.Competition;

@Component
public class competitionInfoCrawler {
	private WebDriver driver;

	// WebDriver 설정
	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
	public static final String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";
	public static final String BASE_URL = "https://www.hibrain.net/";

	// 학술행사 정보 크롤링 메서드
	public List<Competition> crawlCompetition() {
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

		// ChromeOptions 설정
		ChromeOptions options = new ChromeOptions();
		options.setCapability("ignoreProtectedModeSettings", true);

		// WebDriver 인스턴스 생성
		WebDriver driver = new ChromeDriver(options);

		driver.manage().window().maximize(); // 브라우저 창 최대화

		List<Competition> competitions = new ArrayList<>();

		try {
			driver.get(BASE_URL);

			// 학술행사 메뉴 클릭
			WebElement researchMenu = driver.findElement(By.xpath("//li[contains(@class, 'menuResearch')]/a"));
			researchMenu.click();

			// 학술행사 상세페이지로 이동
			WebElement conferenceLink = driver.findElement(
					By.xpath("//a[@href='/research/researches/486/recruitments/115/recruits?listType=ING']"));
			conferenceLink.click();

			// 모든 학술행사 목록을 가져옴
			List<WebElement> conferenceElements = driver.findElements(
					By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));

			// 각 학술행사에 대해 반복문 실행
			for (int j = 2; j < conferenceElements.size(); j++) {
				WebElement conferenceElement = conferenceElements.get(j);
				WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
				String conferenceLink1 = linkElement.getAttribute("href");

				// 학술행사에 대한 상세 페이지로 이동
				driver.get(conferenceLink1);

				try {
					Competition competition = new Competition();

					// 상세페이지에서 학회의 제목 추출
					WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
					String title = titleElement.getText();
					competition.setTitle(title); // 제목 설정

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
								competition.setApplicationPeriod(applicationPeriod); // 접수기간 설정
								break;
							case "총시상금":
								totalPrizeMoney = value;
								competition.setTotalPrizeMoney(totalPrizeMoney); // 총시상금 설정
								break;
							case "1등시상금":
								firstPrizeMoney = value;
								competition.setFirstPrizeMoney(firstPrizeMoney); // 1등시상금 설정
								break;
							case "관련 홈페이지":
								WebElement linkElement1 = cells.get(i + 1).findElement(By.tagName("a"));
								homepage = linkElement1.getAttribute("href");
								competition.setHomepage(homepage); // 관련 홈페이지 설정
								break;
							case "담당자 연락처":
								contactNum = value;
								competition.setContactNum(contactNum); // 담당자 연락처 설정
								break;
							case "담당자 이메일":
								contactEmail = value;
								competition.setContactEmail(contactEmail); // 담당자 이메일 설정
								break;
							}
						}
					}

					// 이미지 요소 찾기
					WebElement imageElement = driver.findElement(By.xpath("//div[@class='viewBody']//img"));
					// 이미지의 src 속성값 가져오기
					String imageURL = imageElement.getAttribute("src");
					competition.setImageURL(imageURL); // 이미지 URL 설정

					// 정보 출력
					System.out.println("공모전제목: " + competition.getTitle());
					System.out.println("접수기간: " + competition.getApplicationPeriod());
					System.out.println("총시상금: " + competition.getTotalPrizeMoney());
					System.out.println("1등시상금: " + competition.getFirstPrizeMoney());
					System.out.println("관련 홈페이지: " + competition.getHomepage());
					System.out.println("담당자 연락처: " + competition.getContactNum());
					System.out.println("담당자 이메일: " + competition.getContactEmail());
					System.out.println("이미지 URL: " + competition.getImageURL());

					competitions.add(competition); // 공모전 정보를 리스트에 추가

					System.out.println("공모전 정보: " + competition); // 공모전 정보 출력 (toString 메서드 사용 가정)
					driver.navigate().back(); // 뒤로 가기

				} catch (Exception e) {
					System.out.println("공모전 정보를 가져오는 중에 오류가 발생했습니다.");
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			System.out.println("크롤링 중 오류가 발생했습니다: " + e.getMessage());
		} finally {
			if (driver != null) {
				driver.quit(); // WebDriver 종료
			}
		}
		return competitions; // 공모전 정보 리스트 반환
	}
}
