package com.example.demo.controller;

import com.example.demo.vo.Conference;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
@Component
public class ConferenceInfoCrawler2 {
    private static WebDriver driver;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    public static void main(String[] args) {
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        // WebDriver 인스턴스 생성
        ChromeOptions options = new ChromeOptions();
        options.setCapability("ignoreProtectedModeSettings", true);
        driver = new ChromeDriver(options);

        // 학술행사 정보 페이지로 이동
        driver.get("https://www.hibrain.net/research/researches/33/recruitments/112/recruits?listType=ING");

        List<Conference> conferenceList = new ArrayList<>();

        // 카테고리 코드와 ID를 저장할 리스트 생성
        List<String> categoryCodes = List.of("E", "P", "M", "H", "S", "AP", "AF", "C", "ALLMJR");
        List<Integer> categoryIds = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9);

        // 각 카테고리별로 크롤링 진행
        for (int i = 0; i < categoryCodes.size(); i++) {
            crawlCategory(categoryCodes.get(i), categoryIds.get(i), conferenceList);
        }

        // WebDriver 종료
        driver.quit();

   
    }

    private static void crawlCategory(String categoryCode, int categoryId, List<Conference> conferenceList) {
        // 카테고리 클릭
        WebElement categoryLink = driver.findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/categories/MJR/categories/"
                + categoryCode + "/recruits?sortType=AD&displayType=TIT&listType=ING&limit=25&siteid=1']"));
        categoryLink.click();

        // 모든 학술행사 목록을 가져옴
        List<WebElement> conferenceElements = driver.findElements(By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));

        // 각 학술행사에 대해 반복문 실행
        for (WebElement conferenceElement : conferenceElements) {
            try {
                // 각 학술행사의 링크를 가져옴
                WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
                String conferenceLink = linkElement.getAttribute("href");

                // 학술행사에 대한 상세 페이지로 이동
                driver.get(conferenceLink);
                
                
                
                String title = "";
				/* String hitCount = ""; */
                
                String eventPeriod = "";
				String applicationPeriod = "";
				String entryFee = "";
				String homepage = "";
				String place = "";
				String imageURL = "";
				
				
                // 학회 정보 수집
                Conference conference = extractConferenceInfo(driver, categoryId);

                
                // 결과 출력
				System.out.println("categoryId: " + categoryId);
				System.out.println("학회제목: " + title);
//				System.out.println("조회수: " + hitCount);
				System.out.println("행사기간: " + eventPeriod);
				System.out.println("접수기간: " + applicationPeriod);
				System.out.println("참가비: " + entryFee);
				System.out.println("장소: " + place);
				System.out.println("관련홈페이지: " + homepage);
				/*
				 * System.out.println("담당자 연락처: " + 담당자연락처); System.out.println("담당자 이메일: " +
				 * 담당자이메일);
				 */
				System.out.println("이미지 URL: " + imageURL);
				System.out.println("-----------------------------------");
                
                
                // 리스트에 추가
                conferenceList.add(conference);
          
                // 뒤로 가기
                driver.navigate().back();
            } catch (Exception e) {
                System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다.");
                e.printStackTrace();
            }
        }
    }

    private static Conference extractConferenceInfo(WebDriver driver, int categoryId) {
        // 학회 정보 객체 생성
        Conference conference = new Conference();

        // 학회의 제목 추출
        WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
        String title = titleElement.getText();
        conference.setTitle(title);

		/*
		 * // 학회의 조회수 추출 WebElement cntElement =
		 * driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
		 * String hitCount = cntElement.getText(); conference.setHitCount(hitCount);
		 */

        // 행사기간 추출
        WebElement eventPeriodElement = driver.findElement(By.xpath("//td[@class='tdLabel' and text()='행사기간']/following-sibling::td"));
        String eventPeriod = eventPeriodElement.getText();
        conference.setEventPeriod(eventPeriod);

        // 접수기간 추출
        WebElement applicationPeriodElement = driver.findElement(By.xpath("//td[@class='tdLabel' and text()='접수기간']/following-sibling::td"));
        String applicationPeriod = applicationPeriodElement.getText();
        conference.setApplcationPeriod(applicationPeriod);

        // 참가비 추출
        WebElement entryFeeElement = driver.findElement(By.xpath("//td[@class='tdLabel' and text()='참가비']/following-sibling::td"));
        String entryFee = entryFeeElement.getText();
        conference.setEntryFee(entryFee);

        // 장소 추출
        WebElement placeElement = driver.findElement(By.xpath("//td[@class='tdLabel' and text()='장소']/following-sibling::td"));
        String place = placeElement.getText();
        conference.setPlace(place);

        // 관련 홈페이지 추출
        WebElement homepageElement = driver.findElement(By.xpath("//td[@class='tdLabel' and text()='관련 홈페이지']/following-sibling::td/a"));
        String homepage = homepageElement.getAttribute("href");
        conference.setHomepage(homepage);

        
    	// 이미지 요소 찾기
		WebElement imageElement = null;
		try {
			imageElement = driver.findElement(By.xpath("//div[@class='content cke_editable']//img"));
		} catch (Exception e) {
			// 이미지가 없는 경우
			System.out.println("이미지를 찾을 수 없습니다.");
		}

		// 이미지가 있는 경우에만 URL 가져오기
		String imageURL = "";
		if (imageElement != null) {
			imageURL = imageElement.getAttribute("src");
		}
        
        return conference;
    }

}
