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
			         imageURL = #{imageURL},
			         regDate = NOW()
			""")
	public void insertConference(Conference conference);

	
	@Select("""
			<script>
			SELECT *
			FROM `academy`;
			</script>
			""")
	public List<Conference> getShopsList();


	
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE id = #{id};
			</script>
			""")
	public Conference getEventById(int id);

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId};
			</script>
			""")
	public List<Conference> getConferencesByCategory(int categoryId);


	
}