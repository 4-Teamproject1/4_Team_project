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
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;

@Service
public class ConferenceService {

	@Autowired
	private ConferenceRepository conferenceRepository;
	/*
	 * @Autowired private ConferenceInfoCrawler4 crawler;
	 */

	@Autowired
	private CompetitionRepository competitionRepository;

	@Autowired
	private ConferenceInfoCrawler crawler;

	public ConferenceService(ConferenceRepository conferenceRepository) {
		this.conferenceRepository = conferenceRepository;
	}

	public List<Conference> crawlAndSaveConferences() {
		ConferenceInfoCrawler crawler = new ConferenceInfoCrawler();
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

	public List<Conference> getShopsList(int categoryId, String searchKeyword, int offset, int limit) {
		return conferenceRepository.getShopsList(categoryId, searchKeyword, offset, limit);
	}

	public int countConferences(int categoryId, String searchKeyword) {
		return conferenceRepository.countConferences(categoryId, searchKeyword);
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

	/*
	 * // extractCityFromAddress 메서드 public String extractCityFromAddress(String
	 * address) { // 주소를 공백을 기준으로 분할하여 배열로 만듭니다. String[] parts =
	 * address.split("\\s+"); // 주소의 마지막 단어를 가져옵니다. String lastWord =
	 * parts[parts.length - 1]; // 시로 끝나는 단어인지 확인합니다. if (lastWord.endsWith("시")) {
	 * return lastWord; } else { // 시로 끝나지 않는 경우 null 또는 원하는 기본값을 반환할 수 있습니다. return
	 * null; } }
	 */

	public String extractCityFromAddress(String address) {
		// 주소가 null이거나 공백일 경우 빈 문자열을 반환
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

	public List<Conference> getShopsList2() {
		// 데이터베이스에서 원래의 회의 목록을 가져옵니다.
		List<Conference> conferences = conferenceRepository.getShopsList2();

		// 각 회의의 주소를 수정하여 '시' 또는 '도'만 포함하도록 합니다.
		conferences.forEach(conference -> {
			String extractedCity = extractCityFromAddress(conference.getAddress());
			conference.setAddress(extractedCity);
		});

		return conferences;
	}

	public ResultData increaseGoodReactionPoint(int academyId, int themeId) {
		int affectedRow = 0; // Declare affectedRow here to make it accessible throughout the method

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

	public ResultData decreaseGoodReactionPoint(int themeId, int academyId) {

		int affectedRow = 0; // Declare affectedRow here to make it accessible throughout the method

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

	public int getGoodRP(int themeId, int academyId) {
		System.err.println(themeId);
		System.err.println(academyId);
		return conferenceRepository.getGoodRP(themeId, academyId);
	}

	public List<Conference> getscrapShopsList(int memberId) {

		return conferenceRepository.getscrapShopsList(memberId);
	}

	// 학회삭제
	public Conference getConferenceId(int id) {

		return conferenceRepository.getConferenceId(id);
	}

	public ResultData userCanDelete(int loginedMemberId, Conference conference) {
		System.err.println(loginedMemberId);
		System.err.println(conference.getAmemberId());
		if (conference.getAmemberId() != loginedMemberId) {
			return ResultData.from("F-2", Ut.f("%d번 학회행사에 대한 삭제 권한이 없습니다", conference.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 학회행사가 삭제 되었습니다", conference.getId()));
	}

	public ResultData deleteConference(int id) {
		conferenceRepository.deleteConference(id);
		return ResultData.from("S-1", Ut.f("%d번 삭제했습니다", id));
		
	}

	public ResultData increaseHitCount(int id) {
		System.err.println(id);
		int affectedRow = conferenceRepository.increaseHitCount(id);

		if (affectedRow == 0) {
			return ResultData.from("F-1", "해당 게시물 없음", "id", id);
		}

		return ResultData.from("S-1", "해당 게시물 조회수 증가", "id", id);

	}
	public Object getConferenceHitCount(int id) {
		return conferenceRepository. getConferenceHitCount(id);
	}
}