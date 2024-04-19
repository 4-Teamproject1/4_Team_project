package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

public class TrainTicketCrawler2 {
    public static void main(String[] args) {
        // 크롬 드라이버 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\work\\chromedriver-win64 (1)\\chromedriver-win64/chromedriver.exe");

        // WebDriver 인스턴스 생성
        WebDriver driver = new ChromeDriver();

        // 네이버 기차표 검색 페이지 URL
        String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";

        // 기차표 검색 페이지로 이동
        driver.get(url);


        // 검색창 요소 찾기
        WebElement searchInput = driver.findElement(By.cssSelector("div.input_box input.input_search"));

        // 검색어 입력
//        String searchText = "경상남도 창원시 의창구 창원대학로 20";
        
        String searchText = "경기도 성남시 분당구 하오개로 323";
        searchInput.sendKeys(searchText);
        
        // 엔터 입력 (검색 실행)
        searchInput.sendKeys(Keys.ENTER);
        


//        // 출발지 입력
//        WebElement departureInput = driver.findElement(By.id("#input_search1713492796393"));
//        departureInput.sendKeys("서울역");

//        // 도착지 입력
//        WebElement arrivalInput = driver.findElement(By.id("arrival"));
//        arrivalInput.sendKeys("부산역");

//        // 날짜 입력 (수정된 부분)
//        LocalDate date = LocalDate.now().plusDays(3); // 예를 들어, 오늘로부터 3일 뒤로 설정
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy.MM.dd");
//        String formattedDate = date.format(formatter);
//        WebElement dateInput = driver.findElement(By.xpath("//dd[contains(@class, 'lx5CLVZizAnop1laHAqU')]"));
//        dateInput.click(); // 클릭하여 날짜 선택 팝업 띄우기
//        WebElement selectedDate = driver.findElement(By.xpath("//button[@aria-label='" + formattedDate + "']"));
//        selectedDate.click(); // 선택한 날짜 클릭
        // 스크롤 내리기
        JavascriptExecutor js = (JavascriptExecutor) driver;
        js.executeScript("window.scrollBy(0, 300)");
//
//        // 시간표 조회 버튼 클릭
//        WebElement searchButton = driver.findElement(By.xpath("//button[contains(@class, 'EkxmVtPgf4qaNumd_yo2')]"));
//        searchButton.click();
//
//        // 기차 시간표 데이터 크롤링
//        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(10));
//        WebElement timetable = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath("//div[@class='_3-5Oc']")));
//        List<WebElement> scheduleRows = timetable.findElements(By.xpath(".//ul[@class='_3tdEo']//li"));
//        for (WebElement row : scheduleRows) {
//            System.out.println(row.getText());
//        }

//        // WebDriver 종료
//        driver.quit();
    }
}