package com.example.demo.util;
import org.openqa.selenium.StaleElementReferenceException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.function.Function;

public class RetryUtils {
    public static <T> T retrying(Function<WebDriver, T> function, WebDriver driver, int maxAttempts, long waitDuration) {
        int attempts = 0;
        while (true) {
            try {
                return function.apply(driver);
            } catch (StaleElementReferenceException e) {
                if (++attempts >= maxAttempts) {
                    throw e;
                }
                try {
                    Thread.sleep(waitDuration);
                } catch (InterruptedException ex) {
                    Thread.currentThread().interrupt();
                }
            }
        }
    }

    public static WebElement findElement(WebDriver driver, Function<WebDriver, WebElement> function, int maxAttempts, long waitDuration) {
        return retrying(function, driver, maxAttempts, waitDuration);
    }

    public static WebElement findElement(WebDriver driver, Function<WebDriver, WebElement> function) {
        return findElement(driver, function, 5, 500);
    }
}
