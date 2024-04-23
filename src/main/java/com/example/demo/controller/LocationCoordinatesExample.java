package com.example.demo.controller;

import org.openqa.selenium.Alert;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

public class LocationCoordinatesExample {
   public static void main(String[] args) {
       // 크롬 드라이버 경로 설정
       System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

       // WebDriver 인스턴스 생성
       WebDriver driver = new ChromeDriver();

       // 네이버 지도 URL
       String url = "https://map.naver.com/p?c=15.00,0,0,0,dh";

       // 웹 페이지로 이동
       driver.get(url);

       // JavaScript를 사용하여 위도와 경도 가져오기
       JavascriptExecutor js = (JavascriptExecutor) driver;
       String script = "var coordinates = {};" +
                       "window.navigator.geolocation.getCurrentPosition(function(pos) { " +
                       "    coordinates.latitude = pos.coords.latitude; " +
                       "    coordinates.longitude = pos.coords.longitude; " +
                       "});" +
                       "return coordinates;";

       // JavaScript 코드 실행
       Object result = js.executeScript(script);
       
       // 위도와 경도 값 가져오기
       Double latitude = (Double)((JavascriptExecutor) driver).executeScript("return arguments[0].latitude;", result);
       Double longitude = (Double)((JavascriptExecutor) driver).executeScript("return arguments[0].longitude;", result);
       
       // 가져온 값 콘솔에 출력
       System.out.println("Java에서 가져온 위도: " + latitude);
       System.out.println("Java에서 가져온 경도: " + longitude);

       // WebDriver 종료
       driver.quit();
   }
}