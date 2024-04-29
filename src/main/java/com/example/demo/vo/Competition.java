package com.example.demo.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Competition {
    private int id;
    private String title;
    private String totalPrizeMoney;
    private String firstPrizeMoney;
    private String applicationPeriod;
    private String homepage;
    private String imageURL;
    private String contactNum;
    private String contactEmail;
    private String regDate;
    
}
