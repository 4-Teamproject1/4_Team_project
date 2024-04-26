package com.example.demo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Train {
	
	//크롤링데이터가져오기
	private String TrainName;
	private String TrainNum;
	private String DepartureTime;
	private String ArrivalTime;
	private String travelTime;
	
	//예매가능불가변수
	private String generallabel;

	private String spectiallabel;

}
