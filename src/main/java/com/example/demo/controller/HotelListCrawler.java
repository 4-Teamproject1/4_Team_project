package com.example.demo.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.TimeoutException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.stereotype.Component;

import com.example.demo.vo.Hotel;

@Component
public class HotelListCrawler {

    // 호텔 목록을 크롤링하는 메서드
    public List<Hotel> crawlHotelList() {

        // ChromeDriver 실행 파일 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:/work/chromedriver.exe");

        List<Hotel> hotelList = new ArrayList<>();
        // 검색할 지역 목록 설정
        String[] areaList = { "서울", "대전", "부산", "대구", "광주", "인천", "제주" };

        // 각 지역에 대해 반복문 실행
        for (int i = 0; i < areaList.length; i++) {
            // WebDriver 인스턴스 생성
            WebDriver driver = new ChromeDriver();
            // WebDriverWait 인스턴스 생성 (최대 10초 대기)
            WebDriverWait wait_web = new WebDriverWait(driver, Duration.ofSeconds(10));
            // 아고다 검색 페이지 URL
            String url = "https://www.agoda.com/ko-kr/?site_id=1922887&tag=eeeb2a37-a3e0-4932-8325-55d6a8ba95a4&gad_source=1&device=c&network=g&adid=695788229412&rand=2893338334644664789&expid=&adpos=&aud=kwd-304551434341&gclid=Cj0KCQjw_qexBhCoARIsAFgBlevSo6nth5UoZYtTjxbyMdsMGb9e5H1wMGNKOHqatzyxXCnCCISQUGEaApAaEALw_wcB&checkIn=2024-05-10&checkOut=2024-05-18&adults=1&rooms=1&pslc=1&ds=pWGoz1iyjxyzPJEv";
            // 아고다 검색 페이지로 이동
            driver.get(url);
            // 검색창 요소 찾기
            WebElement searchInput = driver.findElement(By.cssSelector("#autocomplete-box #textInput"));
            // 검색창이 활성화될 때까지 기다림
            WebElement activatedSearchInput = wait_web.until(ExpectedConditions.elementToBeClickable(searchInput));
            // 검색어 입력
            String searchText = areaList[i];
            System.out.println(searchText);
            activatedSearchInput.sendKeys(searchText);

            try {
                // 페이지 로드를 위한 대기 시간 설정 (최대 30초)
                driver.manage().timeouts().pageLoadTimeout(30, TimeUnit.SECONDS);
            } catch (TimeoutException e) {
                System.out.println("페이지 로드 시간이 초과되었습니다.");
            }

            // 검색 제안 리스트의 XPath 설정
            String combinedXPath2 = "//ul[@class='AutocompleteList']//li";

            // 검색 제안 리스트 요소들 가져오기
            List<WebElement> timeElements2 = wait_web
                    .until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(combinedXPath2)));

            // 첫 번째 검색 제안 요소 클릭
            WebElement firstElement = timeElements2.get(0);
            firstElement.click();

            // 달력의 현재 년도와 월 요소의 XPath 설정
            String monthStr = "//div[contains(@class,'DayPicker-Caption') and contains(@class,'DayPicker-Caption-Wide')]";

            // 달력의 현재 년도와 월 요소들 가져오기
            List<WebElement> monthElements = wait_web
                    .until(ExpectedConditions.presenceOfAllElementsLocatedBy(By.xpath(monthStr)));

            // 달력의 현재 년도와 월 텍스트 가져오기
            String pageYearMonth = monthElements.get(0).getText();

            // 년도와 월을 추출할 정규 표현식 패턴 설정
            Pattern pattern = Pattern.compile("(\\d{4})년 (\\d{1,2})월");
            Matcher matcher = pattern.matcher(pageYearMonth);

            int pageYear = 0;
            int pageMonth = 0;

            // 매치되는 부분이 있다면 년도와 월 추출
            if (matcher.find()) {
                pageYear = Integer.parseInt(matcher.group(1));
                pageMonth = Integer.parseInt(matcher.group(2));
                System.out.println("년도: " + pageYear);
                System.out.println("월: " + pageMonth);
            } else {
                System.out.println("매치되는 부분이 없습니다.");
            }

