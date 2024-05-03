package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

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
			         address = #{address},
			         homepage = #{homepage},
			         imageURL = #{imageURL},
			         regDate = NOW()
			""")
	public void insertConference(Conference conference);

	@Select("""
		    <script>
		    SELECT * 
		    FROM `academy` 
		    WHERE 1
		        AND ( title LIKE CONCAT('%', '${searchKeyword}', '%'))
		    </script>
		""")
		public List<Conference> getShopsList(int categoryId, String searchKeyword);
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
	public int decreaseGoodReactionPoint(int academyId, int themeId);

    
    @Select("""
    	    SELECT goodReactionPoint
    	    FROM `academy`
    	    WHERE id = #{academyId}
    	    AND themeId = #{themeId}
    	    """)
    	public int getGoodRP(int themeId, int academyId);






	

   

}
