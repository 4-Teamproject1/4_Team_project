package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.example.demo.controller.ConferenceInfoCrawler;
import com.example.demo.controller.ConferenceInfoCrawler2;
import com.example.demo.repository.ConferenceRepository;
import com.example.demo.vo.Conference;

public class ConferenceService {
	 private ConferenceRepository conferenceRepository;
	 private ConferenceInfoCrawler crawler;
	  @Autowired
	    public ConferenceService(ConferenceInfoCrawler crawler, ConferenceRepository conferenceRepository) {
	        this.crawler = crawler;
	        this.conferenceRepository = conferenceRepository;
	    }

	public List<Conference> crawlAndSaveConferences() {
		ConferenceInfoCrawler2 crawler = new ConferenceInfoCrawler2();
        // 크롤러를 호출하여 학회 데이터를 가져옵니다.
        List<Conference> conferences = crawler.crawlConference();
        
        // 각 학회를 데이터베이스에 저장합니다.
        for (Conference conference : conferences) {
            conferenceRepository.insertConference(conference);
        }
        
        return conferences;
    }
}
