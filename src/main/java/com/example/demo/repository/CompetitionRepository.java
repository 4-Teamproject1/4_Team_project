package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;

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
			FROM `competition`
			WHERE 1
			    AND ( title LIKE CONCAT('%', '${searchKeyword}', '%'))
			</script>
			""")
	public List<Competition> getCompetitionsList(String searchKeyword);

	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByRegDate();

	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByhitCount();

	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByfinDate();

	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY title ASC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderBytitle();

	@Select("""
			    <script>
			    SELECT title,
			           CONCAT(
			               DATE_FORMAT(SUBSTRING_INDEX(applicationPeriod, ' ~ ', 1), '%y.%m.%d'),
			               ' ~ ',
			               DATE_FORMAT(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d')
			           ) AS applicationPeriod
			    FROM `competition`;
			    </script>
			""")
	public List<Competition> getCompetitionsList2();

}