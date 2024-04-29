package com.example.demo.vo;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Conference {
    private int id;
    private String title;
    private int hitCount;
    private String eventPeriod;
    private String applicationPeriod;
    private String entryFee;
    private String place;
    private String homepage;
    private String imageURL;
    private int categoryId;
    private String regDate;
    
}
