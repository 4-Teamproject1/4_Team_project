package com.example.demo.controller;

import com.example.demo.vo.Conference;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;

import java.util.ArrayList;
import java.util.List;

public class ConferenceInfoCrawler2 {
    private static WebDriver driver;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

    public List<Conference> crawlConference() {
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

        return conferenceList;
    }

    private void crawlCategory(String categoryCode, int categoryId, List<Conference> conferenceList) {
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

                // 학회 정보 수집
                Conference conference = extractConferenceInfo(driver, categoryId);

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

    private Conference extractConferenceInfo(WebDriver driver, int categoryId) {
        // 학회 정보 객체 생성
        Conference conference = new Conference();

        // 학회의 제목 추출
        WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
        String title = titleElement.getText();
        conference.setTitle(title);

        // 학회의 조회수 추출
        WebElement cntElement = driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
        String count = cntElement.getText();
        conference.setCount(count);

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

        return conference;
    }

}
