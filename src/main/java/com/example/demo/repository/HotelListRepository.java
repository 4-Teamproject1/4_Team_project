package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Conference;
import com.example.demo.vo.Hotel;

@Mapper
public interface HotelListRepository {

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

	@Select("""
			SELECT *
			FROM `hotel`
			WHERE location= #{area}
			""")
	public List<Hotel> getHotelList(String area);

	@Select("""
			SELECT *
			FROM `hotel`
			""")
	public List<Hotel> getAllHotelList();

	@Select("""
			SELECT *
			FROM hotel
			WHERE location = #{location}
			""")
	public List<Hotel> findByLocation(String location);

	@Select("""
			SELECT *
			FROM hotel
			WHERE location LIKE #{locationPrefix}
			""")
	public List<Hotel> getHotelsByLocationPrefix(String locationPrefix);

}
