package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Conference;


@Mapper
public interface ConferenceRepository {

	@Insert("""
			INSERT INTO `academy` SET
			         categoryId = #{categoryId},
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