package com.example.demo.repository;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface ScrapRepository {
	
	//특정 아카데미, 테마 및 회원에 대한 반응 포인트의 합계를 조회합니다.
	@Select("""
			SELECT IFNULL(SUM(point),0)
			FROM scrap
			WHERE academyId = #{academyId}
			AND memberId = #{loginedMemberId}
			AND themeId = #{themeId}
			""")
	public int getSumReactionPoint(int loginedMemberId, int themeId, int academyId);

	
	//특정 아카데미, 테마 및 회원에 대해 긍정적인 반응 포인트를 추가합니다.
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

	
//특정 아카데미, 테마 및 회원에 대한 반응 포인트를 삭제합니다.
	@Delete("""
			DELETE FROM scrap
			WHERE memberId = #{memberId}
			AND academyId = #{academyId}
			AND themeId = #{themeId}
			""")
	public void deleteReactionPoint(int memberId, int themeId,  int academyId );

	
	//특정 아카데미, 테마 및 회원에 대한 스크랩 수의 합계를 조회합니다.
	@Select("""
			SELECT IFNULL(SUM(S.point),0)
			FROM scrap AS S
			WHERE S.Id = #{id}
			AND S.memberId =#{loginedMemberId}
			AND S.themeId =#{themeId}
			""")
	public int getSumScrapCount(int loginedMemberId, int id, int themeId);

	
	

}