package com.example.demo.repository;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Hotel;

@Mapper
public interface HotelListRepository {

	@Insert("""
			INSERT INTO
			`hotel` SET
			imgUrl = #{imgUrl},
			hotelName = #{hotelName},
			grade = #{grade},
			price=#{price}
			""")
	public void insertHotel(Hotel hotel);

}
