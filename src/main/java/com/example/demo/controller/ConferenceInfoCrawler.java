package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.NoSuchElementException;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import com.example.demo.vo.Conference;

@Component
public class ConferenceInfoCrawler {
	private WebDriver driver;

	public static final String WEB_DRIVER_ID = "webdriver.chrome.driver"; // WebDriver의 ID
	public static final String WEB_DRIVER_PATH = "C:/work/chromedriver.exe"; // WebDriver의 경로
	public static final String BASE_URL = "https://www.hibrain.net/"; // 크롤링할 사이트의 기본 URL

	public List<Conference> crawlConference() {
		// WebDriver 설정
		System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
		ChromeOptions options = new ChromeOptions();
		options.setCapability("ignoreProtectedModeSettings", true);
		driver = new ChromeDriver(options);
		driver.manage().window().maximize(); // 브라우저 창 최대화

		List<Conference> conferences = new ArrayList<>(); // 학회 정보를 담을 리스트

		try {
			driver.get(BASE_URL); // 사이트 접속

			// 리서치 메뉴 클릭
			WebElement researchMenu = driver.findElement(By.xpath("//li[contains(@class, 'menuResearch')]/a"));
			researchMenu.click();

			// 학회 목록 페이지로 이동
			WebElement conferenceLink = driver.findElement(
					By.xpath("//a[@href='/research/researches/33/recruitments/112/recruits?listType=ING']"));
			conferenceLink.click();

			String[] categories = { "E", "P", "M", "H", "S", "AP", "AF", "C", "ALLMJR" }; // 카테고리 코드 배열
			for (String categoryCode : categories) {
				// 각 카테고리별로 학회 목록 페이지로 이동
				String categoryLinkXPath = String.format(
						"//a[@href='/research/researches/33/recruitments/112/categories/MJR/categories/%s/recruits?sortType=AD&displayType=TIT&listType=ING&limit=25&siteid=1']",
						categoryCode);
				WebElement categoryLink = driver.findElement(By.xpath(categoryLinkXPath));
				categoryLink.click();

				WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10)); // WebDriver 대기 설정

				List<WebElement> conferenceElements = driver.findElements(
						By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));
				for (WebElement conferenceElement : conferenceElements) {
					WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
					String detailLink = linkElement.getAttribute("href");

					driver.get(detailLink); // 학회 상세 페이지로 이동

					try {
						// 학회 정보 수집
						Conference conference = new Conference();
						conference.setCategoryId(getCategoryId(categoryCode)); // 카테고리 ID 설정
						conference.setTitle(driver.findElement(By.xpath("//div[@class='titleWrap']/h4")).getText()); // 학회
																														// 제목
																														// 설정

						// 테이블에서 필요한 정보를 가져오기
						WebElement table = driver.findElement(By.className("contentSummaryInfo"));
						List<WebElement> rows = table.findElements(By.tagName("tr"));
						for (WebElement row : rows) {
							List<WebElement> cells = row.findElements(By.tagName("td"));
							for (int i = 0; i < cells.size(); i += 2) {
								String label = cells.get(i).getText(); // 라벨 가져오기
								String value = cells.get(i + 1).getText(); // 값 가져오기
								switch (label) {
								case "행사기간":
									conference.setEventPeriod(value); // 행사 기간 설정
									break;
								case "접수기간":
									conference.setApplicationPeriod(value); // 접수 기간 설정
									break;
								case "참가비":
									conference.setEntryFee(value); // 참가비 설정
									break;
								case "관련 홈페이지":
									conference.setHomepage(
											cells.get(i + 1).findElement(By.tagName("a")).getAttribute("href")); // 관련
																													// 홈페이지
																													// 설정
									break;
								case "장소":
									conference.setPlace(cells.get(i + 1).findElement(By.tagName("span")).getText()); // 장소
																														// 설정
									break;
								}
							}
						}

						// 장소 정보를 추가로 추출
						WebElement additionalInfo = driver.findElement(By.xpath(
								"//h4[contains(text(),'장소/교통편')]/ancestor::div[@class='viewFooter marginFooter']//span[@class='left']"));
						String location = additionalInfo.getText();
						conference.setPlace(location);

						// 이미지 URL 설정
						WebElement imageElement = driver
								.findElement(By.xpath("//div[@class='content cke_editable']//img"));
						conference.setImageURL(imageElement.getAttribute("src"));

						// 실제 주소 정보 추출
						try {
							// "지도보기"를 클릭하여 지도가 나타난 후 주소 정보를 가져오는 코드
							WebElement dynamicMapShow = driver.findElement(By.id("dynamicMapShow"));
							dynamicMapShow.click();

							Thread.sleep(2000); // 일시적인 대기

							// 지도 영역 안에 있는 주소 정보 추출
							WebElement addressElement = driver
									.findElement(By.xpath("//div[@id='mapAddressView']//span[@class='address']"));
							String address = addressElement.getText();
							conference.setAddress(address);

							System.err.println("주소 정보: " + address);
						} catch (NoSuchElementException e) {
							System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
						} catch (Exception e) {
							System.out.println("기타 오류가 발생했습니다: " + e.getMessage());
						}

						// 회원 가입일자를 설정하지 않음
						conference.setRegDate(null);

						conferences.add(conference); // 학회 정보 리스트에 추가
					} catch (Exception e) {
						System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
					} finally {
						driver.navigate().back(); // 이전 페이지로 이동
					}
				}
			}
		} catch (Exception e) {
			System.out.println("크롤링 중 오류가 발생했습니다: " + e.getMessage());
		} finally {
			if (driver != null) {
				driver.quit();
			}
		}
		return conferences; // 수집한 학회 정보 리스트 반환
	}

	// 카테고리 코드에 따른 카테고리 ID 설정 메서드
	private int getCategoryId(String categoryCode) {
		switch (categoryCode) {
		case "E":
			return 1;
		case "P":
			return 2;
		case "M":
			return 3;
		case "H":
			return 4;
		case "S":
			return 5;
		case "AP":
			return 6;
		case "AF":
			return 7;
		case "C":
			return 8;
		case "ALLMJR":
			return 9;
		default:
			return 0;
		}
	}
}
