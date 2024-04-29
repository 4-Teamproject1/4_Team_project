package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Competition;


@Mapper
public interface CompetitionRepository {



	
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			WHERE id = #{id};
			</script>
			""")
	public Competition getEventById(int id);

	
	
	
	@Insert("""
			INSERT INTO `competition` SET
			         title = #{title},
			         totalPrizeMoney = #{totalPrizeMoney},
			         firstPrizeMoney = #{firstPrizeMoney},
			         applicationPeriod = #{applicationPeriod},
			         homepage = #{homepage},
			         imageURL = #{imageURL},
			         contactNum = #{contactNum},
			         contactEmail = #{contactEmail},
			         regDate = NOW()
			""")
	public void insertCompetition(Competition competition);



	@Select("""
			<script>
			SELECT *
			FROM `competition`;
			</script>
			""")
	public List<Competition> getCompetitionsList();


	


	
}