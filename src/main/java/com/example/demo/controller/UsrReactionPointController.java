package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.service.ReactionPointService;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrReactionPointController {

    @Autowired
    private Rq rq;

    @Autowired
    private ArticleService articleService;

    @Autowired
    private ReactionPointService reactionPointService;

    @RequestMapping("/usr/reactionPoint/doGoodReaction")
    @ResponseBody
    // 좋아요 반응을 처리하는 메서드
    public ResultData doGoodReaction(String relTypeCode, int relId, String replaceUri) {

        // 사용자의 반응 정보 조회
        ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);

        int usersReaction = (int) usersReactionRd.getData1();

        // 사용자의 반응에 따라 처리
        if (usersReaction == 1) {
            // 이미 좋아요를 누른 경우, 좋아요 취소
            ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            int goodRP = articleService.getGoodRP(relId);
            int badRP = articleService.getBadRP(relId);
            return ResultData.from("S-1", "좋아요 취소", "goodRP", goodRP, "badRP", badRP);
        } else if (usersReaction == -1) {
            // 싫어요를 누른 경우, 싫어요 취소 후 좋아요 추가
            ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            rd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            int goodRP = articleService.getGoodRP(relId);
            int badRP = articleService.getBadRP(relId);

            return ResultData.from("S-2", "싫어요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
        }

        // 사용자가 반응을 누르지 않은 경우, 좋아요 추가
        ResultData reactionRd = reactionPointService.addGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

        if (reactionRd.isFail()) {
            return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
        }

        int goodRP = articleService.getGoodRP(relId);
        int badRP = articleService.getBadRP(relId);

        return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP, "badRP", badRP);
    }

    @RequestMapping("/usr/reactionPoint/doBadReaction")
    @ResponseBody
    // 싫어요 반응을 처리하는 메서드
    public ResultData doBadReaction(String relTypeCode, int relId, String replaceUri) {

        // 사용자의 반응 정보 조회
        ResultData usersReactionRd = reactionPointService.usersReaction(rq.getLoginedMemberId(), relTypeCode, relId);

        int usersReaction = (int) usersReactionRd.getData1();

        // 사용자의 반응에 따라 처리
        if (usersReaction == -1) {
            // 이미 싫어요를 누른 경우, 싫어요 취소
            ResultData rd = reactionPointService.deleteBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            int goodRP = articleService.getGoodRP(relId);
            int badRP = articleService.getBadRP(relId);

            return ResultData.from("S-1", "싫어요 취소", "goodRP", goodRP, "badRP", badRP);
        } else if (usersReaction == 1) {
            // 좋아요를 누른 경우, 좋아요 취소 후 싫어요 추가
            ResultData rd = reactionPointService.deleteGoodReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            rd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);
            int goodRP = articleService.getGoodRP(relId);
            int badRP = articleService.getBadRP(relId);

            return ResultData.from("S-2", "좋아요 눌렀잖어", "goodRP", goodRP, "badRP", badRP);
        }

        // 사용자가 반응을 누르지 않은 경우, 싫어요 추가
        ResultData reactionRd = reactionPointService.addBadReactionPoint(rq.getLoginedMemberId(), relTypeCode, relId);

        if (reactionRd.isFail()) {
            return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg());
        }

        int goodRP = articleService.getGoodRP(relId);
        int badRP = articleService.getBadRP(relId);

        return ResultData.from(reactionRd.getResultCode(), reactionRd.getMsg(), "goodRP", goodRP, "badRP", badRP);
    }

}
