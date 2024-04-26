package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public List<Conference> crawlConferences() {
		return conferenceService.crawlAndSaveConferences();
	}
	

	@RequestMapping("/usr/conference/academicEventDetail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int boardId, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Rq rq = (Rq) req.getAttribute("rq");

	


		/* model.addAttribute("articles", articles); */

		return "usr/conference/academicEventDetail";
	}

	@RequestMapping("/usr/conference/academicEventList")
	public String ShowAcademicEventList(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int boardId, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "title,body") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {

		Rq rq = (Rq) req.getAttribute("rq");

		
		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
	
		return "usr/conference/academicEventList";
	}

}
