package com.example.demo.controller;

import java.util.List;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class ConferenceInfoCrawler {
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
        WebElement conferenceLink = driver.findElement(By.xpath("//a[@href='/research/researches/33/recruitments/112/recruits?listType=ING']"));
        conferenceLink.click();

        // 상세페이지로 이동한 후 "한국미래기술교육연구원 전기차 충전 인프라 사업 확대를 위한 기술 고도화 및 서비스 다양화 방안"이라는 텍스트를 가진 요소를 찾아 클릭
        WebElement detailLink = driver.findElement(By.xpath("//span[contains(text(), '한국미래기술교육연구원 전기차 충전 인프라 사업 확대를 위한 기술 고도화 및 서비스 다양화 방안')]"));
        detailLink.click();

     // 상세페이지에서 학회의 제목 추출
        WebElement titleElement = driver.findElement(By.xpath("//div[@class='titleWrap']/h4"));
        String 학회제목 = titleElement.getText();

        
     // 상세페이지에서 조회수 요소를 찾기 위해 <li> 태그의 클래스가 "cnt"인 요소를 찾고 그 안에 있는 <span> 태그의 클래스가 "bold"인 요소를 찾습니다.
        WebElement cntElement = driver.findElement(By.xpath("//li[@class='cnt']//span[@class='bold']"));
        String 조회수 = cntElement.getText();

     // 테이블에서 행사기간, 접수기간, 참가비, 관련 홈페이지 정보 가져오기
        WebElement table = driver.findElement(By.className("contentSummaryInfo"));
        List<WebElement> rows = table.findElements(By.tagName("tr"));
        String 행사기간 = "";
        String 접수기간 = "";
        String 참가비 = "";
        String 관련홈페이지 = "";
        String 장소 = ""; // 추가된 변수
        String 주소2 = ""; // 추가된 변수
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
                        WebElement linkElement = cells.get(i + 1).findElement(By.tagName("a"));
                        관련홈페이지 = linkElement.getAttribute("href");
                        break;
                    case "장소": // 추가된 case
                        장소 = cells.get(i + 1).findElement(By.tagName("span")).getText();
                        break;
                    case "주소2": // 추가된 case
                        주소2 = cells.get(i + 1).findElement(By.tagName("span")).getText();
                        break;
                }
            }
        }
        
     // 테이블에서 담당자 연락처와 이메일 정보 가져오기

        String 담당자연락처 = "";
        String 담당자이메일 = "";
        for (WebElement row : rows) {
            List<WebElement> cells = row.findElements(By.tagName("td"));
            for (int i = 0; i < cells.size(); i += 2) {
                String label = cells.get(i).getText();
                String value = cells.get(i + 1).getText();
                switch (label) {
                    case "담당자 연락처":
                        담당자연락처 = value;
                        break;
                    case "담당자 이메일":
                        담당자이메일 = value;
                        break;
                }
            }
        }

        // 결과 출력
        System.out.println("학회제목: " + 학회제목);
        System.out.println("행사기간: " + 행사기간);
        System.out.println("접수기간: " + 접수기간);
        System.out.println("참가비: " + 참가비);
        System.out.println("관련 홈페이지: " + 관련홈페이지);
        System.out.println("장소: " + 장소); // 추가된 출력
        System.out.println("주소2: " + 주소2); // 추가된 출력
     // 결과 출력
        System.out.println("담당자 연락처: " + (담당자연락처.isEmpty() ? "" : 담당자연락처));
        System.out.println("담당자 이메일: " + (담당자이메일.isEmpty() ? "" : 담당자이메일));
        System.out.println("조회수: " + 조회수);

        driver.navigate().back();

        // WebDriver 종료
        driver.quit();
    }
}
