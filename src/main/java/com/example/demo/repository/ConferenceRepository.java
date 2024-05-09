package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Conference;

@Mapper
public interface ConferenceRepository {

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
	public void insertConference(Conference conference);

	@Select("""
		    <script>
		    SELECT * FROM `academy`
		    WHERE categoryId = #{categoryId}
		    AND title LIKE CONCAT('%', #{searchKeyword}, '%')
		    LIMIT #{limit} OFFSET #{offset}
		    </script>
		""")
		public List<Conference> getShopsList(@Param("categoryId") int categoryId, @Param("searchKeyword") String searchKeyword, @Param("offset") int offset, @Param("limit") int limit);

		@Select("""
		    <script>
		    SELECT COUNT(*) FROM `academy`
		    WHERE categoryId = #{categoryId}
		    AND title LIKE CONCAT('%', #{searchKeyword}, '%')
		    </script>
		""")
		public int countConferences(@Param("categoryId") int categoryId, @Param("searchKeyword") String searchKeyword);

          

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

@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByRegDate();

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId);

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByhitCount();

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId);

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesOrderByfinDate();

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId);

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			ORDER BY title ASC
			</script>
			""")
	public List<Conference> getConferencesOrderBytitle();

	@Select("""
			<script>
			SELECT *
			FROM `academy`
			WHERE categoryId = #{categoryId}
			ORDER BY title ASC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderBytitle(int categoryId);

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
	public List<Conference> getShopsList2();
          
	@Update("""
			UPDATE `academy`
			SET goodReactionPoint = goodReactionPoint + 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int increaseGoodReactionPoint(int academyId, int themeId);

	@Update("""
			UPDATE `academy`
			SET goodReactionPoint = goodReactionPoint - 1
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int decreaseGoodReactionPoint(int themeId, int academyId);

	@Select("""
			SELECT goodReactionPoint
			FROM `academy`
			WHERE id = #{academyId}
			AND themeId = #{themeId}
			""")
	public int getGoodRP(int themeId, int academyId);

	
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
	public List<Conference> getscrapShopsList(int memberId);




}