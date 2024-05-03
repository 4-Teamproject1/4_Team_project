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
	private ScrapRepository scrapRepository;

	public ScrapService(ScrapRepository reactionPointRepository) {
		this.scrapRepository = scrapRepository;
	}

	

	public ResultData usersReaction(int loginedMemberId, int academyId, int themeId) {

		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}

		int sumReactionPointByMemberId = scrapRepository.getSumReactionPoint(loginedMemberId,
				academyId, themeId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천 불가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천 가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	public ResultData addGoodReactionPoint(int loginedMemberId, int academyId, int themeId) {

		int affectedRow = scrapRepository.addGoodReactionPoint(loginedMemberId,  themeId, academyId);
		
		System.err.println(affectedRow);
		
		if (affectedRow != 1) {
			return ResultData.from("F-1", "좋아요 실패");
		}


			ConferenceService.increaseGoodReactionPoint(academyId, themeId);
	

		return ResultData.from("S-1", "좋아요!");
	}

	/*
	 * public ResultData addBadReactionPoint(int loginedMemberId, String
	 * relTypeCode, int relId) { int affectedRow =
	 * reactionPointRepository.addBadReactionPoint(loginedMemberId, relId);
	 * 
	 * if (affectedRow != 1) { return ResultData.from("F-1", "싫어요 실패"); }
	 * 
	 * switch (relTypeCode) { case "article":
	 * articleService.increaseBadReactionPoint(relId); break; }
	 * 
	 * return ResultData.from("S-1", "싫어요!"); }
	 */
	public ResultData deleteGoodReactionPoint(int loginedMemberId, int academyId, int themeId) {
		scrapRepository.deleteReactionPoint(loginedMemberId, academyId, themeId);

	
		ConferenceService.decreaseGoodReactionPoint(academyId, themeId);
		
		return ResultData.from("S-1", "좋아요 취소 됨");

	}

	/*
	 * public ResultData deleteBadReactionPoint(int loginedMemberId, String
	 * relTypeCode, int relId) {
	 * reactionPointRepository.deleteReactionPoint(loginedMemberId, relId);
	 * 
	 * switch (relTypeCode) { case "article":
	 * articleService.decreaseBadReactionPoint(relId); break; } return
	 * ResultData.from("S-1", "싫어요 취소 됨"); }
	 */

	public boolean isAlreadyAddGoodRp(int memberId, int academyId, int themeId) {
		int getPointTypeCodeByMemberId = scrapRepository.getSumReactionPoint(memberId, academyId, themeId);

		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}

		return false;
	}



	public ResultData usersScrap(int loginedMemberId, int academyId, int themeId) {


			if (loginedMemberId == 0) {
				return ResultData.from("F-L", "로그인 하고 써야해");
			}

			int sumScrapByMemberId = scrapRepository.getSumScrapCount(loginedMemberId, academyId, themeId);

			if (sumScrapByMemberId != 0) {
				return ResultData.from("F-1", "찜 불가능", "sumScrapByMemberId", sumScrapByMemberId);
			}

			return ResultData.from("S-1", "찜 가능", "sumScrapByMemberId", sumScrapByMemberId);
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
