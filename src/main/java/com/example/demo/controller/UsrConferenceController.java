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

import com.example.demo.service.ConferenceService;
import com.example.demo.service.ScrapService;
import com.example.demo.util.Ut;
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

	@Autowired
	private ScrapService scrapService;

	public UsrConferenceController() {

	}

	// 액션 메서드
	// 회의 정보를 크롤링하고 저장하는 메서드
	@RequestMapping("usr/conference/crawl")
	public List<Conference> crawlAndSaveConferences() {
		return conferenceService.crawlAndSaveConferences();
	}

	// 회의 상세 페이지를 보여주는 메서드
	@RequestMapping("/usr/conference/detail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model, int id, int themeId) {

		// 현재 로그인한 사용자 정보 가져오기
		Rq rq = (Rq) req.getAttribute("rq");

		// 해당 ID에 해당하는 회의 정보 가져오기
		Conference conference = conferenceService.getEventById(id);

		// 현재 사용자가 해당 회의를 스크랩할 수 있는지 확인하기
		ResultData usersScrapRd = scrapService.usersScrap(rq.getLoginedMemberId(), themeId, id);

		// 사용자가 해당 회의를 스크랩할 수 있는 경우, 모델에 속성 추가
		if (usersScrapRd.isSuccess()) {
			model.addAttribute("userCanScrap", usersScrapRd.isSuccess());
		}

		// 현재 사용자가 해당 회의에 이미 좋아요를 눌렀는지 확인하고, 모델에 속성 추가
		model.addAttribute("isAlreadyAddGoodRp", scrapService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), themeId, id));
		model.addAttribute("conference", conference);
		return "usr/conference/detail";
	}

	// 회의 목록 페이지를 보여주는 메서드
	@RequestMapping("/usr/conference/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int page,
			@RequestParam(defaultValue = "20") int limit, @RequestParam(defaultValue = "1") int categoryId,
			@RequestParam(defaultValue = "") String searchKeyword) {

		// 현재 로그인한 사용자 정보 가져오기
		Rq rq = (Rq) req.getAttribute("rq");

		// 오프셋 설정
		int offset = (page - 1) * limit;

		// 검색 키워드를 이용하여 회의 목록 가져오기
		List<Conference> conferences = conferenceService.getShopsList(categoryId, searchKeyword, offset, limit);
		// 검색 키워드를 이용하여 총 회의 수 가져오기
		int totalConferences = conferenceService.countConferences(categoryId, searchKeyword);
		// 총 페이지 수 계산
		int totalPages = (int) Math.ceil((double) totalConferences / limit);

		// 모델에 속성 추가
		model.addAttribute("conferences", conferences);
		model.addAttribute("totalPages", totalPages);
		model.addAttribute("currentPage", page);

		return "usr/conference/list";
	}

	// 회의 조회수 증가 처리 후 결과를 반환하는 메서드
	@RequestMapping("/usr/conference/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {
		// 회의 조회수 증가 처리
		ResultData increaseHitCountRd = conferenceService.increaseHitCount(id);

		// 조회수 증가 처리 결과가 실패한 경우 결과 반환
		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		// 조회수 증가 처리 결과와 조회수를 포함한 결과 데이터 반환
		ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", conferenceService.getConferenceHitCount(id));

		rd.setData2("id", id);

		return rd;
	}

	// 정렬 옵션에 따라 회의 목록을 가져오는 메서드
	@GetMapping("/usr/conference/getFilteredConferences")
	public ResponseEntity<?> getFilteredConferences(@RequestParam("option") String option,
			@RequestParam("categoryId") int categoryId) {
		// 선택된 옵션에 따라 적절한 정렬 방식으로 회의 목록을 가져오기
		List<Conference> conferenceList;

		if ("등록/수정일순".equals(option)) {
			// 등록/수정일순으로 회의 목록 가져오기
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByRegDate();
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByRegDate(categoryId);
			}
		} else if ("조회순".equals(option)) {
			// 조회순으로 회의 목록 가져오기
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByhitCount();
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByhitCount(categoryId);
			}
		} else if ("마감순".equals(option)) {
			// 마감순으로 회의 목록 가져오기
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderByfinDate();
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderByfinDate(categoryId);
			}
		} else if ("제목순".equals(option)) {
			// 제목순으로 회의 목록 가져오기
			if (categoryId == 0) {
				conferenceList = conferenceService.getConferencesOrderBytitle();
			} else {
				conferenceList = conferenceService.getConferencesByCategoryOrderBytitle(categoryId);
			}
		} else {
			// 정렬 옵션이 올바르지 않은 경우 예외 처리
			return ResponseEntity.badRequest().body("올바르지 않은 정렬 옵션입니다.");
		}

		return ResponseEntity.ok().body(conferenceList);
	}

	// 회의 삭제 처리 후 결과를 반환하는 메서드
	@RequestMapping("/usr/conference/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
		// 현재 로그인한 사용자 정보 가져오기
		Rq rq = (Rq) req.getAttribute("rq");

		// 해당 ID에 해당하는 회의 정보 가져오기
		Conference conference = conferenceService.getConferenceId(id);

		// 해당 회의가 존재하지 않는 경우 예외 처리
		if (conference == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 학회행사는 존재하지 않습니다", id));
		}

		// 현재 사용자가 해당 회의를 삭제할 수 있는지 확인하고 결과 반환
		ResultData loginedMemberCanDeleteRd = conferenceService.userCanDelete(rq.getLoginedMemberId(), conference);

		if (loginedMemberCanDeleteRd.isSuccess()) {
			conferenceService.deleteConference(id);
		}

		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(),
				"../conference/list");
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