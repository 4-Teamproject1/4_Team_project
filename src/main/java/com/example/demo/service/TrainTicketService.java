package com.example.demo.service;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Service;

import com.example.demo.vo.Train;

@Service
public class TrainTicketService {

    // 출발지, 도착지, 출발일을 받아서 기차 정보를 가져오는 메서드
    public List<Train> gettrainservice(String departureTrain, String arriveTrain, String ondate) {
        // 크롤러 인스턴스 생성
        Crawler crawler = new Crawler(departureTrain, arriveTrain, ondate);
        // 기차 정보 가져오기
        return crawler.crawl();
    }

    // 크롤러 클래스 정의
    static class Crawler {

        private String departureTrain;
        private String arriveTrain;
        private String ondate;

        // 생성자
        public Crawler(String departureTrain, String arriveTrain, String ondate) {
            this.departureTrain = departureTrain;
            this.arriveTrain = arriveTrain;
            this.ondate = ondate;
        }

        // 기차 정보를 가져오는 메서드
        public List<Train> crawl() {
            // 크롬 드라이버 경로 설정
            System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");
            // WebDriver 인스턴스 생성
            WebDriver driver = new ChromeDriver();
            // WebDriverWait 인스턴스 생성
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

            // 네이버 지도 기차표 검색 페이지 URL
            String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";

            // 기차표 검색 페이지로 이동
            driver.get(url);

            // 검색창 요소 찾기
            WebElement searchInput = driver.findElement(By.cssSelector("div.input_box input.input_search"));

            // 검색창이 활성화될 때까지 대기
            WebElement activatedSearchInput = wait.until(ExpectedConditions.elementToBeClickable(searchInput));

            // 출발지 입력
            String searchText = departureTrain;
            activatedSearchInput.sendKeys(searchText);
            activatedSearchInput.sendKeys(Keys.ENTER);

            // 도착 버튼 클릭
            clickArrivalButton(wait);

            // 출발지 입력
            enterDepartureLocation(wait, arriveTrain);

            // 길찾기 버튼 클릭
            clickFindPathButton(wait);

            // 기차 예매 버튼 클릭
            clickTrainReservationButton(wait);

            // iframe으로 전환
            WebElement iframeElement = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("trainScheduleIframe")));
            driver.switchTo().frame(iframeElement);

            // 특정 날짜 선택
            selectDate(driver, wait, ondate);

            // 크롤링한 결과 출력
            List<Train> trains = printTrainTimetable(driver);

            // 브라우저 닫기
            driver.quit();
            return trains;
        }

        // 도착 버튼 클릭 메서드
        private static void clickArrivalButton(WebDriverWait wait) {
            WebElement arrivalButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.btn_area div.btn_box.direction button.btn_goal")));
            arrivalButton.click();
        }

        // 출발지 입력 메서드
        private static void enterDepartureLocation(WebDriverWait wait, String arriveTrain) {
            WebElement searchInput_start = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.search_input_wrap div.search_input input.input_search")));
            searchInput_start.click();
            searchInput_start.clear(); // 입력란을 비움
            String searchText_start = arriveTrain;
            searchInput_start.sendKeys(searchText_start);
            searchInput_start.sendKeys(Keys.ENTER);
        }

        // 길찾기 버튼 클릭 메서드
        private static void clickFindPathButton(WebDriverWait wait) {
            WebElement findPathButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button.btn_direction.search.active")));
            findPathButton.click();
        }

        // 기차 예매 버튼 클릭 메서드
        private static void clickTrainReservationButton(WebDriverWait wait) {
            WebElement trainButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve")));
            trainButton.sendKeys(Keys.ENTER);
        }

        // 특정 날짜 선택 메서드
        private static void selectDate(WebDriver driver, WebDriverWait wait, String ondate) {
            WebElement calendarButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.GCHKKatvIDUwtDhc6Gpi div[title='변경하기']")));
            calendarButton.click();
            String targetNumber = ondate; // 클릭하고 싶은 날짜의 숫자
            WebElement numberElement = driver.findElement(By.xpath("//button[contains(@class, 'UCpJLMzaonwRmF6xEQOv')]//strong[text()='" + targetNumber + "']"));
            numberElement.click();
        }

        // 기차 정보 출력 메서드
        private static List<Train> printTrainTimetable(WebDriver driver) {
        	 String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa li";

             // 부모 요소 아래에 있는 모든 li 요소를 가져옵니다.
             List<WebElement> liElements = driver.findElements(By.cssSelector(cssSelector));

             // span 요소의 텍스트를 저장할 리스트 생성
             List<Train> trains = new ArrayList<>();

             // 각 li 요소에 대해 반복하여 span 태그의 정보를 저장합니다.
             for (WebElement liElement : liElements) {
                 // li 요소에서 span 태그의 정보만을 가져옵니다.
                 List<WebElement> spanElements = liElement.findElements(By.tagName("span"));

                 // Train 객체 생성
                 Train train = new Train();

                 // 각 span 요소에 대해 반복하여 정보를 저장합니다.
                 for (WebElement spanElement : spanElements) {
                     // span 태그의 클래스가 특정한 클래스인 경우에만 정보를 저장합니다.
                     String spanClass = spanElement.getAttribute("class");
                     if (spanClass.equals("H13fR_En7MQuoMExYcWk")) {
                         // 기차 이름
                         train.setTrainName(spanElement.getText());
                     } else if (spanClass.equals("qkW1KAbn7fcP07KPJ9EA")) {
                         // 기차 번호
                         train.setTrainNum(spanElement.getText());
                     } else if (spanClass.equals("J7J4mNqthSM_lLIOSckL")) {
                         // 출발 시간
                         train.setDepartureTime(spanElement.getText());
                     } else if (spanClass.equals("Kbo2BHpqnQBH5gSRFqqa")) {
                         // 도착 시간
                         train.setArrivalTime(spanElement.getText());
                     } else if (spanClass.equals("F2oBbtEf9sYyvLGIHf2T")) {
                         // 소요 시간
                         train.setTravelTime(spanElement.getText());
                     }
                 }

                 // trains 리스트에 train 객체 추가
                 trains.add(train);
             }

             return trains;
         }
     }
 }
