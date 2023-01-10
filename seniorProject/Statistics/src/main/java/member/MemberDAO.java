package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//실제로 DB에 접근하는 클래스
public class MemberDAO {
	
	private Connection conn;
	// SQL문 작성 중 속성값을 ?로 하여 나중에 대입함
	// => 이로써 SQL 인젝션 공격을 막을 수 있음
	private PreparedStatement pstmt;
	// ResultSet은 결과를 저장하는 객체
	private ResultSet rs;
	
	// 생성자
	public MemberDAO() {
		try {
			// DB 접속에 필요한 데이터를 변수에 저장
			String dbURL = "jdbc:mysql://localhost:3306/STT";
			String dbID = "root";
			String dbPassword = "system1234";
			// DB와 연결하는 드라이버 클래스를 찾아 로드하는 역할 -> 인터페이스 같은
			Class.forName("com.mysql.jdbc.Driver");
			// 선언한 conn에 생성된 Connection 객체대입
			// DriverManager로부터 connection 객체를 받아와 jdbc와의 연결
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인 성공 여부 확인
	public int login(String userID, String userPassword) {
		String SQL = "select userPassword from user where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); // SQL 인젝션 방어
			pstmt.setString(1, userID); // 인자로 받은 값을 ? 자리에 대입
			// select문에서 얻은 데이터를 ResultSet 객체에 저장
			rs = pstmt.executeQuery();
			// select문 결과가 존재하면
			if(rs.next()) {
				// select문 결과로 얻은 값이 인자와 같은 값이면
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				} 
				else 
					return 0; // 비밀번호 불일치
			}
			return -1; // select 쿼리 오류 -> 아이디가 없는 경우
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2; // DB 오류를 나타내는 숫자
	}
	
}
