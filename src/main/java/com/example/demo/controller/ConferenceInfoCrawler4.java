package com.example.demo.controller;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import com.example.demo.vo.Conference;

@Component
public class ConferenceInfoCrawler4 {
    private static WebDriver driver;
    private static String url;

    public static String WEB_DRIVER_ID = "webdriver.chrome.driver";
    public static String WEB_DRIVER_PATH = "C:/work/chromedriver.exe";

	public List<Conference> crawlConference() {
		

		
		
        System.setProperty(WEB_DRIVER_ID, WEB_DRIVER_PATH);

        ChromeOptions options = new ChromeOptions();
        options.setCapability("ignoreProtectedModeSettings", true);

        driver = new ChromeDriver(options);
        url = "https://www.hibrain.net/";
        driver.get(url);

        WebElement researchMenu = driver.findElement(By.xpath("//li[contains(@class, 'menuResearch')]/a"));
        researchMenu.click();

        WebElement conferenceLink = driver.findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/recruits?listType=ING']"));
        conferenceLink.click();

		
        String[] categories = {"E", "P", "M", "H", "S", "AP", "AF", "C", "ALLMJR"};
        int categoryId = 1;
    	List<Conference> conferences = new ArrayList<>();
        for (String categoryCode : categories) {
            WebElement categoryLink = driver.findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/categories/MJR/categories/"
                    + categoryCode + "/recruits?sortType=AD&displayType=TIT&listType=ING&limit=25&siteid=1']"));
            categoryLink.click();
        
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            List<WebElement> conferenceElements = driver.findElements(By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));
            for (WebElement conferenceElement : conferenceElements) {
                System.out.println(conferenceElement.getText());
                WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
                String detailLink = linkElement.getAttribute("href");

                driver.get(detailLink);

                try {
                    WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
                    String title = titleElement.getText();

                    WebElement cntElement = driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
                 // cntElement에서 텍스트를 추출하여 문자열로 반환받습니다.
                    String hitCountText = cntElement.getText();

                    // 문자열로 받은 텍스트를 int 타입으로 파싱합니다.
                    int hitCount = Integer.parseInt(hitCountText);

                    WebElement table = driver.findElement(By.className("contentSummaryInfo"));
                    List<WebElement> rows = table.findElements(By.tagName("tr"));
                    String eventPeriod = "";
                    String applicationPeriod = "";
                    String entryFee = "";
                    String homepage = "";

                    for (WebElement row : rows) {
                        List<WebElement> cells = row.findElements(By.tagName("td"));
                        for (int i = 0; i < cells.size(); i += 2) {
                            String label = cells.get(i).getText();
                            String value = cells.get(i + 1).getText();
                            switch (label) {
                            case "행사기간":
                                eventPeriod = value;
                                break;
                            case "접수기간":
                                applicationPeriod = value;
                                break;
                            case "참가비":
                                entryFee = value;
                                break;
                            case "관련 홈페이지":
                                WebElement linkElement1 = cells.get(i + 1).findElement(By.tagName("a"));
                                homepage = linkElement1.getAttribute("href");
                                break;
                            }
                        }
                    }

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
                	// 장소 정보 가져오기
    				WebElement 장소Element = driver.findElement(By
    						.xpath("//td[@class='tdLabel' and text()='장소']/following-sibling::td[@class='tdLong']//span"));
    				String place = 장소Element.getText();
                    
                    Conference conference = new Conference();

    				conference.setCategoryId(categoryId);
    				conference.setTitle(title);
    				conference.setEventPeriod(eventPeriod);
    				conference.setApplicationPeriod(applicationPeriod);
    				conference.setEntryFee(entryFee);
    				conference.setPlace(place);
    				conference.setHomepage(homepage);
    				conference.setImageURL(imageURL);
    				conference.setHitCount(hitCount);
    				
    				conferences.add(conference);
    				
    				 System.out.println("categoryId: " + conference.getCategoryId());
                     System.out.println("학회제목: " + conference.getTitle());
                     System.out.println("조회수: " + conference.getHitCount());
                     System.out.println("행사기간: " + conference.getEventPeriod());
                     System.out.println("접수기간: " + conference.getApplicationPeriod());
                     System.out.println("참가비: " + conference.getEntryFee());
                     System.out.println("관련홈페이지: " + conference.getHomepage());
                     System.out.println("-----------------------------------");
                     
                     
                    System.out.println("categoryId: " + categoryId);
                    System.out.println("학회제목: " + title);
                    System.out.println("조회수: " + hitCount);
                    System.out.println("행사기간: " + eventPeriod);
                    System.out.println("접수기간: " + applicationPeriod);
                    System.out.println("참가비: " + entryFee);
                    System.out.println("관련홈페이지: " + homepage);
                    System.out.println("-----------------------------------");

                    driver.navigate().back();
  
                    
                } catch (Exception e) {
                	 System.out.println("학회 정보를 가져오는 중에 오류가 발생했습니다: " + e.getMessage());
                    e.printStackTrace();
                }
                
              
            
                
                
            }
            categoryId++; 
        }
        driver.quit();
		return conferences;

    }
	
}
