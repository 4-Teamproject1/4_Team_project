package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.BusTicketService2;
import com.example.demo.vo.Bus;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrBusController {
	
	@Autowired
	private BusTicketService2 butTicketService2;
	
	// 버스 추천 목록을 가져와서 화면에 표시하는 액션 메서드
	@RequestMapping("/usr/recommend/BusList")
	public String recommendTrainList(HttpServletRequest req, Model model,
			@RequestParam (defaultValue="동서울") String departureBus,
			@RequestParam (defaultValue="대전복합") String arriveBus,
			@RequestParam(defaultValue = "21") String ondate
			) {
		// 버스 서비스를 통해 버스 정보 가져오기
		List<Bus> busLists = butTicketService2.getBusservice(departureBus, arriveBus, ondate);

		 // 여기서 spanTexts를 이용하여 모델에 추가
		// 버스 정보를 모델에 추가
		  for (Bus text : busLists) {
              System.out.println("텍스트: " + text);
          }
        model.addAttribute("busLists", busLists);
     // 버스 목록 화면으로 이동
        return "usr/recommend/BusList"; 
	}
}
