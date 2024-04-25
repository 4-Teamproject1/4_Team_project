package com.example.demo.controller;

import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler3_JDW {
	public static void main(String[] args) {

		 // 크롬 드라이버 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\work\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");

        // WebDriver 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 네이버 기차표 검색 페이지 URL
        String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";

        // 기차표 검색 페이지로 이동
        driver.get(url);

        // 검색창 요소 찾기
        WebElement searchInput = driver.findElement(By.cssSelector("div.input_box input.input_search"));

        // WebDriverWait 인스턴스 생성
        WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(10));

        // 검색창이 활성화될 때까지 기다림
        WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));

        // 검색어 입력
        String searchText = "서울 용산구 한강대로 405";
        activatedSearchInput.sendKeys(searchText);

        // 엔터 입력 (검색 실행)
        activatedSearchInput.sendKeys(Keys.ENTER);

        // 도착 버튼 클릭
        clickArrivalButton(wait_web);
        System.out.println("1");
        // 출발지 입력
        enterDepartureLocation(wait_web);
        System.out.println("2");
        // 길찾기 버튼 클릭
        clickFindPathButton(wait_web);
        System.out.println("3");
        
        // 기차역 예매 버튼 클릭
        clickTrainReservationButton(wait_web);
       
        // iframe으로 전환
        WebElement iframeElement = driver.findElement(By.id("trainScheduleIframe"));
        driver.switchTo().frame(iframeElement);
        
        // 기차 시간표 조회 결과 출력
        System.out.println("5가 나와야는데~");
        printTrainTimetable(driver, wait_web);

        System.out.println("나왔나?");
        // WebDriver 종료
        //driver.quit();
    }

    private static void clickArrivalButton(WebDriverWait wait_web) {
        WebElement arrivalButton = wait_web.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.btn_area div.btn_box.direction button.btn_goal")));
        arrivalButton.click();
    }
    private static void clickFindPathButton(WebDriverWait wait_web) {
        WebElement findPathButton = wait_web.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button.btn_direction.search.active")));
        findPathButton.click();
    }
    private static void enterDepartureLocation(WebDriverWait wait_web) {
        WebElement searchInput_start = wait_web.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.search_input_wrap div.search_input input.input_search")));
        searchInput_start.click();
        searchInput_start.clear(); // 입력란을 비웁니다.
        String searchText_start = "대전역";
        searchInput_start.sendKeys(searchText_start);
        searchInput_start.sendKeys(Keys.ENTER);
    }

    private static void clickTrainReservationButton(WebDriverWait wait_web) {
        WebElement trainButton = wait_web.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve")));
//        trainButton.click();
        trainButton.sendKeys(Keys.ENTER);
        System.out.println("4");
    }

    private static void printTrainTimetable(WebDriver driver, WebDriverWait wait_web) {
        // 시간표를 감싸는 부모 요소의 CSS 선택자를 수정합니다.
    	 System.out.println("함수에 들어왔는가?");

//    	  String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa li.Iit8EKCtdTAoAXHIf7w9";
    	  String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa ";

    	    // 시간표를 감싸는 부모 요소가 로딩될 때까지 대기
    	    WebElement parentElement = wait_web.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(cssSelector)));

        System.out.println("5");

        // 부모 요소 아래에 있는 모든 span 요소를 가져옵니다.
        List<WebElement> spanElements = parentElement.findElements(By.tagName("li"));
        if (spanElements.size() > 0) {
            // 각 span 요소에 대해 반복하여 텍스트를 출력합니다.
            for (WebElement spanElement : spanElements) {
                // 해당 span 요소의 텍스트를 출력합니다.
                System.out.println("텍스트: " + spanElement.getText());
            }
        } else {
            System.out.println("span 요소를 찾지 못했습니다.");
        }
    }
    
}