            // 이전 달 버튼 요소 찾기
            WebElement previousMonthButton = driver.findElement(By.cssSelector("button[aria-label='Previous Month']"));

            // 현재 날짜 구하는 코드
            LocalDate currentDate = LocalDate.now();
            int nowYear = currentDate.getYear();
            int nowMonth = currentDate.getMonthValue();

            // 합친 년도와 달 문자열 생성
            String currentYearMonth = nowYear + "년 " + nowMonth + "월";

            // 현재 페이지의 년도와 월이 현재 년도와 월과 일치하는지 확인
            if (currentYearMonth == pageYearMonth) {
                // 일치하면 아무 작업도 하지 않음
            } else {
                // 페이지의 년도와 월이 현재 년도와 월보다 큰 경우 이전 달 버튼 클릭
                while (pageYear == nowYear && pageMonth > nowMonth) {
                    previousMonthButton.click();
                    break;
                }
            }

            // 날짜 포맷 지정
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("EEE MMM dd yyyy", Locale.ENGLISH);

            // 현재 날짜를 원하는 형식으로 포맷
            String startDate = currentDate.format(formatter);

            // 현재 날짜 요소 찾기
            String startDateStr = "//div[@class='DayPicker-Week-Wide']/div[contains(@aria-label, '" + startDate + "')]";
            WebElement startDateElement = driver.findElement(By.xpath(startDateStr));

            // 찾은 현재 날짜 클릭 (시작 날짜 선택)
            startDateElement.click();

            // 다음 날 날짜 구하기
            LocalDate plusNowDate = currentDate.plusDays(1);
            String nextDate = plusNowDate.format(formatter);
            String endDateStr = "//div[@class='DayPicker-Week-Wide']/div[contains(@aria-label, '" + nextDate + "')]";
            WebElement endDateElement = driver.findElement(By.xpath(endDateStr));

            // 찾은 다음 날 클릭 (종료 날짜 선택)
            endDateElement.click();

            // 검색 버튼 요소의 XPath 설정
            String buttonXPathStr = "//div[@class='Box-sc-kv6pi1-0 hRUYUu TabContent__Search--button']//button[@data-test='SearchButtonBox']";

            // 검색 버튼 요소 찾기
            WebElement buttonElement = driver.findElement(By.xpath(buttonXPathStr));

            // 검색 버튼 클릭
            buttonElement.click();

            // 현재 탭의 핸들 가져오기
            String currentTabHandle = driver.getWindowHandle();

            // 모든 탭의 핸들 가져오기
            Set<String> allTabHandles = driver.getWindowHandles();

            // 두 번째 탭의 핸들 찾기
            String secondTabHandle = "";
            for (String handle : allTabHandles) {
                if (!handle.equals(currentTabHandle)) {
                    secondTabHandle = handle;
                    break;
                }
            }

            // 두 번째 탭으로 전환
            driver.switchTo().window(secondTabHandle);

            JavascriptExecutor js = (JavascriptExecutor) driver;

