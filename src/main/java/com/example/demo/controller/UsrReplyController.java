package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReactionPointService;
import com.example.demo.service.ReplyService;
import com.example.demo.util.Ut;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class UsrReplyController {

    @Autowired
    private Rq rq;

    @Autowired
    private ReplyService replyService;

    @Autowired
    private ReactionPointService reactionPointService;

    @RequestMapping("/usr/reply/doWrite")
    @ResponseBody
    // 댓글을 작성하는 메서드
    public String doWrite(HttpServletRequest req, String relTypeCode, int relId, String body) {

        // 요청 객체에서 Rq 객체를 받아옴
        Rq rq = (Rq) req.getAttribute("rq");

        // 입력값 유효성 검사
        if (Ut.isNullOrEmpty(relTypeCode)) {
            return Ut.jsHistoryBack("F-1", "relTypeCode을 입력해주세요");
        }
        if (Ut.isEmpty(relId)) {
            return Ut.jsHistoryBack("F-2", "relId을 입력해주세요");
        }
        if (Ut.isNullOrEmpty(body)) {
            return Ut.jsHistoryBack("F-3", "내용을 입력해주세요");
        }

        // 댓글 작성 요청 처리 후 결과를 받아옴
        ResultData<Integer> writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);

        // 작성된 댓글의 ID를 받아옴
        int id = (int) writeReplyRd.getData1();

        // 결과 반환
        return Ut.jsReplace(writeReplyRd.getResultCode(), writeReplyRd.getMsg(), "../article/detail?id=" + relId);
    }

    @RequestMapping("/usr/reply/doDelete")
    @ResponseBody
    // 댓글을 삭제하는 메서드
    public String doDelete(HttpServletRequest req, int id, String replaceUri) {
        // 요청 객체에서 Rq 객체를 받아옴
        Rq rq = (Rq) req.getAttribute("rq");

        // 해당 ID의 댓글을 가져옴
        Reply reply = replyService.getReply(id);

        // 댓글이 존재하지 않는 경우
        if (reply == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
        }

        // 현재 사용자가 해당 댓글을 삭제할 수 있는지 확인
        ResultData loginedMemberCanDeleteRd = replyService.userCanDelete(rq.getLoginedMemberId(), reply);

        // 현재 사용자가 댓글을 삭제할 수 있는 경우
        if (loginedMemberCanDeleteRd.isSuccess()) {
            replyService.deleteReply(id);
        }

        // replaceUri가 비어있는 경우
        if (Ut.isNullOrEmpty(replaceUri)) {
            // 댓글이 속한 게시물로 돌아감
            switch (reply.getRelTypeCode()) {
                case "article":
                    replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
                    break;
            }
        }

        // 결과 반환
        return Ut.jsReplace(loginedMemberCanDeleteRd.getResultCode(), loginedMemberCanDeleteRd.getMsg(), replaceUri);
    }

    @RequestMapping("/usr/reply/doModify")
    @ResponseBody
    // 댓글을 수정하는 메서드
    public String doModify(HttpServletRequest req, int id, String body) {
        // 로그 출력
        System.err.println(id);
        System.err.println(body);
        // 요청 객체에서 Rq 객체를 받아옴
        Rq rq = (Rq) req.getAttribute("rq");

        // 해당 ID의 댓글을 가져옴
        Reply reply = replyService.getReply(id);

        // 댓글이 존재하지 않는 경우
        if (reply == null) {
            return Ut.jsHistoryBack("F-1", Ut.f("%d번 댓글은 존재하지 않습니다", id));
        }

        // 현재 사용자가 해당 댓글을 수정할 수 있는지 확인
        ResultData loginedMemberCanModifyRd = replyService.userCanModify(rq.getLoginedMemberId(), reply);

        // 현재 사용자가 댓글을 수정할 수 있는 경우
        if (loginedMemberCanModifyRd.isSuccess()) {
            // 댓글 수정 처리
            replyService.modifyReply(id, body);
        }

        // 수정된 댓글 정보를 다시 받아옴
        reply = replyService.getReply(id);

        // 수정된 댓글 내용을 반환
        return reply.getBody();
    }
}
