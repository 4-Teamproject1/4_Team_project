package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



import com.example.demo.controller.ConferenceInfoCrawler5;
import com.example.demo.repository.ConferenceRepository;
import com.example.demo.vo.Conference;

@Service
public class ConferenceService {

	@Autowired
	private ConferenceRepository conferenceRepository;
	/*
	 * @Autowired private ConferenceInfoCrawler4 crawler;
	 */
	
	@Autowired
	private ConferenceInfoCrawler5 crawler;

	public ConferenceService(ConferenceRepository conferenceRepository) {
		this.conferenceRepository = conferenceRepository;
	}

	public List<Conference> crawlAndSaveConferences() {
		ConferenceInfoCrawler5 crawler = new ConferenceInfoCrawler5();
		// 크롤러를 호출하여 학회 데이터를 가져옵니다.
		List<Conference> conferences = crawler.crawlConference();

		// 각 학회를 데이터베이스에 저장합니다.
		for (Conference conference : conferences) {

			System.err.println(conference);

			conferenceRepository.insertConference(conference);
			System.err.println(conference);
		}

		return conferences;
	}

	public List<Conference> getShopsList() {
		// TODO Auto-generated method stub
		return conferenceRepository.getShopsList();
	}

	public Conference getEventById(int id) {
		
		return conferenceRepository.getEventById(id);
	}

	public List<Conference> getConferencesByCategory(int categoryId) {
		return conferenceRepository.getConferencesByCategory(categoryId);
	}

	public List<Conference> getConferencesOrderByRegDate() {
		
		return conferenceRepository.getConferencesOrderByRegDate();
	}

	public List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId) {
		// TODO Auto-generated method stub
		return conferenceRepository.getConferencesByCategoryOrderByRegDate(categoryId);
	}

	public List<Conference> getConferencesOrderByhitCount() {
		return conferenceRepository.getConferencesOrderByhitCount();
	}

	public List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId) {
		
		return conferenceRepository.getConferencesByCategoryOrderByhitCount(categoryId);
	}

	public List<Conference> getConferencesOrderByfinDate() {
		return conferenceRepository.getConferencesOrderByfinDate();
	}

	public List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId) {
		
		return conferenceRepository.getConferencesByCategoryOrderByfinDate(categoryId);
	}

	public List<Conference> getConferencesOrderBytitle() {
		return conferenceRepository.getConferencesOrderBytitle();
	}

	public List<Conference> getConferencesByCategoryOrderBytitle(int categoryId) {
		return conferenceRepository.getConferencesByCategoryOrderBytitle(categoryId);
	}

	

	
}
