package com.example.demo.controller;

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

import com.example.demo.vo.Train;

public class UsrTrainExample {
       // 상수 정의
//       private static final String CHROME_DRIVER_PATH = "C:\\Users\\hunt0\\Desktop\\Eclipse\\chromedriver-win64\\chromedriver.exe";
       private static final String CHROME_DRIVER_PATH = "C:/work/chromedriver-win64/chromedriver-win64/chromedriver.exe";
       private static final String NAVI_MAP_URL = "https://map.naver.com/p?c=15.00,0,0,0,dh";

       public static void main(String[] args) {
           System.setProperty("webdriver.chrome.driver", CHROME_DRIVER_PATH);
           WebDriver driver = new ChromeDriver();
           WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));

           driver.get(NAVI_MAP_URL);

           // 출발지 입력
           enterLocation(wait, "서울 용산구 한강대로 405");

           // 도착지 입력
           clickArrivalButton(wait);

           // 출발지 입력
           enterLocation(wait, "대전역");

           // 길찾기 버튼 클릭
           clickButton(wait, By.cssSelector("button.btn_direction.search.active"));
           
           //길찾기 버튼을 누른후 기차의 예매버튼을 바로 누르지 않고 대기 후 웹페이지가 로드끝날때까지 기다려줌
           wait.until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve")));
           // 기차역 예매 버튼 클릭
           clickButton(wait, By.cssSelector("div.item_btn ol.list_pubtrans_directions_step button.btn_pubtrans_reserve"));

           // iframe으로 전환
           WebElement iframeElement = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("trainScheduleIframe")));
           driver.switchTo().frame(iframeElement);
           
           
           WebElement calendarButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.GCHKKatvIDUwtDhc6Gpi div[title='변경하기']")));
           calendarButton.click();
           	
     
           
           // 달력에서 특정 날짜 클릭
           String targetNumber = "21"; // 클릭하고 싶은 날짜의 숫자
           WebElement numberElement = driver.findElement(By.xpath("//button[contains(@class, 'UCpJLMzaonwRmF6xEQOv')]//strong[text()='" + targetNumber + "']"));
           numberElement.click();
           System.out.println("클릭한 날짜: " + numberElement.getText());
           
           
        // 적용 버튼을 클릭하기 위해 필요한 코드
           WebElement applyButton = driver.findElement(By.cssSelector("div.bLvYl4MQXPo0xE34e6AC button.FlIU_KywuA_u7z1YgjIW"));
           // 적용 버튼 클릭
           applyButton.click();

        // 페이지가 로드될 때까지 대기
           wait.until(ExpectedConditions.invisibilityOfElementLocated(By.cssSelector("div.bLvYl4MQXPo0xE34e6AC button.FlIU_KywuA_u7z1YgjIW")));

           printTrainTimetable(driver, wait);
        // 기차 시간표 조회 결과 출력
           List<Train> trainList = printTrainTimetable(driver);
           if(trainList.size() != 0) {
              for (Train train : trainList) {
                 System.out.println(train);
              }
              
           }else {
              System.out.println("리스트에 자료가 없습니다.");
           }

//           driver.quit();
       }

       private static void clickButton(WebDriverWait wait, By by) {
           WebElement button = wait.until(ExpectedConditions.elementToBeClickable(by));
           button.click();
       }

       private static void enterLocation(WebDriverWait wait, String location) {
           WebElement searchInput = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.input_box input.input_search")));
           searchInput.sendKeys(location);
           searchInput.sendKeys(Keys.ENTER);
       }
       
      // 제대로 크롤링 하는지 보기위한 함수
      private static void printTrainTimetable(WebDriver driver, WebDriverWait wait_web) {
         // 시간표를 감싸는 부모 요소의 CSS 선택자를 수정합니다.

         String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa ";

         // 시간표를 감싸는 부모 요소가 로딩될 때까지 대기
         WebElement parentElement = wait_web
               .until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(cssSelector)));

         // 부모 요소 아래에 있는 모든 span 요소를 가져옵니다.
         List<WebElement> spanElements = parentElement.findElements(By.tagName("li"));
         if (spanElements.size() > 0) {
            // 각 span 요소에 대해 반복하여 텍스트를 출력합니다.
            for (WebElement spanElement : spanElements) {
               // 해당 span 요소의 텍스트를 출력합니다.
               System.out.println("텍스트: " + spanElement.getText());
            }
         } else {
            System.out.println("li 요소를 찾지 못했습니다.");
         }
      }
       
       
       private static void clickArrivalButton(WebDriverWait wait) {
           clickButton(wait, By.cssSelector("div.btn_area div.btn_box.direction button.btn_goal"));
       }

       private static List<Train> printTrainTimetable(WebDriver driver) {
           String cssSelector = "ul.abL4sGipWTYELd9Stf9J.kcy2EjyNrFkhWNkqrioa li";
           List<WebElement> liElements = driver.findElements(By.cssSelector(cssSelector));
           List<Train> trainList = new ArrayList<>();

           for (WebElement liElement : liElements) {
               List<WebElement> spanElements = liElement.findElements(By.tagName("span"));
               Train train = new Train();

               for (WebElement spanElement : spanElements) {
                   String spanClass = spanElement.getAttribute("class");

                   if (spanClass.equals("H13fR_En7MQuoMExYcWk")) {
                       train.setTrainName(spanElement.getText());
                   } else if (spanClass.equals("qkW1KAbn7fcP07KPJ9EA")) {
                       train.setTrainNum(spanElement.getText());
                   } else if (spanClass.equals("J7J4mNqthSM_lLIOSckL")) {
                       train.setDepartureTime(spanElement.getText());
                   } else if (spanClass.equals("Kbo2BHpqnQBH5gSRFqqa")) {
                       train.setArrivalTime(spanElement.getText());
                   } else if (spanClass.equals("F2oBbtEf9sYyvLGIHf2T")) {
                       train.setTravelTime(spanElement.getText());
                   }
               }
               // train 객체를 리스트에 추가
               trainList.add(train);
           }

           return trainList;
       }

}