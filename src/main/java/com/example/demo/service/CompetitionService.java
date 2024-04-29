package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.example.demo.controller.competitionInfoCrawler;
import com.example.demo.repository.CompetitionRepository;
import com.example.demo.vo.Competition;

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

	public List<Competition> getCompetitionsList() {
		
		return competitionRepository. getCompetitionsList();
	}
}
