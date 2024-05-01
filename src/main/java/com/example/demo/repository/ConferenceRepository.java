package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
            FROM `academy`;
            </script>
            """)
    public List<Conference> getShopsList();


    
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

}
