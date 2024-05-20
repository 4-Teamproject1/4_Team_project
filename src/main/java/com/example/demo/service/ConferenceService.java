package com.example.demo.service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.controller.ConferenceInfoCrawler;
import com.example.demo.repository.CompetitionRepository;
import com.example.demo.repository.ConferenceRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Conference;
import com.example.demo.vo.ResultData;

@Service
public class ConferenceService {

    @Autowired
    private ConferenceRepository conferenceRepository;

    @Autowired
    private CompetitionRepository competitionRepository;

    @Autowired
    private ConferenceInfoCrawler crawler;

    public ConferenceService(ConferenceRepository conferenceRepository) {
        this.conferenceRepository = conferenceRepository;
    }

    // 학회 정보를 크롤링하고 저장하는 메서드
    public List<Conference> crawlAndSaveConferences() {
        // 크롤러를 사용하여 학회 데이터를 가져오기
        List<Conference> conferences = crawler.crawlConference();

        // 각 학회를 데이터베이스에 저장
        for (Conference conference : conferences) {
            System.err.println(conference);
            conferenceRepository.insertConference(conference);
            System.err.println(conference);
        }

        return conferences;
    }

    // 검색과 페이징을 포함한 학회 목록 가져오기
    public List<Conference> getShopsList(int categoryId, String searchKeyword, int offset, int limit) {
        return conferenceRepository.getShopsList(categoryId, searchKeyword, offset, limit);
    }

    // 검색 조건에 맞는 총 학회 수 구하기
    public int countConferences(int categoryId, String searchKeyword) {
        return conferenceRepository.countConferences(categoryId, searchKeyword);
    }

    // ID로 학회 정보 가져오기
    public Conference getEventById(int id) {
        return conferenceRepository.getEventById(id);
    }

    // 카테고리별 학회 목록 가져오기
    public List<Conference> getConferencesByCategory(int categoryId) {
        return conferenceRepository.getConferencesByCategory(categoryId);
    }

    // 등록/수정일 순으로 학회 목록 가져오기
    public List<Conference> getConferencesOrderByRegDate() {
        return conferenceRepository.getConferencesOrderByRegDate();
    }

    // 카테고리별 등록/수정일 순으로 학회 목록 가져오기
    public List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId) {
        return conferenceRepository.getConferencesByCategoryOrderByRegDate(categoryId);
    }

    // 조회수 순으로 학회 목록 가져오기
    public List<Conference> getConferencesOrderByhitCount() {
        return conferenceRepository.getConferencesOrderByhitCount();
    }

    // 카테고리별 조회수 순으로 학회 목록 가져오기
    public List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId) {
        return conferenceRepository.getConferencesByCategoryOrderByhitCount(categoryId);
    }

    // 마감일 순으로 학회 목록 가져오기
    public List<Conference> getConferencesOrderByfinDate() {
        return conferenceRepository.getConferencesOrderByfinDate();
    }

    // 카테고리별 마감일 순으로 학회 목록 가져오기
    public List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId) {
        return conferenceRepository.getConferencesByCategoryOrderByfinDate(categoryId);
    }

    // 제목 순으로 학회 목록 가져오기
    public List<Conference> getConferencesOrderBytitle() {
        return conferenceRepository.getConferencesOrderBytitle();
    }

    // 카테고리별 제목 순으로 학회 목록 가져오기
    public List<Conference> getConferencesByCategoryOrderBytitle(int categoryId) {
        return conferenceRepository.getConferencesByCategoryOrderBytitle(categoryId);
    }

    // 주소에서 '시' 추출하는 메서드
    public String extractCityFromAddress(String address) {
        // 주소가 null이거나 공백일 경우 빈 문자열 반환
        if (address == null || address.trim().isEmpty()) {
            return "";
        }

        // '시'로 끝나는 단어만 추출
        Pattern pattern = Pattern.compile("[^\\s]+시");
        Matcher matcher = pattern.matcher(address);

        if (matcher.find()) {
            return matcher.group(0); // 첫 번째 매칭되는 '시'로 끝나는 문자열 반환
        }

        return ""; // 매칭되는 주소 구성 요소가 없을 경우 빈 문자열 반환
    }

    // 수정된 주소 형식으로 학회 목록 가져오기
    public List<Conference> getShopsList2() {
        // 데이터베이스에서 원래의 학회 목록 가져오기
        List<Conference> conferences = conferenceRepository.getShopsList2();

        // 각 학회의 주소를 수정하여 '시' 또는 '도'만 포함하도록 설정
        conferences.forEach(conference -> {
            String extractedCity = extractCityFromAddress(conference.getAddress());
            conference.setAddress(extractedCity);
        });

        return conferences;
    }

    // 좋아요 반응 점수 증가
    public ResultData increaseGoodReactionPoint(int academyId, int themeId) {
        int affectedRow = 0;

        if (themeId == 1) {
            affectedRow = conferenceRepository.increaseGoodReactionPoint(academyId, themeId);
        } else {
            affectedRow = competitionRepository.increaseGoodReactionPoint(academyId, themeId);
        }

        if (affectedRow == 0) {
            return ResultData.from("F-1", "없는 게시물");
        }

        return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
    }

    // 좋아요 반응 점수 감소
    public ResultData decreaseGoodReactionPoint(int themeId, int academyId) {
        int affectedRow = 0;

        if (themeId == 1) {
            affectedRow = conferenceRepository.decreaseGoodReactionPoint(themeId, academyId);
        } else {
            affectedRow = competitionRepository.increaseGoodReactionPoint(academyId, themeId);
        }

        if (affectedRow == 0) {
            return ResultData.from("F-1", "없는 게시물");
        }

        return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
    }

    // 좋아요 반응 점수 가져오기
    public int getGoodRP(int themeId, int academyId) {
        System.err.println(themeId);
        System.err.println(academyId);
        return conferenceRepository.getGoodRP(themeId, academyId);
    }

    // 사용자 스크랩 학회 목록 가져오기
    public List<Conference> getscrapShopsList(int memberId) {
        return conferenceRepository.getscrapShopsList(memberId);
    }

    // 학회 삭제를 위한 학회 정보 가져오기
    public Conference getConferenceId(int id) {
        return conferenceRepository.getConferenceId(id);
    }

    // 사용자가 학회를 삭제할 수 있는지 확인
    public ResultData userCanDelete(int loginedMemberId, Conference conference) {
        System.err.println(loginedMemberId);
        System.err.println(conference.getAmemberId());

        if (conference.getAmemberId() != loginedMemberId) {
            return ResultData.from("F-2", Ut.f("%d번 학회행사에 대한 삭제 권한이 없습니다", conference.getId()));
        }

        return ResultData.from("S-1", Ut.f("%d번 학회행사가 삭제 되었습니다", conference.getId()));
    }

    // 학회 삭제
    public ResultData deleteConference(int id) {
        conferenceRepository.deleteConference(id);
        return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));
    }

    // 조회수 증가
    public ResultData increaseHitCount(int id) {
        System.err.println(id);
        int affectedRow = conferenceRepository.increaseHitCount(id);

        if (affectedRow == 0) {
            return ResultData.from("F-1", "해당 게시물 없음", "id", id);
        }

        return ResultData.from("S-1", "해당 게시물 조회수 증가", "id", id);
    }

    // 학회의 조회수 가져오기
    public Object getConferenceHitCount(int id) {
        return conferenceRepository.getConferenceHitCount(id);
    }
}
