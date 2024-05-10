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

	public ResultData<Integer> join(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

		Member existsMember = getMemberByLoginId(loginId);

		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}

		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}

		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다.", "id", id);

	}

	private Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);
	}

	public Member getMember(int id) {
		return memberRepository.getMember(id);
	}

	public ResultData modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.modify(loginedMemberId, loginPw, name, nickname, cellphoneNum, email);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}

	public ResultData modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum,
			String email) {
		memberRepository.modifyWithoutPw(loginedMemberId, name, nickname, cellphoneNum, email);
		return ResultData.from("S-1", "회원정보 수정 완료");
	}
	
	//문의사항
	public ResultData<Integer> inquirywriteArticle(int loginedMemberId, String title, String body) {
		memberRepository.inquirywriteArticle(loginedMemberId, title, body);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 글이 생성되었습니다", id), "id", id);
	}

	public Inquiry getInquiry(int id) {
		
		return memberRepository.getInquiry(id);
	}
	
	public List<Inquiry> getAllInquiries(int memberId) {
	    return memberRepository.getAllInquiries(memberId);
	}

	public Inquiry getInquiryById(int id) {
	    return memberRepository.getInquiry(id);
	}

	public ResultData withdrawMember(int memberId) {
	    int affectedRows = memberRepository.updateDelStatus(memberId, 1); // delStatus를 1로 설정
	    if (affectedRows == 0) {
	        return ResultData.from("F-1", "회원 탈퇴에 실패했습니다.");
	    }
	    return ResultData.from("S-1", "회원 탈퇴에 성공했습니다.");
	}

	public ResultData getMemberLevel(int memberId) {
		
		int LevelId = memberRepository.getMemberLevel(memberId);
		
		if(LevelId != 7) {
			return ResultData.from("F-10", "관리자가 아닙니다.");
		}
		
		return ResultData.from("S-10", "안녕하세요 관리자");
	}

	public List<Member> getMembers() {

		return memberRepository.getMembers();
	}
	
	
	//문의사항삭제관련
	public ResultData userCanDelete(int loginedMemberId, Inquiry inquiry) {
		System.err.println(loginedMemberId);
		System.err.println(inquiry.getImemberId());
		if (inquiry.getImemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 문의사항에 대한 삭제 권한이 없습니다", inquiry.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 문의사항이 삭제 되었습니다", inquiry.getId()));
	}

	public ResultData deleteConference(int id) {
		memberRepository.deleteInquiry(id);
		return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));
	}

	public List<Inquiry> getAllInquiries2() {
		return memberRepository.getAllInquiries2();
	}
	
	
}
