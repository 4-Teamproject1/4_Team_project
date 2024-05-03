package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.ConferenceService;
import com.example.demo.service.ScrapService;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrScrapController {

	@Autowired
	private Rq rq;



	@Autowired
	private ScrapService scrapService;
	
	@Autowired
	private ConferenceService ConferenceService;

	@RequestMapping("/usr/scrap/doGoodReaction")
	@ResponseBody
	public ResultData doGoodReaction( int academyId, String replaceUri) {

		ResultData usersReactionRd = scrapService.usersReaction(rq.getLoginedMemberId(), academyId);

		int usersReaction = (int) usersReactionRd.getData1();

		if (usersReaction == 1) {
			ResultData rd = scrapService.deleteGoodReactionPoint(rq.getLoginedMemberId(), academyId);
			int goodRP = ConferenceService.getGoodRP(academyId);
			/* int badRP = articleService.getBadRP(relId); */
			return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP);
		} /*
			 * else if (usersReaction == -1) { ResultData rd =
			 * reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relId);
			 * rd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(),
			 * relId); int goodRP = articleService.getGoodRP(relId); int badRP =
			 * articleService.getBadRP(relId);
			 * 
			 * return ResultData.from("S-2", "싫어요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
			 * }
			 */
		ResultData reactionRd = scrapService.addGoodReactionPoint(rq.getLoginedMemberId(), academyId);

		if (reactionRd.isFail()) {
			return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
		}

		int goodRP = ConferenceService.getGoodRP(academyId);
//		int badRP = articleService.getBadRP(relId);

		return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP);
	}

	/*
	 * @RequestMapping("/usr/reactionPoint/doBadReaction")
	 * 
	 * @ResponseBody public ResultData doBadReaction(String relTypeCode, int relId,
	 * String replaceUri) {
	 * 
	 * ResultData usersReactionRd =
	 * reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode,
	 * relId);
	 * 
	 * int usersReaction = (int) usersReactionRd.getData1();
	 * 
	 * if (usersReaction == -1) { ResultData rd =
	 * reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(),
	 * relTypeCode, relId); int goodRP = articleService.getGoodRP(relId); int badRP
	 * = articleService.getBadRP(relId);
	 * 
	 * return ResultData.from("S-1", "싫어요 취소", "goodRP", goodRP, "badRP", badRP); }
	 * else if (usersReaction == 1) { ResultData rd =
	 * reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(),
	 * relTypeCode, relId); rd =
	 * reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(),
	 * relTypeCode, relId); int goodRP = articleService.getGoodRP(relId); int badRP
	 * = articleService.getBadRP(relId);
	 * 
	 * return ResultData.from("S-2", "좋아요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
	 * }
	 * 
	 * ResultData reactionRd =
	 * reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(),
	 * relTypeCode, relId);
	 * 
	 * if (reactionRd.isFail()) { return ResultData.from(reactionRd.getResultCode(),
	 * reactionRd.getMsg()); }
	 * 
	 * int goodRP = articleService.getGoodRP(relId); int badRP =
	 * articleService.getBadRP(relId);
	 * 
	 * return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(),
	 * "goodRP", goodRP, "badRP", badRP); }
	 */

}
