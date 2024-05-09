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

	// 액션 메서드
	@RequestMapping("usr/hotel/crawl")

	public List<Hotel> crawlAndSaveHotelList(HttpServletRequest req, HttpServletResponse response, Model model) {

		return hotelListService.crawlAndSaveHotelList();
	}

	/*
	 * @RequestMapping("usr/hotel/recommendlist") public String
	 * showHotelList2(HttpServletRequest req, Model model) { Rq rq = (Rq)
	 * req.getAttribute("rq");
	 * 
	 * List<Hotel> hotelList = hotelListService.getHotelList();
	 * model.addAttribute("hotelList", hotelList);
	 * 
	 * return "usr/hotel/recommendlist"; }
	 */

	@RequestMapping("usr/hotel/recommendlist")
	public String showRecommendedHotelList(@RequestParam(defaultValue = "") String area,
			Model model) {
		System.out.println(area);
		if (area == null || area.equals("")) {
			List<Hotel> hotelList = hotelListService.getAllHotelList();
			model.addAttribute("hotelList", hotelList);

		} else {
			List<Hotel> hotelList = hotelListService.getHotelList(area);
			model.addAttribute("hotelList", hotelList);
		}
		return "usr/hotel/recommendlist";
	}

	@RequestMapping("usr/hotel/searchList")
	public String showSearchHotelList(@RequestParam(required = false) String endLocation, Model model) {
		if (endLocation != null && !endLocation.isEmpty() && endLocation.length() >= 2) {
			String searchPrefix = endLocation.substring(0, 2); // 앞 두 글자 추출
			List<Hotel> filteredHotels = hotelListService.getHotelsByLocationPrefix(searchPrefix + "%");
			model.addAttribute("hotelList", filteredHotels);
		} else {
			model.addAttribute("hotelList", new ArrayList<>()); // 입력값이 부적절하면 빈 목록을 반환
		}
		return "usr/hotel/recommendlist";
	}

}
