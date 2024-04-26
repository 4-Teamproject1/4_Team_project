package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.TrainTicketService;
import com.example.demo.vo.Train;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrTrainController {
	
	@Autowired
	private TrainTicketService trainTicketService;
	
	@RequestMapping("/usr/article/recommendTrainList")
	public String recommendTrainList(HttpServletRequest req, Model model) {

		List<Train> spanTexts = trainTicketService.gettrainservice();

		 // 여기서 spanTexts를 이용하여 모델에 추가
		  for (Train text : spanTexts) {
              System.out.println("텍스트: " + text);
          }
        model.addAttribute("spanTexts", spanTexts);

        return "usr/article/recommendTrainList"; 
	}
}