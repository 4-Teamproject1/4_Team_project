package com.example.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ScrapRepository {

	@Select("""
			SELECT IFNULL(SUM(S.point),0)
			FROM scrap AS S
			WHERE S.academyId = #{relId}
			AND S.memberId = #{memberId}
			""")
	public int getSumReactionPoint(int memberId, int relId);

	@Insert("""
			INSERT INTO scrap
			SET regDate = NOW(),
			updateDate = NOW(),
			academyId = #{relId},
			memberId = #{memberId},
			`point` = 1
			""")
	public int addGoodReactionPoint(int memberId, int relId);

	/*
	 * @Insert(""" INSERT INTO scrap SET regDate = NOW(), updateDate = NOW(), relId
	 * = #{relId}, memberId = #{memberId}, `point` = -1 """) public int
	 * addBadReactionPoint(int memberId, String relTypeCode, int relId);
	 */

	@Delete("""
			DELETE FROM scrap
			WHERE memberId = #{memberId}
			AND academyId = #{relId}
			""")
	public void deleteReactionPoint(int memberId, int relId);

	
	
	@Select("""
			SELECT IFNULL(SUM(S.point),0)
			FROM scrap AS S
			WHERE S.Id = #{id}
			AND S.memberId =#{loginedMemberId}
			""")
	public int getSumScrapCount(int loginedMemberId, int id);

	
	

}
