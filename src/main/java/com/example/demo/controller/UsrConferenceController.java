package com.example.demo.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ConferenceService;
import com.example.demo.service.ScrapService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Conference;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrConferenceController {

	@Autowired
	private Rq rq;

	@Autowired
	private ConferenceService conferenceService;
	

	@Autowired
	private ScrapService scrapService;

	public UsrConferenceController() {

	}

	// 액션 메서드
	@RequestMapping("usr/conference/crawl")
	public List<Conference> crawlAndSaveConferences() {
		return conferenceService.crawlAndSaveConferences();
	}

	@RequestMapping("/usr/conference/detail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model, int id, int themeId) {

		Rq rq = (Rq) req.getAttribute("rq");
		 Conference conference = conferenceService.getEventById(id);
		 
		 ResultData usersScrapRd = scrapService.usersScrap(rq.getLoginedMemberId(), themeId, id);

			if (usersScrapRd.isSuccess()) {
				model.addAttribute("userCanScrap", usersScrapRd.isSuccess());
			}
		 
			model.addAttribute("isAlreadyAddGoodRp",
					scrapService.isAlreadyAddGoodRp(rq.getLoginedMemberId(),themeId, id));
		/* model.addAttribute("articles", articles); */
		 model.addAttribute("conference", conference);
		return "usr/conference/detail";
	}

	@RequestMapping("/usr/conference/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model,
	    @RequestParam(defaultValue = "1") int page,
	    @RequestParam(defaultValue = "20") int limit,
	    @RequestParam(defaultValue = "1") int categoryId,
	    @RequestParam(defaultValue = "") String searchKeyword) {
	    
	    Rq rq = (Rq) req.getAttribute("rq");

	    int offset = (page - 1) * limit;
	    List<Conference> conferences = conferenceService.getShopsList(categoryId, searchKeyword, offset, limit);
	    int totalConferences = conferenceService.countConferences(categoryId, searchKeyword);
	    int totalPages = (int) Math.ceil((double) totalConferences / limit);

	    model.addAttribute("conferences", conferences);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);

	    return "usr/conference/list";
	}

	

	@RequestMapping("/usr/conference/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {
		System.err.println(id);

		ResultData increaseHitCountRd = conferenceService.increaseHitCount(id);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", conferenceService.getConferenceHitCount(id));

		rd.setData2("id", id);

		return rd;

	}

	
	// Controller
	@RequestMapping("/usr/conference/getFilteredConferences")
	public ResponseEntity<?> getFilteredConferences(@RequestParam("option") String option, 
	                                                @RequestParam("categoryId") int categoryId,
	                                                @RequestParam(defaultValue = "1") int page,
	                                                @RequestParam(defaultValue = "20") int limit) {
	    int totalConferences = conferenceService.countFilteredConferences(option, categoryId);
	    int totalPages = (int) Math.ceil((double) totalConferences / limit);
	    List<Conference> conferenceList = conferenceService.getFilteredConferences(option, categoryId, page, limit);
	  System.out.println(totalConferences);
	  System.out.println(totalConferences);
	    System.err.println(totalPages);
	    
	    
	    
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("conferences", conferenceList);
	    response.put("totalPages", totalPages);
	    response.put("currentPage", page);
	    return ResponseEntity.ok().body(response);
	}

	@RequestMapping("/usr/conference/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Conference conference = conferenceService.getConferenceId(id);
		
		if (conference == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 학회행사는 존재하지 않습니다", id));
		}
		
		ResultData loginedMemberCanDeleteRd = conferenceService.userCanDelete(rq.getLoginedMemberId(), conference);

		if (loginedMemberCanDeleteRd.isSuccess()) {
			conferenceService.deleteConference(id);
		}

		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), "../conference/list");
	}
	
	
	/*
	 * @GetMapping("usr/conference/getConferencesByCategory") public
	 * ResponseEntity<?> getConferencesByCategory(@RequestParam("categoryId") int
	 * categoryId) { List<Conference> conferenceList; // 변수를 먼저 선언합니다.
	 * 
	 * if(categoryId == 0) { conferenceList = conferenceService.getShopsList(); //
	 * if 블록 내에서 conferenceList에 값을 할당합니다. } else { conferenceList =
	 * conferenceService.getConferencesByCategory(categoryId); // else 블록 내에서
	 * conferenceList에 값을 할당합니다. }
	 * 
	 * return ResponseEntity.ok().body(conferenceList); }
	 */
}