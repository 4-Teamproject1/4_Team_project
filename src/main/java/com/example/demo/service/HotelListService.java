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

	// HotelListService 생성자
	public HotelListService(HotelListRepository hotelListRepository) {
		this.hotelListRepository = hotelListRepository;
	}

	// 호텔 리스트 크롤링 및 저장하는 메서드
	public List<Hotel> crawlAndSaveHotelList() {
		// HotelListCrawler를 사용하여 호텔 리스트 크롤링
		List<Hotel> hotelList = crawler.crawlHotelList();

		// 가져온 호텔 데이터 리스트에 저장
		for (Hotel hotel : hotelList) {
			System.err.println(hotel);
			hotelListRepository.insertHotel(hotel);
			System.err.println(hotel);
		}

		return hotelList;
	}

	// 지역별 호텔 리스트 가져오는 메서드
	public List<Hotel> getHotelList(String area) {
		return hotelListRepository.getHotelList(area);
	}

	// 전체 호텔 리스트 가져오는 메서드
	public List<Hotel> getAllHotelList() {
		return hotelListRepository.getAllHotelList();
	}

	// 지역을 기준으로 호텔 검색하는 메서드
	public List<Hotel> getHotelsByLocation(String location) {
		// 데이터베이스에서 location 매개변수에 해당하는 호텔을 검색하는 코드 구현
		return hotelListRepository.findByLocation(location);
	}

	// 지역 접두사를 기준으로 호텔 검색하는 메서드
	public List<Hotel> getHotelsByLocationPrefix(String locationPrefix) {
		return hotelListRepository.getHotelsByLocationPrefix(locationPrefix);
	}

}
