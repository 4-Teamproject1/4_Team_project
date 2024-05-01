package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.controller.HotelListCrawler;
import com.example.demo.repository.HotelListRepository;
import com.example.demo.vo.Hotel;

@Service
public class HotelListService {

	@Autowired
	private HotelListRepository hotelListRepository;

	@Autowired
	private HotelListCrawler crawler;

	public HotelListService(HotelListRepository hotelListRepository) {
		this.hotelListRepository = hotelListRepository;
	}

	public List<Hotel> crawlAndSaveHotelList() {
		
	
		List<Hotel> hotelList = crawler.crawlHotelList();

		// 가져온 호텔 데이터 리스트에 저장
		for (Hotel hotel : hotelList) {

			System.err.println(hotel);

			hotelListRepository.insertHotel(hotel);
			System.err.println(hotel);
		}

		return hotelList;
	}

}
