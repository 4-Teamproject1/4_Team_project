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
<<<<<<< HEAD
			         themeId = 1,
			         title = #{title},
=======
			         title = #{title},
			         themeId = 1,
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6
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
<<<<<<< HEAD
			<script>
			SELECT *
			FROM `academy`;
			</script>
			""")
	public List<Conference> getShopsList();
=======
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
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			WHERE id = #{id};
			</script>
			""")
	public Conference getEventById(int id);
=======
			WHERE categoryId = #{categoryId};
			</script>
			""")
	public List<Conference> getConferencesByCategory(int categoryId);
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			WHERE categoryId = #{categoryId};
			</script>
			""")
	public List<Conference> getConferencesByCategory(int categoryId);
=======
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByRegDate();
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByRegDate();
=======
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId);
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(regDate, '%Y-%m-%d') DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByRegDate(int categoryId);
=======
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByhitCount();
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesOrderByhitCount();
=======
			WHERE categoryId = #{categoryId}
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId);
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			WHERE categoryId = #{categoryId}
			ORDER BY hitCount DESC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByhitCount(int categoryId);
=======
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesOrderByfinDate();
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesOrderByfinDate();
=======
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId);
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
			WHERE categoryId = #{categoryId}
			ORDER BY STR_TO_DATE(SUBSTRING_INDEX(applicationPeriod, ' ~ ', -1), '%y.%m.%d') ASC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderByfinDate(int categoryId);
=======
			ORDER BY title ASC
			</script>
			""")
	public List<Conference> getConferencesOrderBytitle();
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

	@Select("""
			<script>
			SELECT *
			FROM `academy`
<<<<<<< HEAD
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
=======
			WHERE categoryId = #{categoryId}
			ORDER BY title ASC
			</script>
			""")
	public List<Conference> getConferencesByCategoryOrderBytitle(int categoryId);

	@Select("""
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6
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

<<<<<<< HEAD
	@Update("""
=======
    @Update("""
>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6
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
<<<<<<< HEAD
	public int decreaseGoodReactionPoint(int themeId, int academyId);
=======
	public int decreaseGoodReactionPoint(int academyId, int themeId);

    
    @Select("""
    	    SELECT goodReactionPoint
    	    FROM `academy`
    	    WHERE id = #{academyId}
    	    AND themeId = #{themeId}
    	    """)
    	public int getGoodRP(int themeId , int academyId);




>>>>>>> 6eb69d3e7d42d5cb46f3b26b428f9ae1e4bad0d6

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
		        WHERE memberId = #{memberId} AND point = 1
		    );
		    </script>
		""")
		public List<Conference> getscrapShopsList(int memberId);



}