            // 페이지를 3번 스크롤하여 추가 콘텐츠 로드
            for (int j = 0; j < 3; j++) {
                js.executeScript("window.scrollBy(0, 2000);");

                // 추가 콘텐츠가 로드되기를 기다림
                try {
                    Thread.sleep(2000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            System.out.println(1);
            // 호텔 목록 요소들 찾기
            List<WebElement> liElements = driver.findElements(By.xpath(
                    "//ol[@class='hotel-list-container']//li[contains(@class,'PropertyCard') and contains(@class,'PropertyCardItem')]"));
            System.out.println(liElements.size());

            System.out.println("순회 시작");

            // 호텔 목록 요소들 순회
            for (WebElement liElement : liElements) {
                try {
                    System.out.println(11);
                    // 호텔 이미지 요소 찾기
                    WebElement imgElement = liElement.findElement(By.xpath(
                            ".//img[(contains(@class,'sc-kstrdz') and contains(@class,'sc-hBEYos') and contains(@class,'kmUwlj')) or (contains(@class,'HeroImage') and contains(@class,'HeroImage--s'))]"));
                    System.out.println(22);
                    String imgUrl = imgElement.getAttribute("src");
                   
                 // 호텔 이름 요소를 xpath를 사용하여 찾음
                    WebElement hotelNameElement = liElement.findElement(By.xpath(
                        ".//h3[contains(@class,'sc-jrAGrp') and contains(@class,'sc-kEjbxe') and contains(@class,'eDlaBj') and contains(@class,'dscgss')]"));
                    // 호텔 이름 텍스트 추출
                    String hotelName = hotelNameElement.getText();

                    // 호텔 등급을 표시하는 요소를 xpath를 사용하여 찾음
                    WebElement starElement = liElement.findElement(By.xpath(".//div[@role='img']"));
                    // 요소가 존재하는 경우 해당 요소의 텍스트 가져오기 (호텔 등급)
                    String hotelGrade = starElement.getAttribute("aria-label");
                    // 호텔 등급이 없는 경우 처리
                    if (starElement == null) {
                        System.out.println("등급 없음");
                    }

                    // 정규표현식을 사용하여 숫자와 문자열을 분리하여 호텔 등급 추출
                    String[] parts = hotelGrade.split("(?<=\\d)(?=\\D)");
                    String number = parts[0]; // 숫자 부분
                    String text1 = parts[1]; // 문자열 부분
                    int starScore = Integer.parseInt(number); // 호텔 등급을 정수로 변환

                    // 가격을 표시하는 요소를 xpath를 사용하여 찾음
                    WebElement priceElement = liElement.findElement(
                        By.xpath(".//div[@data-element-name='final-price']//span[@data-selenium='display-price']"));
                    // 가격 텍스트 추출
                    String priceStr = priceElement.getText();

                    // 호텔 제공 서비스를 담을 리스트 생성
                    List<String> serviceTexts = new ArrayList<>();
                    List<WebElement> serviceElements = liElement
                        .findElements(By.xpath(".//div[@data-selenium='pill-container']//div//span"));

                    // 호텔 제공 서비스를 추출하여 리스트에 저장
                    for (WebElement serviceElement : serviceElements) {
                        String text = serviceElement.getText();
                        serviceTexts.add(text);
                    }
                    String serviceAsString = String.join(",", serviceTexts); // 호텔 제공 서비스를 쉼표로 구분하여 하나의 문자열로 변환

                    // 가격 문자열 처리
                    String[] priceStrings = priceStr.split(",");
                    StringBuilder stringBuilder = new StringBuilder();
                    for (String s : priceStrings) {
                        stringBuilder.append(s);
                    }
                    String priceString = stringBuilder.toString();
                    int price = Integer.parseInt(priceString); // 가격을 정수로 변환

                    // 호텔 상세 페이지 링크(href) 추출
                    WebElement aTagElement = liElement.findElement(By.tagName("a"));
                    String href = aTagElement.getAttribute("href");

                    // 로그 출력
                    System.out.println("Href : " + href);
                    System.out.println("이미지 url : " + imgUrl);
                    System.out.println("호텔 이름 : " + hotelName);
                    System.out.println("호텔 등급 : " + starScore);
                    System.out.println("가격 : " + price);
                    System.out.println("숙소 제공사항 : " + serviceAsString);

                    // Hotel 객체 생성 및 필드 설정
                    Hotel hotel = new Hotel();
                    hotel.setImgUrl(imgUrl);
                    hotel.setHotelName(hotelName);
                    hotel.setGrade(starScore);
                    hotel.setPrice(price);
                    hotel.setService(serviceAsString);
                    hotel.setHref(href);
                    hotel.setLocation(searchText); // 검색어를 location 필드에 저장

                    // 로그 출력 및 호텔 리스트에 추가
                    System.out.println(hotel);
                    System.out.println(hotelList);
                    hotelList.add(hotel);

                    // NoSuchElementException 처리
                    } catch (NoSuchElementException e) {
                        System.out.println("요소를 찾을 수 없습니다. 루프를 종료합니다.");
                        break;
                    }

			}

			driver.quit();
		}

		return hotelList;

	}
}