package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Conference;
import com.example.demo.vo.Hotel;

@Mapper
public interface HotelListRepository {

	// 호텔 정보를 데이터베이스에 삽입하는 메서드
	@Insert("""
			INSERT INTO
			`hotel` SET
			imgUrl = #{imgUrl},
			hotelName = #{hotelName},
			grade = #{grade},
			price=#{price},
			service=#{service},
			location = #{location},
			href=#{href}
			""")
	public void insertHotel(Hotel hotel);

	// 특정 지역의 호텔 리스트를 가져오는 메서드
	@Select("""
			SELECT *
			FROM `hotel`
			WHERE location= #{area}
			""")
	public List<Hotel> getHotelList(String area);

	// 모든 호텔 리스트를 가져오는 메서드
	@Select("""
			SELECT *
			FROM `hotel`
			""")
	public List<Hotel> getAllHotelList();

	// 특정 지역의 호텔을 검색하는 메서드
	@Select("""
			SELECT *
			FROM hotel
			WHERE location = #{location}
			""")
	public List<Hotel> findByLocation(String location);

	// 지역 접두사에 해당하는 호텔 리스트를 가져오는 메서드
	@Select("""
			SELECT *
			FROM hotel
			WHERE location LIKE #{locationPrefix}
			""")
	public List<Hotel> getHotelsByLocationPrefix(String locationPrefix);

}
