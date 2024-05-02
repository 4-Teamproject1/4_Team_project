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

	

	public ResultData usersReaction(int loginedMemberId, int academyId) {

		if (loginedMemberId == 0) {
			return ResultData.from("F-L", "로그인 하고 써야해");
		}

		int sumReactionPointByMemberId = scrapRepository.getSumReactionPoint(loginedMemberId,
				academyId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-1", "추천 불가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천 가능", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	public ResultData addGoodReactionPoint(int loginedMemberId, int academyId) {

		int affectedRow = scrapRepository.addGoodReactionPoint(loginedMemberId,  academyId);
		
		System.err.println(affectedRow);
		
		if (affectedRow != 1) {
			return ResultData.from("F-1", "좋아요 실패");
		}


			ConferenceService.increaseGoodReactionPoint(academyId);
	

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
	public ResultData deleteGoodReactionPoint(int loginedMemberId, int academyId) {
		scrapRepository.deleteReactionPoint(loginedMemberId, academyId);

	
		ConferenceService.decreaseGoodReactionPoint(academyId);
		
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

	public boolean isAlreadyAddGoodRp(int memberId, int academyId) {
		int getPointTypeCodeByMemberId = scrapRepository.getSumReactionPoint(memberId, academyId);

		if (getPointTypeCodeByMemberId > 0) {
			return true;
		}

		return false;
	}



	public ResultData usersCafeScrap(int loginedMemberId, int id) {


			if (loginedMemberId == 0) {
				return ResultData.from("F-L", "로그인 하고 써야해");
			}

			int sumScrapByMemberId = scrapRepository.getSumScrapCount(loginedMemberId, id);

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
