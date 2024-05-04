package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.CompetitionService;
import com.example.demo.service.ConferenceService;
import com.example.demo.service.ScrapService;
import com.example.demo.vo.Competition;
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

	@Autowired
	private CompetitionService CompetitionService;

	@RequestMapping("/usr/scrap/doGoodReaction")
    @ResponseBody
    public ResultData doGoodReaction(int themeId, int academyId, String replaceUri) {

        ResultData usersReactionRd = scrapService.usersReaction(rq.getLoginedMemberId(), themeId, academyId);
        int usersReaction = (int) usersReactionRd.getData1();

        System.err.println("usersReaction : " + usersReaction);
        System.err.println("rq.getLoginedMemberId() : " + rq.getLoginedMemberId());
        System.err.println("themeId : " + themeId);
        System.err.println("academyId : " + academyId);

        int goodRP; // 메서드 전체에서 사용될 goodRP를 여기서 선언합니다

        if (usersReaction == 1) {
            ResultData rd = scrapService.deleteGoodReactionPoint(rq.getLoginedMemberId(), themeId, academyId);
            if (themeId == 1) {
                goodRP = ConferenceService.getGoodRP(themeId, academyId);
            } else {
                goodRP = CompetitionService.getGoodRP(themeId, academyId);
            }
            return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP);
        }

        ResultData reactionRd = scrapService.addGoodReactionPoint(rq.getLoginedMemberId(), themeId, academyId);

        if (reactionRd.isFail()) {
            return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
        }

        if (themeId == 1) {
            goodRP = ConferenceService.getGoodRP(themeId, academyId);
        } else {
            goodRP = CompetitionService.getGoodRP(themeId, academyId);
        }

        return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP);
    }


}
