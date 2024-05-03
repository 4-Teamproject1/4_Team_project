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
			href=#{href}
			""")
	public void insertHotel(Hotel hotel);

	@Select("""
			SELECT *
			FROM `hotel`;
			""")
	public List<Hotel> getHotelList();
}
