package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import com.example.demo.vo.Conference;

@Component
public class ConferenceInfoCrawler5 {
    private WebDriver driver;

    public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";
    public static final String BASE_URL = "https://www.hibrain.net/";

    public List<Conference> crawlConference() {
        // WebDriver 설정
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);
        ChromeOptions options = new ChromeOptions();
        options.setCapability("ignoreProtectedModeSettings", true);
        driver = new ChromeDriver(options);
        driver.manage().window().maximize(); // Optional: 브라우저 창 최대화

        List<Conference> conferences = new ArrayList<>();

        try {
            driver.get(BASE_URL);

            // 리서치 메뉴 클릭
            WebElement researchMenu = driver.findElement(By.xpath("//li[contains(@class, 'menuResearch')]/a"));
            researchMenu.click();

            // 학회 목록 페이지로 이동
            WebElement conferenceLink = driver.findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/recruits?listType=ING']"));
            conferenceLink.click();

            String[] categories = {"E", "P", "M", "H", "S", "AP", "AF", "C", "ALLMJR"};
            for (String categoryCode : categories) {
                // 각 카테고리별로 학회 목록 페이지로 이동
                String categoryLinkXPath = String.format("//a[@href='/research/researches/33/recruitments/112/categories/MJR/categories/%s/recruits?sortType=AD&displayType=TIT&listType=ING&limit=25&siteid=1']", categoryCode);
                WebElement categoryLink = driver.findElement(By.xpath(categoryLinkXPath));
                categoryLink.click();

                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

                List<WebElement> conferenceElements = driver.findElements(By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));
                for (WebElement conferenceElement : conferenceElements) {
                    WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
                    String detailLink = linkElement.getAttribute("href");

                    driver.get(detailLink);

                    try {
                        // 학회 정보 수집
                        Conference conference = new Conference();
                        conference.setCategoryId(getCategoryId(categoryCode));
                        conference.setTitle(driver.findElement(By.xpath("//div[@class='titleWrap']/h4")).getText());
                        conference.setHitCount(Integer.parseInt(driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']")).getText()));
                        WebElement table = driver.findElement(By.className("contentSummaryInfo"));
                        List<WebElement> rows = table.findElements(By.tagName("tr"));
                        for (WebElement row : rows) {
                            List<WebElement> cells = row.findElements(By.tagName("td"));
                            for (int i = 0; i < cells.size(); i += 2) {
                                String label = cells.get(i).getText();
                                String value = cells.get(i + 1).getText();
                                switch (label) {
                                    case "행사기간":
                                        conference.setEventPeriod(value);
                                        break;
                                    case "접수기간":
                                        conference.setApplicationPeriod(value);
                                        break;
                                    case "참가비":
                                        conference.setEntryFee(value);
                                        break;
                                    case "관련 홈페이지":
                                        conference.setHomepage(cells.get(i + 1).findElement(By.tagName("a")).getAttribute("href"));
                                        break;
                                    case "장소":
                                        conference.setPlace(cells.get(i + 1).findElement(By.tagName("span")).getText());
                                        break;
                                }
                            }
                        }
                        WebElement imageElement = driver.findElement(By.xpath("//div[@class='content cke_editable']//img"));
                        conference.setImageURL(imageElement.getAttribute("src"));
                        
                   

                        // conference 객체의 regDate 속성에 포맷된 날짜를 설정합니다.
                        conference.setRegDate(null);
                        
                        conferences.add(conference);
                    } catch (Exception e) {
                        System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
                    } finally {
                        // 이전 페이지로 이동
                        driver.navigate().back();
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
        return conferences;
    }

    

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
