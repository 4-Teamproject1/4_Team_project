package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.MemberRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Conference;
import com.example.demo.vo.Inquiry;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Service
public class MemberService {
	@Autowired
	private MemberRepository memberRepository;

	public MemberService(MemberRepository memberRepository) {
		this.memberRepository = memberRepository;
	}
	// 회원 가입 처리 메서드
	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		// 로그인 아이디로 회원 조회
		Member existsMember = getMemberByLoginId(loginId);
		 // 이미 사용중인 아이디인 경우
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}
		 // 이름과 이메일로 회원 조회
		existsMember = getMemberByNameAndEmail(name, email);
		// 이미 사용중인 이름과 이메일인 경우
		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}
		// 회원가입 처리
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);
		 // 마지막으로 삽입된 회원의 ID 조회
		int id = memberRepository.getLastInsertId();
		// 회원가입 완료 결과 반환
		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);

	}
	 // 이름과 이메일로 회원 조회
	private Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}
	// 로그인 아이디로 회원 조회
	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}
	// ID로 회원 조회
	public Member getMember(int id) {
		return memberRepository.getMember(id);
	}
	 // 회원 정보 수정 (비밀번호 포함)
	public ResultData modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.modify(loginedMemberId, loginPw, name, nickname, cellphoneNum, email);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}
	 // 회원 정보 수정 (비밀번호 제외)
	public ResultData modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.modifyWithoutPw(loginedMemberId, name, nickname, cellphoneNum, email);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}
	
	//문의사항
	public ResultData<Integer> inquirywriteArticle(int loginedMemberId, String title, String body) {
		memberRepository.inquirywriteArticle(loginedMemberId, title, body);
		// 마지막으로 삽입된 문의 사항의 ID 조회
		int id = memberRepository.getLastInsertId();
		// 문의 사항 작성 완료 결과 반환
		return ResultData.from("S-1", Ut.f("%d번 글이 생성되었습니다", id), "id", id);
	}
	// 삭제하기위한 문의 사항 조회 (ID로)
	public Inquiry getInquiry(int id) {
		
		return memberRepository.getInquiry(id);
	}
	// 모든 문의 사항 조회 (회원 ID로)
	public List<Inquiry> getAllInquiries(int memberId) {
	    return memberRepository.getAllInquiries(memberId);
	}
	 // 문의 사항 조회 (ID로)
	public Inquiry getInquiryById(int id) {
	    return memberRepository.getInquiry(id);
	}
	// 회원 탈퇴 처리
	public ResultData withdrawMember(int memberId) {
		
	    int affectedRows = memberRepository.updateDelStatus(memberId, 1); // delStatus를 1로 설정
	    //회원 탈퇴 실패한 경우
	    if (affectedRows == 0) {
	        return ResultData.from("F-1", "회원 탈퇴에 실패했습니다.");
	    }
	 // 회원 탈퇴 성공한 경우
	    return ResultData.from("S-1", "회원 탈퇴에 성공했습니다.");
	}
	 // 회원의 레벨 조회
	public ResultData getMemberLevel(int memberId) {
		
		int LevelId = memberRepository.getMemberLevel(memberId);
		 // 관리자가 아닌 경우
		if(LevelId != 7) {
			return ResultData.from("F-10", "관리자가 아닙니다.");
		}
		// 관리자인 경우
		return ResultData.from("S-10", "안녕하세요 관리자");
	}
	// 모든 회원 조회
	public List<Member> getMembers() {

		return memberRepository.getMembers();
	}
	
	
	//문의사항삭제관련
	public ResultData userCanDelete(int loginedMemberId, Inquiry inquiry) {
		System.err.println(loginedMemberId);
		System.err.println(inquiry.getImemberId());
		 // 삭제 권한이 없는 경우
		if (inquiry.getImemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 문의사항에 대한 삭제 권한이 없습니다", inquiry.getId()));
		}
		// 삭제 권한이 있는 경우
		return ResultData.from("S-1", Ut.f("%d번 문의사항이 삭제 되었습니다", inquiry.getId()));
	}
	// 문의 사항 삭제
	public ResultData deleteConference(int id) {
		memberRepository.deleteInquiry(id);
		return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));
	}
	// 모든 문의 사항 조회
	public List<Inquiry> getAllInquiries2() {
		return memberRepository.getAllInquiries2();
	}
	
	
}
