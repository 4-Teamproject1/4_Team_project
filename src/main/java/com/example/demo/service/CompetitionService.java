package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.controller.competitionInfoCrawler;
import com.example.demo.repository.CompetitionRepository;
import com.example.demo.util.Ut;
import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;
import com.example.demo.vo.ResultData;

@Service
public class CompetitionService {

	@Autowired
	private CompetitionRepository competitionRepository;
	/*
	 * @Autowired private ConferenceInfoCrawler4 crawler;
	 */

	@Autowired
	private competitionInfoCrawler crawler;

	public CompetitionService(CompetitionRepository competitionRepository) {
		this.competitionRepository = competitionRepository;
	}

	// 공모전 정보를 크롤링하고 저장합니다.
	public List<Competition> crawlAndSaveCompetitions() {
		competitionInfoCrawler crawler = new competitionInfoCrawler();
		// 크롤러를 호출하여 학회 데이터를 가져옵니다.
		List<Competition> competitions = crawler.crawlCompetition();

		// 가져온 공모전 데이터를 데이터베이스에 저장합니다.
		for (Competition competition : competitions) {

			competitionRepository.insertCompetition(competition);
			System.err.println(competition);
		}

		return competitions;
	}

	// ID를 통해 특정 공모전 정보를 조회합니다.
	public Competition getEventById(int id) {

		return competitionRepository.getEventById(id);
	}
	
	 // 제목과 신청 기간을 포맷하여 공모전 목록을 조회합니다.
	public List<Competition> getCompetitionsList2() {

		return competitionRepository.getCompetitionsList2();
	}

	// 등록일 기준으로 공모전 목록을 정렬하여 조회합니다.
	public List<Competition> getCompetitionsByCategoryOrderByRegDate() {

		return competitionRepository.getCompetitionsByCategoryOrderByRegDate();
	}

	// 조회수 기준으로 공모전 목록을 정렬하여 조회합니다.
	public List<Competition> getCompetitionsByCategoryOrderByhitCount() {
		return competitionRepository.getCompetitionsByCategoryOrderByhitCount();
	}

	// 마감일 기준으로 공모전 목록을 정렬하여 조회합니다.
	public List<Competition> getCompetitionsByCategoryOrderByfinDate() {
		return competitionRepository.getCompetitionsByCategoryOrderByfinDate();
	}

	// 제목 기준으로 공모전 목록을 정렬하여 조회합니다.
	public List<Competition> getCompetitionsByCategoryOrderBytitle() {
		return competitionRepository.getCompetitionsByCategoryOrderBytitle();
	}

	// 검색 키워드, 오프셋, 제한 값을 기준으로 공모전 목록을 조회합니다.
	public List<Competition> getCompetitionsList(String searchKeyword, int offset, int limit) {
		return competitionRepository.getCompetitionsList(searchKeyword, offset, limit);
	}

	// 좋아요 점수를 증가시켜 즐겨찾기를 실행합니다.
	public ResultData increaseGoodReactionPoint(int academyId, int themeId) {
		int affectedRow = competitionRepository.increaseGoodReactionPoint(academyId, themeId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);

	}

	// 좋아요 점수를 감소시켜 즐겨찾기를 취소합니다.
	public ResultData decreaseGoodReactionPoint(int themeId, int academyId) {
		int affectedRow = competitionRepository.decreaseGoodReactionPoint(themeId, academyId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
	}

	// 좋아요 점수를 조회합니다.
	public int getGoodRP(int themeId, int academyId) {
		// TODO Auto-generated method stub
		return competitionRepository.getGoodRP(themeId, academyId);
	}

	public List<Competition> getscrapShopsList(int memberId) {
		return competitionRepository.getscrapShopsList(memberId);
	}

	// 스크랩된 공모전 목록을 조회합니다.
	public int countConferences(String searchKeyword) {

		return competitionRepository.countConferences(searchKeyword);
	}

	// 특정 검색 키워드를 포함하는 공모전의 수를 조회합니다.
	public int countCompetitons(String searchKeyword) {
		return competitionRepository.countCompetitons(searchKeyword);
	}

	// 조회수를 증가시킵니다.
	public ResultData increaseHitCount(int id) {
		System.err.println(id);
		int affectedRow = competitionRepository.increaseHitCount(id);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "해당 게시물 없음", "id", id);
		}

		return ResultData.from("S-1", "해당 게시물 조회수 증가", "id", id);

	}

	// 특정 공모전의 조회수를 반환합니다.
	public Object getCompetitionHitCount(int id) {
		return competitionRepository.getCompetitionHitCount(id);
	}

	// 특정 ID의 공모전 정보를 데이터베이스에서 조회합니다.
	public Competition getcompetitionId(int id) {

		return competitionRepository.getcompetitionId(id);
	}

	// 로그인한 사용자가 특정 공모전을 삭제할 수 있는지 확인하는 메서드입니다.
	// 사용자가 공모전을 생성한 멤버가 아닐 경우 삭제 권한이 없다는 결과를 반환합니다.
	public ResultData userCanDelete(int loginedMemberId, Competition competition) {
		System.err.println(loginedMemberId);
		System.err.println(competition.getCmemberId());
		if (competition.getCmemberId() != loginedMemberId) {
			// 사용자 ID와 공모전의 생성자 ID가 일치하지 않을 경우, 삭제 권한 없음을 알림
			return ResultData.from("F-2", Ut.f("%d번 공모전에 대한 삭제 권한이 없습니다", competition.getId()));
		}
		// 삭제 권한이 있을 경우, 삭제 가능 메시지와 함께 성공 결과를 반환
		return ResultData.from("S-1", Ut.f("%d번 공모전이 삭제 되었습니다", competition.getId()));
	}

	// 공모전 삭제 기능을 수행합니다.
	public ResultData deleteConference(int id) {
		competitionRepository.deleteCompetition(id);
		return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));

	}

}
