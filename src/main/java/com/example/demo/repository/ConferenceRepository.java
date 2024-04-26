package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Conference;

@Mapper
public interface ConferenceRepository {

	@Insert("""
			INSERT INTO `academy` SET
			         id = #{id},
			         title = #{title},
			         hitCount = #{hitCount},
			         eventPeriod = #{eventPeriod},
			         applicationPeriod = #{applicationPeriod},
			         entryFee = #{entryFee},
			         place = #{place},
			         homepage = #{homepage},
			         imageURL = #{imageURL}
			        
			""")
	public void insertConference(Conference conference);


	
}