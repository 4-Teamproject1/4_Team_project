package com.example.demo.controller;

import java.util.ArrayList;
import java.util.List;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.HotelListService;
import com.example.demo.vo.Hotel;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class UsrHotelListController {

	@Autowired
	private Rq rq;

	@Autowired
	private HotelListService hotelListService;

	public UsrHotelListController() {

	}

	// 호텔 리스트 크롤링 및 저장하는 메서드 호출
	@RequestMapping("usr/hotel/crawl")
	public List<Hotel> crawlAndSaveHotelList(HttpServletRequest req, HttpServletResponse response, Model model) {
	    return hotelListService.crawlAndSaveHotelList();
	}

	// 추천된 호텔 리스트를 보여주는 메서드
	@RequestMapping("usr/hotel/recommendlist")
	public String showRecommendedHotelList(@RequestParam(defaultValue = "") String area, Model model) {
	    // 지역(area)에 따라 추천된 호텔 리스트를 가져와서 모델에 추가합니다.
	    if (area == null || area.equals("")) {
	        // 만약 지역(area)이 없거나 비어있다면 모든 호텔 리스트를 가져와서 모델에 추가합니다.
	        List<Hotel> hotelList = hotelListService.getAllHotelList();
	        model.addAttribute("hotelList", hotelList);
	    } else {
	        // 지역(area)에 해당하는 호텔 리스트를 가져와서 모델에 추가합니다.
	        List<Hotel> hotelList = hotelListService.getHotelList(area);
	        model.addAttribute("hotelList", hotelList);
	    }
	    // 추천된 호텔 리스트를 표시하는 뷰 페이지로 이동합니다.
	    return "usr/hotel/recommendlist";
	}

	// 검색된 호텔 리스트를 보여주는 메서드
	@RequestMapping("usr/hotel/searchList")
	public String showSearchHotelList(@RequestParam(required = false) String endLocation, Model model) {
	    if (endLocation != null && !endLocation.isEmpty() && endLocation.length() >= 2) {
	        // 검색된 위치(endLocation)가 null이 아니고 비어있지 않으며 길이가 2 이상이면 실행됩니다.
	        String searchPrefix = endLocation.substring(0, 2); // 검색된 위치의 앞 두 글자를 추출합니다.
	        // 검색된 위치의 앞 두 글자로 시작하는 호텔 리스트를 가져와서 모델에 추가합니다.
	        List<Hotel> filteredHotels = hotelListService.getHotelsByLocationPrefix(searchPrefix + "%");
	        model.addAttribute("hotelList", filteredHotels);
	    } else {
	        // 검색된 위치가 부적절한 경우 빈 목록을 생성하여 모델에 추가합니다.
	        model.addAttribute("hotelList", new ArrayList<>());
	    }
	    // 검색된 호텔 리스트를 표시하는 뷰 페이지로 이동합니다.
	    return "usr/hotel/recommendlist";
	}


}
