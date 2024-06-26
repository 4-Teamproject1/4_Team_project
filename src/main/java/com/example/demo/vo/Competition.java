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
	private int hitCount;
    private String totalPrizeMoney;
    private String firstPrizeMoney;
    private String applicationPeriod;
    private String homepage;
    private String imageURL;
    private String contactNum;
    private String contactEmail;
    private int themeId;
    private String regDate;
    private String goodReactionPoint;
    private int CmemberId;
}
