package com.example.demo.vo;

import java.util.List;

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
	private int grade;
	private String price;
	private String service;
	private String href;
}
