package com.example.demo.controller;

import java.time.Duration;
import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class ConferenceInfoCrawler6 {
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
                .findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/recruits?listType=ING']"));
        conferenceLink.click();
        // 카테고리 목록 가져오기
        List<WebElement> categories = driver.findElements(By.xpath("//ul[@id='menuCoutLinst']/li[position() > 1]/a"));

        // 각 카테고리에 대해 반복문 실행
        for (WebElement category : categories) {
            System.out.println("카테고리: " + category.getText());

            // 각 카테고리 클릭
            category.click();

            // 모든 학술행사 목록을 가져옴
            List<WebElement> conferenceElements = driver.findElements(
                    By.xpath("//div[@class='contentBody']//ul[@id='articleList']//li[@class='row sortRoot']"));

            // 각 학술행사에 대해 반복문 실행
            for (WebElement conferenceElement : conferenceElements) {
                // 각 학술행사의 제목을 가져옴
                WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
                WebElement titleElement = wait.until(ExpectedConditions
                        .visibilityOfElementLocated(By.xpath(".//span[@class='title titleImageNone']")));
                String conferenceTitle = titleElement.getText();

                // 학술행사의 링크를 가져옴
                WebElement linkElement = conferenceElement.findElement(By.tagName("a"));
                String conferenceLink1 = linkElement.getAttribute("href");

                // 결과 출력
                System.out.println("학술행사 제목: " + conferenceTitle);
                System.out.println("학술행사 링크: " + conferenceLink1);
                titleElement.click();
                try {
                    // 상세페이지에서 학회의 제목 추출
                    WebElement titleElement2 = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
                    String 학회제목 = titleElement2.getText();

                    // 상세페이지에서 조회수 요소를 찾기 위해 <li> 태그의 클래스가 "cnt"인 요소를 찾고 그 안에 있는 <span> 태그의 클래스가
                    // "bold"인 요소를 찾습니다.
                    WebElement cntElement = driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
                    String 조회수 = cntElement.getText();

                    // 테이블에서 행사기간, 접수기간, 참가비, 관련 홈페이지 정보 가져오기
                    WebElement table = driver.findElement(By.className("contentSummaryInfo"));
                    List<WebElement> rows = table.findElements(By.tagName("tr"));
                    String 행사기간 = "";
                    String 접수기간 = "";
                    String 참가비 = "";
                    String 관련홈페이지 = "";

                    for (WebElement row : rows) {
                        List<WebElement> cells = row.findElements(By.tagName("td"));
                        for (int i = 0; i < cells.size(); i += 2) {
                            String label = cells.get(i).getText();
                            String value = cells.get(i + 1).getText();
                            switch (label) {
                                case "행사기간":
                                    행사기간 = value;
                                    break;
                                case "접수기간":
                                    접수기간 = value;
                                    break;
                                case "참가비":
                                    참가비 = value;
                                    break;
                                case "관련 홈페이지":
                                    WebElement linkElement1 = cells.get(i + 1).findElement(By.tagName("a"));
                                    관련홈페이지 = linkElement1.getAttribute("href");
                                    break;
                            }
                        }
                    }
                    
            		// 테이블에서 담당자 연락처와 이메일 정보 가져오기
            		String 담당자연락처 = "";
            		String 담당자이메일 = "";

            		// 각각의 정보가 포함된 <tr> 요소들을 찾습니다.
            		List<WebElement> contactRows = driver.findElements(By.xpath("//table[@class='contentSummaryInfo']/tbody/tr"));

            		// 각 <tr> 요소들을 순회하면서 정보를 추출합니다.
            		for (WebElement contactRow : contactRows) {
            			// 각 <tr> 요소 안에 있는 <td> 요소들을 가져옵니다.
            			List<WebElement> cells = contactRow.findElements(By.tagName("td"));
            			for (int i = 0; i < cells.size(); i += 2) {
            				// 각 라벨과 값에 해당하는 <td> 요소를 가져옵니다.
            				String label = cells.get(i).getText();
            				String value = cells.get(i + 1).getText();

            				// 라벨에 따라 정보를 저장합니다.
            				switch (label) {
            				case "담당자 연락처":
            					// 연락처 정보를 저장합니다.
            					// 이 경우, 담당자 연락처는 <span> 안에 있습니다.
            					// 여기서는 숫자만 추출하여 저장합니다.
            					담당자연락처 = cells.get(i + 1).findElement(By.tagName("span")).getText().replaceAll("[^0-9]", "");
            					break;
            				case "담당자 이메일":
            					// 이메일 정보를 저장합니다.
            					담당자이메일 = value;
            					break;
            				}
            			}
            		}

            		// 장소 정보 가져오기
            		WebElement 장소Element = driver.findElement(
            				By.xpath("//td[@class='tdLabel' and text()='장소']/following-sibling::td[@class='tdLong']//span"));
            		String 장소 = 장소Element.getText();


                    // 상세 정보 출력
                    System.out.println("학회제목: " + 학회제목);
                    System.out.println("행사기간: " + 행사기간);
                    System.out.println("접수기간: " + 접수기간);
                    System.out.println("참가비: " + 참가비);
                    System.out.println("관련 홈페이지: " + 관련홈페이지);
                    System.out.println("조회수: " + 조회수);
                    System.out.println("장소: " + 장소); // 추가된 출력
                    System.out.println("담당자 연락처: " + (담당자연락처.isEmpty() ? "" : 담당자연락처));
            		System.out.println("담당자 이메일: " + (담당자이메일.isEmpty() ? "" : 담당자이메일));
                } catch (Exception e) {
                    System.out.println("상세 정보를 가져오는 중 오류가 발생했습니다.");
                    e.printStackTrace();
                } finally {
                    // 뒤로 가기
                    driver.navigate().back();
                }
            }
        }
        // WebDriver 종료
        driver.quit();
    }
}
