<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
	// 요청 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// MariaDB를 사용할 수 있게 해주는 메소드
	Class.forName("org.mariadb.jdbc.Driver"); // 드라이버 객체를 새로 만듬. new Driver();
	
	// 연결정보를 담은 변수 선언, Maria DB에 접근할때 쓰는 프로토콜
	// MariaDB 접속 (주소+포트번호+DB이름, DB계정ID, DB계정PW)
	Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost/employees","root","java1004");
%>