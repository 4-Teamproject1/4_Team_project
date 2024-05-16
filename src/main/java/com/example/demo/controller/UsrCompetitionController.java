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
import com.example.demo.service.ScrapService;
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
	private ScrapService scrapService;

	@Autowired
	private CompetitionService competitionService;

	public UsrCompetitionController() {

	}

	// 액션 메서드
	// 공모전 정보를 크롤링하고 저장하는 메서드
	@RequestMapping("usr/competition/crawl")
	public List<Competition> crawlAndSaveConferences() {
	    return competitionService.crawlAndSaveCompetitions();
	}

	// 공모전 상세 페이지를 보여주는 메서드
	@RequestMapping("/usr/competition/detail")
	public String showAcademicEventDetail(HttpServletRequest req, Model model, int id, int themeId) {

	    // 현재 로그인한 사용자 정보 가져오기
	    Rq rq = (Rq) req.getAttribute("rq");
	    
	    // 해당 ID에 해당하는 공모전 정보 가져오기
	    Competition competition = competitionService.getEventById(id);
	    
	    // 현재 사용자가 해당 공모전을 스크랩할 수 있는지 확인하기
	    ResultData usersScrapRd = scrapService.usersScrap(rq.getLoginedMemberId(), themeId, id);

	    // 사용자가 해당 공모전을 스크랩할 수 있는 경우, 모델에 속성 추가
	    if (usersScrapRd.isSuccess()) {
	        model.addAttribute("userCanScrap", usersScrapRd.isSuccess());
	    }

	    // 현재 사용자가 해당 공모전에 이미 좋아요를 눌렀는지 확인하고, 모델에 속성 추가
	    model.addAttribute("isAlreadyAddGoodRp", scrapService.isAlreadyAddGoodRp(rq.getLoginedMemberId(), themeId, id));
	    // 해당 공모전 정보를 모델에 추가하여 상세 페이지로 이동
	    model.addAttribute("competition", competition);
	    return "usr/competition/detail";
	}

	// 공모전 목록 페이지를 보여주는 메서드
	@RequestMapping("/usr/competition/list")
	public String ShowAcademicEventList(HttpServletRequest req, Model model, @RequestParam(defaultValue = "1") int page,
	        @RequestParam(defaultValue = "20") int limit,
	        @RequestParam(defaultValue = "") String searchKeyword) {
	    // 현재 로그인한 사용자 정보 가져오기
	    Rq rq = (Rq) req.getAttribute("rq");

	    // 오프셋 설정
	    int offset = (page - 1) * limit;
	    
	    // 검색 키워드를 이용하여 공모전 목록 가져오기
	    List<Competition> competitions = competitionService.getCompetitionsList(searchKeyword, offset, limit);
	    // 검색 키워드를 이용하여 총 공모전 수 가져오기
	    int totalCompetitions = competitionService.countCompetitons(searchKeyword);
	    // 총 페이지 수 계산
	    int totalPages = (int) Math.ceil((double) totalCompetitions / limit);
	    
	    // 모델에 속성 추가
	    model.addAttribute("serchKeyword", searchKeyword);
	    model.addAttribute("competitions", competitions);
	    model.addAttribute("totalPages", totalPages);
	    model.addAttribute("currentPage", page);

	    return "usr/competition/list";
	}

	// 공모전 조회수 증가 처리 후 결과를 반환하는 메서드
	@RequestMapping("/usr/competition/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData doIncreaseHitCountRd(int id) {
	    // 공모전 조회수 증가 처리
	    ResultData increaseHitCountRd = competitionService.increaseHitCount(id);

	    // 조회수 증가 처리 결과가 실패한 경우 결과 반환
	    if (increaseHitCountRd.isFail()) {
	        return increaseHitCountRd;
	    }

	    // 조회수 증가 처리 결과와 조회수를 포함한 결과 데이터 반환
	    ResultData rd = ResultData.newData(increaseHitCountRd, "hitCount", competitionService.getCompetitionHitCount(id));

	    rd.setData2("id", id);

	    return rd;
	}

	// 정렬 옵션에 따라 공모전 목록을 가져오는 메서드
	@GetMapping("/usr/competition/getFilteredCompetitions")
	public ResponseEntity<?> getFilteredCompetitions(@RequestParam("option") String option) {
	    // 선택된 옵션에 따라 적절한 정렬 방식으로 공모전 목록을 가져오기
	    List<Competition> competitionList;

	    if ("등록/수정일순".equals(option)) {
	        competitionList = competitionService.getCompetitionsByCategoryOrderByRegDate();
	    } else if ("조회순".equals(option)) {
	        competitionList = competitionService.getCompetitionsByCategoryOrderByhitCount();
	    } else if ("마감순".equals(option)) {
	        competitionList = competitionService.getCompetitionsByCategoryOrderByfinDate();
	    } else if ("제목순".equals(option)) {
	        competitionList = competitionService.getCompetitionsByCategoryOrderBytitle();
	    } else {
	        // 정렬 옵션이 올바르지 않은 경우 예외 처리
	        return ResponseEntity.badRequest().body("올바르지 않은 정렬 옵션입니다.");
	    }

	    return ResponseEntity.ok().body(competitionList);
	}

	// 공모전 삭제 처리 후 결과를 반환하는 메서드
	@RequestMapping("/usr/competition/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {
	    // 현재 로그인한 사용자 정보 가져오기
	    Rq rq = (Rq) req.getAttribute("rq");

	    // 해당 ID에 해당하는 공모전 정보 가져오기
	    Competition competition = competitionService.getcompetitionId(id);
	    
	    // 해당 공모전이 존재하지 않는 경우 예외 처리
	    if (competition == null) {
	        return Ut.jsHistoryBack("F-1", Ut.f("%d번 공모전은 존재하지 않습니다", id));
	    }
	    
	    // 현재 사용자가 해당 공모전을 삭제할 수 있는지 확인하고 결과 반환
	    ResultData loginedMemberCanDeleteRd = competitionService.userCanDelete(rq.getLoginedMemberId(), competition);

	    if (loginedMemberCanDeleteRd.isSuccess()) {
	        competitionService.deleteConference(id);
	    }

	    return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), "../competition/list");
	}

}
