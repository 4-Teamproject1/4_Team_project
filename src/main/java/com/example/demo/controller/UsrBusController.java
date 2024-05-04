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
	
	@RequestMapping("/usr/article/recommendBusList")
	public String recommendTrainList(HttpServletRequest req, Model model,
			@RequestParam (defaultValue="동서울") String departureBus,
			@RequestParam (defaultValue="대전복합") String arriveBus
			) {

		List<Bus> busLists = butTicketService2.getBusservice(departureBus, arriveBus);

		 // 여기서 spanTexts를 이용하여 모델에 추가
		  for (Bus text : busLists) {
              System.out.println("텍스트: " + text);
          }
        model.addAttribute("busLists", busLists);

        return "usr/article/recommendBusList"; 
	}
}
