package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.service.ConferenceService;
import com.example.demo.service.ScrapService;
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
		 
			model.addAttribute("isAlreadyAddGoodRp",scrapService.isAlreadyAddGoodRp(rq.getLoginedMemberId(),themeId, id));

			

	
		/* model.addAttribute("articles", articles); */
		model.addAttribute("conference", conference);
		return "usr/conference/detail";
	}

	@RequestMapping("/usr/conference/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model,
			@RequestParam(defaultValue = "1") int categoryId,
//			@RequestParam(defaultValue = "title") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Conference> conferences = conferenceService.getShopsList(categoryId, searchKeyword);
		System.err.println(conferences);

		model.addAttribute("categoryId", categoryId);
//		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("conferences", conferences);

		return "usr/conference/list";
	}

	@GetMapping("/usr/conference/getFilteredConferences")
	public ResponseEntity<?> getFilteredConferences(@RequestParam("option") String option,
			@RequestParam("categoryId") int categoryId) {
		System.err.println(option);
		List<Conference> conferenceList;

		// 선택된 옵션에 따라 적절한 정렬 방식으로 conferenceList를 가져옵니다.
		if ("등록/수정일순".equals(option)) {
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByRegDate(); // categoryId가 0인 경우 전체 학술행사를
																					// 등록/수정일순으로 정렬하여 가져옵니다.
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByRegDate(categoryId); // categoryId에
																										// 해당하는 학술행사를
																										// 등록/수정일순으로
																										// 정렬하여 가져옵니다.
			}
		} else if ("조회순".equals(option)) {
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByhitCount(); // categoryId가 0인 경우 전체 학술행사를
																					// 등록/수정일순으로 정렬하여 가져옵니다.
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByhitCount(categoryId); // categoryId에
																										// 해당하는 학술행사를
																										// 등록/수정일순으로
																										// 정렬하여 가져옵니다.
			}
			// 조회순으로 정렬된 conferenceList를 가져오는 로직을 추가합니다.
		} else if ("마감순".equals(option)) {
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByfinDate(); // categoryId가 0인 경우 전체 학술행사를
																					// 등록/수정일순으로 정렬하여 가져옵니다.
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByfinDate(categoryId); // categoryId에
																										// 해당하는 학술행사를
																										// 등록/수정일순으로
																										// 정렬하여 가져옵니다.
			}
			// 마감순으로 정렬된 conferenceList를 가져오는 로직을 추가합니다.
		} else if ("제목순".equals(option)) {
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderBytitle(); // categoryId가 0인 경우 전체 학술행사를 등록/수정일순으로
																					// 정렬하여 가져옵니다.
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderBytitle(categoryId); // categoryId에 해당하는
																										// 학술행사를
																										// 등록/수정일순으로
																										// 정렬하여 가져옵니다.
			}
			// 제목순으로 정렬된 conferenceList를 가져오는 로직을 추가합니다.
		} else {
			// 정렬 옵션이 올바르지 않은 경우 예외 처리를 합니다.
			return ResponseEntity.badRequest().body("올바르지 않은 정렬 옵션입니다.");
		}

		return ResponseEntity.ok().body(conferenceList);
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
