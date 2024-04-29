package com.example.demo.service;

import java.time.Duration;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.Keys;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import io.netty.handler.timeout.TimeoutException;

public class BusTicketService {
   public static void main(String[] args) {
		System.setProperty("webdriver.chrome.driver",
				"C:\\work\\chromedriver-win64\\chromedriver-win64\\chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        WebDriverWait wait = new WebDriverWait(driver, Duration.ofSeconds(20));

        String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";
        driver.get(url);
        
        
        
        // 검색 창에 대전복합버스터미널 입력
        WebElement searchInput = driver.findElement(By.cssSelector("input.input_search"));
        searchInput.sendKeys("대전복합버스터미널");
        searchInput.sendKeys(Keys.ENTER);
        
        // 대기 시간을 추가하여 iframe을 찾음
        WebElement iframeElement = wait.until(ExpectedConditions.presenceOfElementLocated(By.id("searchIframe")));

        // iframe으로 전환
        driver.switchTo().frame(iframeElement);
        
        // 출발 버튼 클릭
        WebElement departureButton = wait.until(ExpectedConditions.elementToBeClickable(By.xpath("//a[text()='출발']")));
        departureButton.click();


        // 프레임을 다시 메인 프레임으로 전환
        driver.switchTo().defaultContent();
        
        // 도착지 입력
        enterArrivalLocation(wait);

        // 길찾기 버튼 클릭
        clickFindPathButton(wait);

        printSpecificBusTimetable(driver, wait);
        //driver.quit();
    }
   
    private static void clickFindPathButton(WebDriverWait wait) {
        WebElement findPathButton = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("button.btn_direction.search.active")));
        findPathButton.click();
    }

    private static void enterArrivalLocation(WebDriverWait wait) {
       WebElement arrivalInput = wait.until(ExpectedConditions.elementToBeClickable(By.cssSelector("div.search_input_box_wrap.goal input.input_search")));
        arrivalInput.click();
        arrivalInput.clear();
        String arrivalText = "동서울종합터미널";
        arrivalInput.sendKeys(arrivalText);
        arrivalInput.sendKeys(Keys.ENTER);
    }
    private static void printSpecificBusTimetable(WebDriver driver, WebDriverWait wait_web) {
        try {
            String cssSelector = "ul.list_pubtrans_directions_summary";
          
            WebElement parentElement = wait_web.until(ExpectedConditions.presenceOfElementLocated(By.cssSelector(cssSelector)));

            List<WebElement> liElements = parentElement.findElements(By.cssSelector("li.sc-1tj2a62.lcsQWR"));

            for (WebElement liElement : liElements) {
                // li 태그 내의 모든 자식 요소를 가져옴
                List<WebElement> childElements = liElement.findElements(By.cssSelector("span"));

                for (WebElement element : childElements) {
                    // 스크롤을 내린 후 요소가 화면에 보이도록 함
                    ((JavascriptExecutor) driver).executeScript("arguments[0].scrollIntoView(true);", element);
                    // 요소의 텍스트를 가져와 출력
                    System.out.println(element.getAttribute("innerText"));
                }

                System.out.println("=====================");
            }
        } catch (TimeoutException e) {
            System.out.println("요소를 찾을 수 없습니다.");
        } catch (StaleElementReferenceException e) {
            System.out.println("요소가 더 이상 DOM에 존재하지 않습니다.");
        }
    }
    
}