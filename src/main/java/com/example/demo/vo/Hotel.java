package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Hotel {

	private int id;
	private String hotelName;
	private String imgUrl;
	private String grade;
	private String price;

}
