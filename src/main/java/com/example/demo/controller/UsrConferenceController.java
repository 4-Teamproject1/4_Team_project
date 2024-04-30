package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.BoardService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.service.TrainTicketService;
import com.example.demo.service.ConferenceService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Conference;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;


import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrConferenceController {

	@Autowired
	private Rq rq;

	@Autowired
	private ConferenceService conferenceService;

	public UsrConferenceController() {

	}

	// 액션 메서드
	@RequestMapping("usr/conference/crawl")
	public List<Conference> crawlAndSaveConferences() {
		return conferenceService.crawlAndSaveConferences();
	}

	@RequestMapping("/usr/conference/detail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");
		 Conference conference = conferenceService.getEventById(id);
		/* model.addAttribute("articles", articles); */
		 model.addAttribute("conference", conference);
		return "usr/conference/detail";
	}

	@RequestMapping("/usr/conference/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Conference> conferences = conferenceService.getShopsList();
		System.err.println(conferences);
		model.addAttribute("conferences", conferences);

		return "usr/conference/list";
	}
	
	
	

	@GetMapping("usr/conference/getConferencesByCategory")
	public ResponseEntity<?> getConferencesByCategory(@RequestParam("categoryId") int categoryId) {
	    List<Conference> conferenceList; // 변수를 먼저 선언합니다.

	    if(categoryId == 0) {
	        conferenceList = conferenceService.getShopsList(); // if 블록 내에서 conferenceList에 값을 할당합니다.
	    } else {
	        conferenceList = conferenceService.getConferencesByCategory(categoryId); // else 블록 내에서 conferenceList에 값을 할당합니다.
	    }

	    return ResponseEntity.ok().body(conferenceList);
	}

	
	
	

}
