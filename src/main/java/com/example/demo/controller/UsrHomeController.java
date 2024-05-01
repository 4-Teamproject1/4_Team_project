package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.demo.service.CompetitionService;
import com.example.demo.service.ConferenceService;
import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;

@Controller
public class UsrHomeController {
	@Autowired
	private ConferenceService conferenceService;
	
	@Autowired
	private CompetitionService competitionService;

	@RequestMapping("/usr/home/main")
	public String showMain( Model model) {
		List<Conference> conferences = conferenceService.getShopsList2();
		List<Competition> competitions = competitionService.getCompetitionsList2();
		
		model.addAttribute("conferences", conferences);
		model.addAttribute("competitions", competitions);
		return "/usr/home/main";
	}
	
	@RequestMapping("/")
	public String showRoot() {

		return "redirect:/usr/home/main";
	}
}
