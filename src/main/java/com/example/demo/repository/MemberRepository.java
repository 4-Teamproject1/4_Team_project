package com.example.demo.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Inquiry;
import com.example.demo.vo.Member;

@Mapper
public interface MemberRepository {

	// 로그인 ID로 회원 정보를 조회합니다.
	@Select("""
			SELECT *
			FROM `member`
			WHERE loginId = #{loginId}
			""")
	public Member getMemberByLoginId(String loginId);

	// 이름과 이메일로 회원 정보를 조회합니다.
	@Select("""
			SELECT *
			FROM `member`
			WHERE name = #{name}
			AND email = #{email}
			""")
	public Member getMemberByNameAndEmail(String name, String email);

	// 새로운 회원을 가입시킵니다.
	@Insert("""
			INSERT INTO
			`member` SET
			regDate = NOW(),
			updateDate = NOW(),
			loginId = #{loginId},
			loginPw = #{loginPw},
			`name` = #{name},
			nickname = #{nickname},
			cellphoneNum = #{cellphoneNum},
			email = #{email}
			""")
	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);

	//마지막으로 삽입된 행의 ID를 반환합니다.
	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	//회원 ID로 회원 정보를 조회합니다.
	@Select("SELECT * FROM `member` WHERE id = #{id}")
	public Member getMember(int id);

	// 회원 정보를 수정합니다. 비밀번호가 포함된 경우.
	@Update("""
			<script>
			UPDATE `member`
			<set>
				<if test="loginPw != null">
					loginPw = #{loginPw},
				</if>
				<if test="name != null">
					name = #{name},
				</if>
				<if test="nickname != null">
					nickname = #{nickname},
				</if>
				<if test="cellphoneNum != null">
					cellphoneNum = #{cellphoneNum},
				</if>
				<if test="email != null">
					email = #{email},
				</if>
				updateDate= NOW()
			</set>
			WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modify(int loginedMemberId, String loginPw, String name, String nickname, String cellphoneNum,
			String email);

	// 회원 정보를 수정합니다. 비밀번호가 포함되지 않은 경우.
	@Update("""
			<script>
			UPDATE `member`
			<set>
				<if test="name != null">
					name = #{name},
				</if>
				<if test="nickname != null">
					nickname = #{nickname},
				</if>
				<if test="cellphoneNum != null">
					cellphoneNum = #{cellphoneNum},
				</if>
				<if test="email != null">
					email = #{email},
				</if>
				updateDate= NOW()
			</set>
			WHERE id = #{loginedMemberId}
			</script>
			""")
	public void modifyWithoutPw(int loginedMemberId, String name, String nickname, String cellphoneNum, String email);

	// 회원의 문의글을 작성합니다.
	@Insert("""
			INSERT INTO
			inquiry SET
			regDate = NOW(),
			updateDate = NOW(),
			memberId = #{memberId},
			title = #{title}, `body` = #{body}
			""")
	public void inquirywriteArticle(int memberId, String title, String body);

	// 문의글 ID로 문의글을 조회합니다.
	@Select("""
			SELECT *
			FROM inquiry
			WHERE id = #{id}
			""")
	public Inquiry getInquiry(int id);

	// 특정 회원의 모든 문의글을 조회합니다.
	@Select("""
			SELECT *
			FROM inquiry AS i
			INNER JOIN `member` AS m
			ON i.memberId = m.id
			WHERE i.memberId = #{memberId}
			ORDER BY i.id DESC
			""")
	public List<Inquiry> getAllInquiries(int memberId);

    // 회원의 탈퇴 상태를 업데이트합니다.	
	@Update("""
			UPDATE member
			SET delStatus = #{delStatus}, delDate = NOW()
			WHERE id = #{memberId}
			""")
	int updateDelStatus(int memberId, int delStatus);

	// 회원의 권한 레벨을 조회합니다.
	@Select("""
			SELECT `authLevel`
			FROM member
			WHERE id = #{memberId};
			""")
	public int getMemberLevel(int memberId);

	// 관리자 권한이 없는 모든 회원을 조회합니다.
	@Select("""
			SELECT *
			FROM member
			WHERE authLevel != 7;
			""")
	public List<Member> getMembers();

	// 문의글 ID로 특정 문의글을 삭제합니다.
	@Delete("""
			DELETE FROM inquiry
			WHERE id = #{id}
			""")
	public void deleteInquiry(int id);

	// 모든 문의글을 조회합니다.
	@Select("""
			SELECT *
			FROM inquiry
			""")
	public List<Inquiry> getAllInquiries2();

}
