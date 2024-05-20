package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Conference;

@Mapper
public interface ConferenceRepository {

	// 학회 정보를 데이터베이스에 삽입
	@Insert("""
			INSERT INTO `academy` SET
			         categoryId = #{categoryId},
			         themeId = 1,
			         title = #{title},
			         hitCount = #{hitCount},
			         eventPeriod = #{eventPeriod},
			         applicationPeriod = #{applicationPeriod},
			         entryFee = #{entryFee},
			         place = #{place},
			         address = #{address},
			         homepage = #{homepage},
			         imageURL = #{imageURL},
			         regDate = NOW()
			""")
	void insertConference(Conference conference);

	// 카테고리와 검색 키워드를 기준으로 학회 목록을 가져옴 (페이징 처리)
	@Select("""
			    <script>
			    SELECT * FROM `academy`
			    WHERE categoryId = #{categoryId}
			    AND title LIKE CONCAT('%', #{searchKeyword}, '%')
			    LIMIT #{limit} OFFSET #{offset}
			    </script>
			""")
	List<Conference> getShopsList(@Param("categoryId") int categoryId,
			@Param("searchKeyword") String searchKeyword, @Param("offset") int offset, @Param("limit") int limit);

	// 카테고리와 검색 키워드를 기준으로 학회 개수를 세어 반환
	@Select("""
			    <script>
			    SELECT COUNT(*) FROM `academy`
			    WHERE categoryId = #{categoryId}
			    AND title LIKE CONCAT('%', #{searchKeyword}, '%')
			    </script>
			""")
	int countConferences(@Param("categoryId") int categoryId, @Param("searchKeyword") String searchKeyword);

	// ID를 기준으로 학회 정보를 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE id = #{id};
			</script>
			""")
	Conference getEventById(int id);

	// 카테고리를 기준으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId};
			</script>
			""")
	List<Conference> getConferencesByCategory(int categoryId);

	// 등록일 기준으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	List<Conference> getConferencesOrderByRegDate();

	// 카테고리와 등록일 기준으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId);

	// 조회수 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY hitCount DESC
			</script>
			""")
	List<Conference> getConferencesOrderByhitCount();

	// 카테고리와 조회수 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY hitCount DESC
			</script>
			""")
	List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId);

	// 마감일 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	List<Conference> getConferencesOrderByfinDate();

	// 카테고리와 마감일 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId);

	// 제목 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY title ASC
			</script>
			""")
	List<Conference> getConferencesOrderBytitle();

	// 카테고리와 제목 순으로 학회 목록을 가져옴
	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY title ASC
			</script>
			""")
	List<Conference> getConferencesByCategoryOrderBytitle(int categoryId);

	// 수정된 주소 형식으로 학회 목록을 가져옴
	@Select("""
			    <script>
			    SELECT title,place,
			           CONCAT(
			               DATE_FORMAT(SUBSTRING_INDEX(eventPeriod, ' ~ ', 1), '%y.%m.%d'),
			               ' ~ ',
			               DATE_FORMAT(SUBSTRING_INDEX(eventPeriod, ' ~ ', -1), '%y.%m.%d')
			           ) AS eventPeriod,
			           address
			    FROM `academy`;
			    </script>
			""")
	List<Conference> getShopsList2();

	// 좋아요 반응 점수 증가
	@Update("""
			UPDATE `academy`
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	int increaseGoodReactionPoint(int academyId, int themeId);

	// 좋아요 반응 점수 감소
	@Update("""
			UPDATE `academy`
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	int decreaseGoodReactionPoint(int themeId, int academyId);

	// 좋아요 반응 점수를 가져옴
	@Select("""
			SELECT goodReactionPoint
			FROM `academy`
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	int getGoodRP(int themeId, int academyId);

	// 사용자의 스크랩 학회 목록을 가져옴
	@Select("""
			    <script>
			    SELECT title, place,
			           DATE_FORMAT(SUBSTRING_INDEX(eventPeriod, ' ~ ', 1), '%y.%m.%d') AS eventPeriod,
			           address
			    FROM `academy`
			    WHERE id IN (
			        SELECT academyId
			        FROM scrap
			        WHERE memberId = #{memberId} AND point = 1 AND themeId = 1
			    );
			    </script>
			""")
	List<Conference> getscrapShopsList(int memberId);

	// 학회 삭제를 위한 학회 정보를 가져옴
	@Select("""
			SELECT a.*
			FROM `academy` AS a
			WHERE a.id = #{id}
			""")
	Conference getConferenceId(int id);

	// 학회 정보를 삭제
	@Delete("""
			DELETE FROM `academy`
			WHERE id = #{id}
			""")
	void deleteConference(int id);

	// 조회수 증가
	@Update("""
			UPDATE `academy`
			SET hitCount = hitCount + 1
			WHERE id = #{id}
			""")
	int increaseHitCount(int id);
	
	// 학회의 조회수를 가져옴
	@Select("""
			SELECT hitCount
			FROM `academy`
			WHERE id = #{id}
			""")
	Object getConferenceHitCount(int id);

}
