package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Conference {
    private int categoryId;
    private String title;
    private String count;
    private String eventPeriod;
    private String applcationPeriod;
    private String entryFee;
    private String place;
    private String homepage;
    private String imageURL;
}
