package com.example.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ScrapRepository {

	@Select("""
			SELECT IFNULL(SUM(point),0)
			FROM scrap
			WHERE academyId = #{academyId}
			AND memberId = #{loginedMemberId}
			AND themeId = #{themeId}
			""")
	public int getSumReactionPoint(int loginedMemberId, int themeId, int academyId);

	@Insert("""
			INSERT INTO scrap
			SET regDate = NOW(),
			updateDate = NOW(),
			academyId = #{academyId},
			memberId = #{memberId},
			themeId = #{themeId},
			`point` = 1
			""")
	public int addGoodReactionPoint(int memberId, int themeId, int academyId);

	/*
	 * @Insert(""" INSERT INTO scrap SET regDate = NOW(), updateDate = NOW(), relId
	 * = #{relId}, memberId = #{memberId}, `point` = -1 """) public int
	 * addBadReactionPoint(int memberId, String relTypeCode, int relId);
	 */

	@Delete("""
			DELETE FROM scrap
			WHERE memberId = #{memberId}
			AND academyId = #{academyId}
			AND themeId = #{themeId}
			""")
	public void deleteReactionPoint(int memberId, int themeId,  int academyId );

	
	
	@Select("""
			SELECT IFNULL(SUM(S.point),0)
			FROM scrap AS S
			WHERE S.Id = #{id}
			AND S.memberId =#{loginedMemberId}
			AND S.themeId =#{themeId}
			""")
	public int getSumScrapCount(int loginedMemberId, int id, int themeId);

	
	

}