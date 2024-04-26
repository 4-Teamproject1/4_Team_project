package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Conference;

@Mapper
public interface ConferenceRepository {

	@Insert("""
			INSERT INTO service_Conshop SET
			         categoryId = #{categoryId},
			         shopName = #{shopName},
			         roadName = #{roadName},
			         review = #{review},
			         photoUrl1 = #{photoUrl1},
			         photoUrl2 = #{photoUrl2},
			         photoUrl3 = #{photoUrl3},
			         photoUrl4 = #{photoUrl4},
			         photoUrl5 = #{photoUrl5},
			         phoneNum = #{phoneNum},
			         con_availableTime = #{conAvailableTime},
			         operateTime = #{operateTime},
			         menu = #{menu},
			         themeId = #{themeId},
			         regDate = NOW(),
			         updateDate = NOW(),
			         delDate = #{delDate},
			         delStatus = #{delStatus}
			""")
	public void insertShop(Conference ConferenceInfo);


	public void insertConference(Conference conference);
}