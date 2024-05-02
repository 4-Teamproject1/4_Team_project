package com.example.demo.controller;

import java.time.Duration;
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
public class ConferenceInfoCrawler6 {
    private static WebDriver driver;

    public static final String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static final String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";
    public static final String BASE_URL = "https://www.hibrain.net/";

    public static void main(String[] args) {
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
                                        String location = cells.get(i + 1).findElement(By.tagName("span")).getText();
                                        conference.setPlace(location);
                                        break;
                                }
                            }
                        }
                        // 추가 정보에서 장소 추출
                        WebElement additionalInfo = driver.findElement(By.xpath("//h4[contains(text(),'장소/교통편')]/ancestor::div[@class='viewFooter marginFooter']//span[@class='left']"));
                        String location = additionalInfo.getText();
                        conference.setPlace(location);

                        // 이미지 URL 추출
                        WebElement imageElement = driver.findElement(By.xpath("//div[@class='content cke_editable']//img"));
                        conference.setImageURL(imageElement.getAttribute("src"));
                        
                        //실제 주소정보 추출
                        try {
                            // "지도보기"를 클릭하여 지도가 나타난 후 주소 정보를 가져오는 코드
                            WebElement dynamicMapShow = driver.findElement(By.id("dynamicMapShow"));
                            dynamicMapShow.click();

                            // 지도가 나타날 때까지 대기 (충분한 시간이 필요하다면 WebDriverWait를 사용하여 대기할 수 있습니다)
                            Thread.sleep(2000); // 일시적인 대기 시간 예시

                            // 지도 영역 안에 있는 주소 정보 추출
                            WebElement addressElement = driver.findElement(By.xpath("//div[@id='mapAddressView']//span[@class='address']"));
                            String address = addressElement.getText();

                            System.err.println("주소 정보: " + address);
                        } catch (NoSuchElementException e) {
                            // 요소를 찾을 수 없는 경우에 대한 예외 처리
                            System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
                        } catch (Exception e) {
                            // 기타 예외 발생 시에 대한 예외 처리
                            System.out.println("기타 오류가 발생했습니다: " + e.getMessage());
                        }


                        // conference 객체의 regDate 속성에 포맷된 날짜를 설정합니다.
                        conference.setRegDate(null);

                        System.out.println("수집된 학회 정보: " + conference.toString());

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
        /* return conferences; */
    }

    private static int getCategoryId(String categoryCode) {
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
