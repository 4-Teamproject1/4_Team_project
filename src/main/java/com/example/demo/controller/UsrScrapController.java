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
    private ConferenceService conferenceService;

    @Autowired
    private CompetitionService competitionService;

    @RequestMapping("/usr/scrap/doGoodReaction")
    @ResponseBody
    // 사용자의 좋아요 반응을 처리하는 메서드
    public ResultData doGoodReaction(int themeId, int academyId, String replaceUri) {

        // 사용자의 좋아요 반응 여부를 확인하고 결과를 받아옴
        ResultData usersReactionRd = scrapService.usersReaction(rq.getLoginedMemberId(), themeId, academyId);
        int usersReaction = (int) usersReactionRd.getData1();

        // 로그 출력
        System.err.println("usersReaction : " + usersReaction);
        System.err.println("rq.getLoginedMemberId() : " + rq.getLoginedMemberId());
        System.err.println("themeId : " + themeId);
        System.err.println("academyId : " + academyId);

        int goodRP; // 메서드 전체에서 사용될 goodRP를 여기서 선언합니다

        // 사용자가 이미 좋아요를 누른 경우
        if (usersReaction == 1) {
            // 좋아요 취소 처리 후 결과를 받아옴
            ResultData rd = scrapService.deleteGoodReactionPoint(rq.getLoginedMemberId(), themeId, academyId);
            // 해당 테마의 좋아요 수를 받아옴
            if (themeId == 1) {
                goodRP = conferenceService.getGoodRP(themeId, academyId);
            } else {
                goodRP = competitionService.getGoodRP(themeId, academyId);
            }
            // 결과 반환
            return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP);
        }

        // 사용자가 좋아요를 누르지 않은 경우
        // 좋아요 처리 후 결과를 받아옴
        ResultData reactionRd = scrapService.addGoodReactionPoint(rq.getLoginedMemberId(), themeId, academyId);

        // 좋아요 처리 결과가 실패인 경우
        if (reactionRd.isFail()) {
            // 실패 결과 반환
            return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
        }

        // 해당 테마의 좋아요 수를 받아옴
        if (themeId == 1) {
            goodRP = conferenceService.getGoodRP(themeId, academyId);
        } else {
            goodRP = competitionService.getGoodRP(themeId, academyId);
        }

        // 결과 반환
        return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP);
    }
}
