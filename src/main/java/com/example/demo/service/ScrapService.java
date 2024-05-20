package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.repository.ScrapRepository;
import com.example.demo.vo.ResultData;

@Service
public class ScrapService {

	@Autowired
	private ConferenceService ConferenceService;

	@Autowired
	private CompetitionService CompetitionService;

	@Autowired
	private ScrapRepository scrapRepository;

	public ScrapService(ScrapRepository reactionPointRepository) {
		this.scrapRepository = scrapRepository;
	}
	
	// 사용자 즐겨찾기를 처리하는 메서드
	public ResultData usersReaction(int loginedMemberId, int themeId, int academyId) {
		// 로그인 여부 확인
		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}
		// 사용자 총 즐겨찾기 점수 조회
		int sumReactionPointByMemberId = scrapRepository.getSumReactionPoint(loginedMemberId, themeId, academyId);
		
		// 디버그 정보 출력
		System.err.println("sumReactionPointByMemberId : " + sumReactionPointByMemberId);
		System.err.println("sumReactionPointByMemberId : "
				+ scrapRepository.getSumReactionPoint(loginedMemberId, themeId, academyId));
		System.err.println("loginedMemberId : " + loginedMemberId);
		System.err.println("themeId : " + themeId);
		System.err.println("academyId : " + academyId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천 불가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}
		// 즐겨찾기를 추가할 수 있는 경우
		return ResultData.from("S-1", "추천 가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}
	
	// '즐겨찾기' 반응을 추가하는 메서드
	public ResultData addGoodReactionPoint(int loginedMemberId, int themeId, int academyId) {
		// 즐겨찾기 추가
		int affectedRow = scrapRepository.addGoodReactionPoint(loginedMemberId, themeId, academyId);
		// 디버그 정보 출력
		System.err.println("affectedRow : " + affectedRow);
		// 즐겨찾기 추가 실패한 경우
		if (affectedRow != 1) {
			return ResultData.from("F-1", "즐겨찾기 실패");
		}
		// 즐겨찾기 성공 시 테마에 따라 서비스 호출
		if (themeId == 1) {
			ConferenceService.increaseGoodReactionPoint(academyId, themeId);
		} else {
			CompetitionService.increaseGoodReactionPoint(academyId, themeId);
		}
		// 즐겨찾기 성공
		return ResultData.from("S-1", "즐겨찾기 성공!");
	}

	// 즐겨찾기를 삭제하는 메서드
	public ResultData deleteGoodReactionPoint(int loginedMemberId, int themeId, int academyId) {
		// 즐겨찾기 삭제
		scrapRepository.deleteReactionPoint(loginedMemberId, themeId, academyId);
		// 테마에 따라 서비스 호출
		if (themeId == 1) {
			ConferenceService.decreaseGoodReactionPoint(themeId, academyId);
		} else {
			CompetitionService.decreaseGoodReactionPoint(themeId, academyId);
		}
		// 즐겨찾기 삭제 성공
		return ResultData.from("S-1", "즐겨찾기 취소 됨");

	}

	
	// 사용자가 이미 즐겨찾기를 추가했는지 확인하는 메서드
	public boolean isAlreadyAddGoodRp(int memberId, int academyId, int themeId) {
		int getPointTypeCodeByMemberId = scrapRepository.getSumReactionPoint(memberId, academyId, themeId);
		// 즐겨찾기가 있는 경우
		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}
		// 즐겨찾기가 없는 경우
		return false;
	}
	// 사용자의 즐겨찾기를 처리하는 메서드
	public ResultData usersScrap(int loginedMemberId, int academyId, int themeId) {
		// 로그인 여부 확인
		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}
		// 사용자의 즐겨찾기를  조회

		int sumScrapByMemberId = scrapRepository.getSumScrapCount(loginedMemberId, academyId, themeId);
		// 이미 즐겨찾기를 경우
		if (sumScrapByMemberId != 0) {
			return ResultData.from("F-1", "즐겨찾기 불가능", "sumScrapByMemberId", sumScrapByMemberId);
		}
		// 즐겨찾기를 할 수 있는 경우
		return ResultData.from("S-1", "즐겨찾기 가능", "sumScrapByMemberId", sumScrapByMemberId);
	}

	/*
	 * public boolean isAlreadyAddBadRp(int memberId, int relId) { int
	 * getPointTypeCodeByMemberId =
	 * reactionPointRepository.getSumReactionPoint(memberId, relId);
	 * 
	 * if (getPointTypeCodeByMemberId < 0) { return true; }
	 * 
	 * return false; }
	 */

}
