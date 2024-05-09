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

	public List<Competition> crawlAndSaveCompetitions() {
		competitionInfoCrawler crawler = new competitionInfoCrawler();
		// 크롤러를 호출하여 학회 데이터를 가져옵니다.
		List<Competition> competitions = crawler.crawlCompetition();

		// 각 학회를 데이터베이스에 저장합니다.
		for (Competition competition : competitions) {

			System.err.println(competition);

			competitionRepository.insertCompetition(competition);
			System.err.println(competition);
		}

		return competitions;
	}

	

	public Competition getEventById(int id) {
		
		return competitionRepository.getEventById(id);
	}

	public List<Competition> getCompetitionsList2() {
		
		return competitionRepository. getCompetitionsList2();
	}

	public List<Competition> getCompetitionsByCategoryOrderByRegDate() {
		
		return competitionRepository.getCompetitionsByCategoryOrderByRegDate();
	}

	public List<Competition> getCompetitionsByCategoryOrderByhitCount() {
		return competitionRepository.getCompetitionsByCategoryOrderByhitCount();
	}

	public List<Competition> getCompetitionsByCategoryOrderByfinDate() {
		return competitionRepository.getCompetitionsByCategoryOrderByfinDate();
	}

	public List<Competition> getCompetitionsByCategoryOrderBytitle() {
		return competitionRepository.getCompetitionsByCategoryOrderBytitle();
	}

	public List<Competition> getCompetitionsList(String searchKeyword,  int offset, int limit) {
		return competitionRepository. getCompetitionsList(searchKeyword, offset, limit);
	}

	public ResultData increaseGoodReactionPoint(int academyId, int themeId) {
		int affectedRow = competitionRepository.increaseGoodReactionPoint(academyId,themeId );

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRow", affectedRow);
		
	}

	public ResultData decreaseGoodReactionPoint(int themeId, int academyId) {
		int affectedRow = competitionRepository.decreaseGoodReactionPoint(themeId, academyId);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "없는 게시물");
		}

		return ResultData.from("S-1", "좋아요 감소", "affectedRow", affectedRow);
	}

	public int getGoodRP(int themeId, int academyId) {
		// TODO Auto-generated method stub
		return competitionRepository.getGoodRP(themeId, academyId);
	}

	public List<Competition> getscrapShopsList(int memberId) {
		return competitionRepository.getscrapShopsList(memberId);
	}

	public int countConferences(String searchKeyword) {
		
		return competitionRepository. countConferences(searchKeyword);
	}

	public int countCompetitons(String searchKeyword) {
		return competitionRepository.countCompetitons(searchKeyword);
	}
	
	// 공모전삭제
	public Competition getcompetitionId(int id) {

		return competitionRepository.getcompetitionId(id);
	}
	
	public ResultData userCanDelete(int loginedMemberId, Competition competition) {
		System.err.println(loginedMemberId);
		System.err.println(competition.getCmemberId());
		if (competition.getCmemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 공모전에 대한 삭제 권한이 없습니다", competition.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 공모전이 삭제 되었습니다", competition.getId()));
	}

	public ResultData deleteConference(int id) {
		competitionRepository.deleteCompetition(id);
		return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));
		
	}
	
}
