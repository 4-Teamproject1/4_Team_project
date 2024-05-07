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

	public List<Hotel> crawlAndSaveHotelList(String area) {
		
	
		List<Hotel> hotelList = crawler.crawlHotelList(area);

		// 가져온 호텔 데이터 리스트에 저장
		for (Hotel hotel : hotelList) {

			System.err.println(hotel);

			hotelListRepository.insertHotel(hotel);
			System.err.println(hotel);
		}

		return hotelList;
	}

	public List<Hotel> getHotelList() {
		
		return hotelListRepository.getHotelList();
	}

	public List<Hotel> getHotelsByLocation(String location) {
	    // 데이터베이스에서 location 매개변수에 해당하는 호텔을 검색하는 코드 구현
	    return hotelListRepository.findByLocation(location);
	}

	public List<Hotel> getHotelsByLocationPrefix(String locationPrefix) {
	    return hotelListRepository.getHotelsByLocationPrefix(locationPrefix);
	}

	

}
