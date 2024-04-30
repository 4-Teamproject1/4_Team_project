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
import com.example.demo.service.CompetitionService;
import com.example.demo.service.ConferenceService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Article;
import com.example.demo.vo.Board;
import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrCompetitionController {

	@Autowired
	private Rq rq;

	@Autowired
	private CompetitionService competitionService;

	public UsrCompetitionController() {

	}

	// 액션 메서드
	@RequestMapping("usr/competition/crawl")
	public List<Competition> crawlAndSaveConferences() {
		return competitionService.crawlAndSaveCompetitions();
	}

	@RequestMapping("/usr/competition/detail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model, int id) {

		Rq rq = (Rq) req.getAttribute("rq");
		Competition competition = competitionService.getEventById(id);
		/* model.addAttribute("articles", articles); */
		 model.addAttribute("competition", competition);
		return "usr/competition/detail";
	}

	@RequestMapping("/usr/competition/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Competition> competitions = competitionService.getCompetitionsList();
		System.err.println(competitions);
		model.addAttribute("competitions", competitions);

		return "usr/competition/list";
	}
	
	

	@GetMapping("/usr/competition/getFilteredCompetitions")
	public ResponseEntity<?> getFilteredCompetitions(@RequestParam("option") String option) {
		System.err.println(option);
	    List<Competition> competitionList;

	    // 선택된 옵션에 따라 적절한 정렬 방식으로 conferenceList를 가져옵니다.
	    if ("등록/수정일순".equals(option)) {
	      
	    	competitionList = competitionService.getCompetitionsByCategoryOrderByRegDate(); // categoryId에 해당하는 학술행사를 등록/수정일순으로 정렬하여 가져옵니다.
	     
	    } else if ("조회순".equals(option)) {
	    	
	    	competitionList = competitionService.getCompetitionsByCategoryOrderByhitCount(); // categoryId에 해당하는 학술행사를 등록/수정일순으로 정렬하여 가져옵니다.
		      
	        
	    } else if ("마감순".equals(option)) {
	    	  
	    	competitionList = competitionService.getCompetitionsByCategoryOrderByfinDate(); // categoryId에 해당하는 학술행사를 등록/수정일순으로 정렬하여 가져옵니다.
		      
	       
	    } else if ("제목순".equals(option)) {
	    	 
	    	competitionList = competitionService.getCompetitionsByCategoryOrderBytitle(); // categoryId에 해당하는 학술행사를 등록/수정일순으로 정렬하여 가져옵니다.
	     
	    } else {
	        // 정렬 옵션이 올바르지 않은 경우 예외 처리를 합니다.
	        return ResponseEntity.badRequest().body("올바르지 않은 정렬 옵션입니다.");
	    }

	    return ResponseEntity.ok().body(competitionList);
	}


}
