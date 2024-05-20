package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Competition;
import com.example.demo.vo.Conference;

@Mapper
public interface CompetitionRepository {

    // 특정 ID의 공모전 정보를 조회합니다.
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			WHERE id = #{id};
			</script>
			""")
	public Competition getEventById(int id);

    // 새로운 공모전을 데이터베이스에 추가합니다.
	@Insert("""
			INSERT INTO `competition` SET
			         title = #{title},
			         themeId = 2,
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

	// 검색 키워드에 따라 공모전 목록을 조회합니다. (페이지네이션 처리 포함)
	@Select("""
		    <script>
		    SELECT * FROM `competition`
		    WHERE title LIKE CONCAT('%', #{searchKeyword}, '%')
		    LIMIT #{limit} OFFSET #{offset}
		    </script>
		""")
	public List<Competition> getCompetitionsList(@Param("searchKeyword") String searchKeyword, @Param("offset") int offset, @Param("limit") int limit);

	// 등록일순으로 공모전 목록을 정렬하여 조회합니다.
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByRegDate();

	 // 조회수순으로 공모전 목록을 정렬하여 조회합니다.
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByhitCount();

	
	// 마감일순으로 공모전 목록을 정렬하여 조회합니다.
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderByfinDate();

	
	 // 제목순으로 공모전 목록을 정렬하여 조회합니다.
	@Select("""
			<script>
			SELECT *
			FROM `competition`
			ORDER BY title ASC
			</script>
			""")
	public List<Competition> getCompetitionsByCategoryOrderBytitle();

	
	 // 지정된 형식으로 공모전의 제목과 신청 기간을 조회합니다.
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


    // 공모전의 좋아요 점수를 1점 증가시킵니다.
	@Update("""
			UPDATE `competition`
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int increaseGoodReactionPoint(int academyId, int themeId);

	
	// 공모전의 좋아요 점수를 1점 감소시킵니다.
	@Update("""
			UPDATE `competition`
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int decreaseGoodReactionPoint(int themeId, int academyId);

	
	 // 특정 공모전의 좋아요 점수를 조회합니다.
	@Select("""
			SELECT goodReactionPoint
			FROM `competition`
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int getGoodRP(int themeId, int academyId);

	@Select("""
			<script>
			SELECT title,
			DATE_FORMAT(SUBSTRING_INDEX(applicationPeriod, ' ~ ', 1), '%y.%m.%d') AS applicationPeriod
			FROM `competition`
			WHERE id IN (
			SELECT academyId
			FROM scrap
			WHERE memberId = #{memberId} AND POINT = 1 AND themeId = 2
			);
			</script>
			""")
	public List<Competition> getscrapShopsList(int memberId);

	 // 특정 키워드를 포함하는 공모전의 총 수를 반환합니다.
	@Select("""
			    <script>
			    SELECT COUNT(*) FROM `competition`
			    WHERE title LIKE CONCAT('%', #{searchKeyword}, '%')
			    </script>
			""")
	public int countConferences(String searchKeyword);

	 // 등록된 모든 공모전 수를 반환합니다.
	@Select("""
			    <script>
			    SELECT COUNT(*) FROM `competition`
			    WHERE title LIKE CONCAT('%', #{searchKeyword}, '%')
			    </script>
			""")
	public int countCompetitons(String searchKeyword);
	
	
	@Select("""
			SELECT c.*
			FROM `competition` AS c
			WHERE c.id = #{id}
			""")
	public Competition getcompetitionId(int id);

	 // 특정 ID의 공모전을 삭제합니다.
	@Delete("""
			DELETE FROM `competition`
			WHERE id = #{id}
			""")
	void deleteCompetition(int id);

	// 조회수를 증가시킵니다.
	@Update("""
			UPDATE `competition`
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	public int increaseHitCount(int id);

	
	   // 조회수를 반환합니다.
	@Select("""
			SELECT hitCount
			FROM `competition`
			WHERE id = #{id}
			""")
	public int getCompetitionHitCount(int id);


}