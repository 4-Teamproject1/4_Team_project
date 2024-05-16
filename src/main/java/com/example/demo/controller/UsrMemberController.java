package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.CompetitionService;
import com.example.demo.service.ConferenceService;
import com.example.demo.service.MemberService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;
import com.example.demo.vo.Inquiry;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrMemberController {

	@Autowired
	private Rq rq;

	@Autowired
	private MemberService memberService;

	@Autowired
	private CompetitionService competitionService;

	@Autowired
	private ConferenceService conferenceService;

	@RequestMapping("/usr/member/getLoginIdDup")
	@ResponseBody
	// 로그인 아이디 중복 확인을 처리하는 메서드
	public ResultData getLoginIdDup(String loginId) {

		if (Ut.isEmpty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}

		Member existsMember = memberService.getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-2", "해당 아이디는 이미 사용중입니다.", "loginId", loginId);
		}

		return ResultData.from("S-1", "사용 가능!", "loginId", loginId);
	}


	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	// 로그아웃을 처리하는 메서드
	public String doLogout(HttpServletRequest req, @RequestParam(defaultValue = "/") String afterLogoutUri) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그아웃 상태입니다.");
		}

		rq.logout();

		return Ut.jsReplace("S-1", "로그아웃 되었습니다.", afterLogoutUri);
	}

	@RequestMapping("/usr/member/login")
	// 로그인 페이지를 보여주는 메서드
	public String showLogin(HttpServletRequest req) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 되어있습니다.");
		}

		return "usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	// 로그인을 처리하는 메서드
	public String doLogin(HttpServletRequest req, String loginId, String loginPw,
			@RequestParam(defaultValue = "/") String afterLoginUri) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 되어있습니다.");
		}

		if (Ut.isNullOrEmpty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("F-3", Ut.f("%s(은)는 존재하지 않는 아이디입니다.", loginId));
		}

		// 회원 탈퇴 상태 체크
		if (member.isDelStatus()) {
			return Ut.jsHistoryBack("F-3", "탈퇴한 회원입니다.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("F-4", Ut.f("비밀번호가 일치하지 않습니다."));
		}

		rq.login(member);

		if (afterLoginUri.length() > 0) {
			return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), afterLoginUri);
		}

		return Ut.jsReplace("S-1", Ut.f("%s님 환영합니다", member.getNickname()), "/");
	}

	@RequestMapping("/usr/member/join")
	// 회원가입 페이지를 보여주는 메서드
	public String showJoin(HttpServletRequest req) {

		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	// 회원가입을 처리하는 메서드
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String name, String nickname,
			String cellphoneNum, String email) {
		Rq rq = (Rq) req.getAttribute("rq");
		if (rq.isLogined()) {
			return Ut.jsHistoryBack("F-A", "이미 로그인 상태입니다.");
		}

		if (Ut.isNullOrEmpty(loginId)) {
			return Ut.jsHistoryBack("F-1", "아이디를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(loginPw)) {
			return Ut.jsHistoryBack("F-2", "비밀번호를 입력해주세요");
		}
		if (Ut.isNullOrEmpty(name)) {
			return Ut.jsHistoryBack("F-3", "이름을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(nickname)) {
			return Ut.jsHistoryBack("F-4", "닉네임을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(cellphoneNum)) {
			return Ut.jsHistoryBack("F-5", "전화번호를 입력해주세요");

		}
		if (Ut.isNullOrEmpty(email)) {
			return Ut.jsHistoryBack("F-6", "이메일을 입력해주세요");
		}

		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		if (joinRd.isFail()) {
			return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		Member member = memberService.getMember(joinRd.getData1());

		return Ut.jsReplace(joinRd.getResultCode(), joinRd.getMsg(), "../member/login");
	}

	@RequestMapping("/usr/member/myPage")
	// 내 정보 페이지를 보여주는 메서드
	public String showMyPage(HttpServletRequest req) {
		/*
		 * Rq rq = (Rq) req.getAttribute("rq");
		 * 
		 * if (!rq.isLogined()) { return Ut.jsHistoryBack("F-1", "로그인이 필요합니다."); }
		 */
		return "usr/member/myPage";
	}

	@RequestMapping("/usr/member/myInfo")
	// 내 정보 페이지를 보여주는 메서드
	public String myInfo(HttpServletRequest req) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-1", "로그인이 필요합니다."); // 로그인이 필요한 경우 팝업 창을 띄움
		}
		return "/usr/member/myInfo";
	}

	@RequestMapping("/usr/member/mySchedule")
	// 내 일정 페이지를 보여주는 메서드
	public String mySchedule(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		List<Conference> conferences = conferenceService.getscrapShopsList(rq.getLoginedMemberId());

		List<Competition> competitions = competitionService.getscrapShopsList(rq.getLoginedMemberId());

		model.addAttribute("conferences", conferences);
		model.addAttribute("competitions", competitions);
		System.err.println("conferences" + conferences);
		return "/usr/member/mySchedule";
	}

	@RequestMapping("/usr/member/checkPw")
	// 비밀번호 확인 페이지를 보여주는 메서드
	public String showCheckPw() {

		return "usr/member/checkPw";
	}

	@RequestMapping("/usr/member/doCheckPw")
	// 비밀번호 확인을 처리하는 메서드
	public String doCheckPw(String loginPw) {

		if (Ut.isNullOrEmpty(loginPw)) {
			return rq.historyBackOnView("비밀번호를 입력해주세요.");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return rq.historyBackOnView("비밀번호가 다릅니다.");
		}

		return "usr/member/modify";
	}

	@RequestMapping("/usr/member/doModify")
	@ResponseBody
	// 회원 정보 수정을 처리하는 메서드
	public String doModify(HttpServletRequest req, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		Rq rq = (Rq) req.getAttribute("rq");

		// 비밀번호 안바꿀 수도 있어서 비번 null 체크는 제거

		if (Ut.isNullOrEmpty(name)) {
			return Ut.jsHistoryBack("F-3", "이름을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(nickname)) {
			return Ut.jsHistoryBack("F-4", "닉네임을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(cellphoneNum)) {
			return Ut.jsHistoryBack("F-5", "전화번호를 입력해주세요");

		}
		if (Ut.isNullOrEmpty(email)) {
			return Ut.jsHistoryBack("F-6", "이메일을 입력해주세요");
		}

		ResultData modifyRd;

		if (Ut.isNullOrEmpty(loginPw)) {
			modifyRd = memberService.modifyWithoutPw(rq.getLoginedMemberId(), name, nickname, cellphoneNum, email);
		} else {
			modifyRd = memberService.modify(rq.getLoginedMemberId(), loginPw, name, nickname, cellphoneNum, email);
		}

		return Ut.jsReplace(modifyRd.getResultCode(), modifyRd.getMsg(), "../member/myInfo");
	}

	// 문의사항
	@RequestMapping("/usr/member/inquiry")
	// 문의 작성 페이지를 보여주는 메서드
	public String showinquiry(HttpServletRequest req) {

		return "usr/member/inquiry";
	}

	@RequestMapping("/usr/member/doinquirywrite")
	@ResponseBody
	// 문의 작성을 처리하는 메서드
	public String doWrite(HttpServletRequest req, String title, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isNullOrEmpty(title)) {
			return Ut.jsHistoryBack("F-1", "제목을 입력해주세요");
		}
		if (Ut.isNullOrEmpty(body)) {
			return Ut.jsHistoryBack("F-2", "내용을 입력해주세요");
		}

		ResultData<Integer> inquirywriteArticleRd = memberService.inquirywriteArticle(rq.getLoginedMemberId(), title,
				body);

		int id = (int) inquirywriteArticleRd.getData1();

		Inquiry Inquiry = memberService.getInquiry(id);

		return Ut.jsReplace(inquirywriteArticleRd.getResultCode(), inquirywriteArticleRd.getMsg(),
				"../member/myQuestion");

	}

	@RequestMapping("/usr/member/myQuestionDetail")
	// 내 문의 상세 페이지를 보여주는 메서드
	public String showInquiryDetail(Model model, @RequestParam("id") int inquiryId) {
		Inquiry inquiry = memberService.getInquiryById(inquiryId);
		model.addAttribute("inquiry", inquiry);
		return "usr/member/myQuestionDetail";
	}

	@RequestMapping("/usr/member/myQuestion")
	// 내 문의 목록 페이지를 보여주는 메서드
	public String showMyQuestion(HttpServletRequest req, Model model) {
		Rq rq = (Rq) req.getAttribute("rq");

		Member loginedMember = rq.getLoginedMember();
		List<Inquiry> inquiries;
		if (loginedMember.getId() == 1) {
			inquiries = memberService.getAllInquiries2();
		} else {
			inquiries = memberService.getAllInquiries(loginedMember.getId()); // 모든 문의사항 가져오기
		}

		model.addAttribute("inquiries", inquiries); // JSP 파일에서 inquiries를 사용할 수 있도록 모델에 추가
		return "usr/member/myQuestion"; // myQuestion.jsp 파일을 보여줌
	}

	@RequestMapping("/usr/member/doWithdraw")
	@ResponseBody
	// 회원 탈퇴를 처리하는 메서드
	public String doWithdraw(HttpServletRequest req,
			@RequestParam(defaultValue = "../member/login") String afterLogoutUri) {
		Rq rq = (Rq) req.getAttribute("rq");

		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("F-1", "로그인이 필요합니다.");
		}

		Member loginedMember = rq.getLoginedMember();
		ResultData withdrawRd = memberService.withdrawMember(loginedMember.getId());

		if (withdrawRd.isFail()) {
			return Ut.jsReplace(withdrawRd.getResultCode(), withdrawRd.getMsg(), afterLogoutUri);
		}

		rq.logout(); // 회원 탈퇴 후 자동 로그아웃
		return Ut.jsReplace("S-1", "탈퇴 처리되었습니다.", "/");
	}

	// 관리자일때 문의사항 삭제가능
	@RequestMapping("/usr/member/doDelete")
	@ResponseBody
	// 문의사항을 삭제하는 메서드
	public String doDelete(HttpServletRequest req, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Inquiry inquiry = memberService.getInquiry(id);

		if (inquiry == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 문의사항은 존재하지 않습니다", id));
		}

		ResultData loginedMemberCanDeleteRd = memberService.userCanDelete(rq.getLoginedMemberId(), inquiry);

		if (loginedMemberCanDeleteRd.isSuccess()) {
			memberService.deleteConference(id);
		}

		return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(),
				"../member/myQuestion");
	}

}
