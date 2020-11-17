<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>index</title>
		
		<!-- Bootstrap Framework 사용 -->
		
		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		
		<!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		
		<!-- Popper JS -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		
		<!-- Latest compiled JavaScript -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		
		<!-- Bootstrap 4 Icons -->
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
		
		<!-- Google Web Fonts -->
		<link rel="preconnect" href="https://fonts.gstatic.com">
		<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
		<link href="https://fonts.googleapis.com/css2?family=Righteous&display=swap" rel="stylesheet">
		
		<style>
			.center {
				margin: auto;
				text-align: center;
			}
			
			.tb-width {
				width: 80%;
			}
			
			.ul-center {
				margin-left: auto;
 				margin-right: auto;
			}
			
			.title {
				font-family: 'Righteous', cursive;
			}
			
			body {
				font-family: 'Noto Sans KR', sans-serif;
			}
			
			h1 {
				font-family: 'Do Hyeon', sans-serif;
			}
			
			th {
				background-color: #F9F9FB;
			}
			
			td {
				text-align: left;
			}
		</style>
	</head>
	<body>
		<%@ include file="./menu.jsp" %>
		<div class="container center">
			<br>
		
			<!-- 홈페이지(메인) 내용 -->
			<h1>EMPLOYEES 미니 프로젝트</h1>
			
			<br>
			
			<table class="table table-hover tb-width center">
	            <tr>
	                <th width="20%">제작자</th>
	                <td width="80%">한재용&nbsp;<button class="btn btn-sm btn-warning text-light" type="button" onclick = "location.href='mailto:maru_i@kakao.com'">maru_i@kakao.com</button></td>
	            </tr>
	            <tr>
	                <th>프로젝트 기간</th>
	                <td>2020.09.08 ~ 2020.09.15 / 2020.11.16 ~ ?</td>
	            </tr>
	            <tr>
	                <th>프로젝트 설명</th>
	                <td>JSP로만 제작한 첫 번째 웹 프로젝트</td>
	            </tr>
	            <tr>
	                <th>프로젝트 과정</th>
	                <td>
	                	<h4>2020.09.08</h4>
	                	<img src="./image/20200908.png" style="width: 100%; height: auto;">
	                	<ul>
	                		<li>최초 프로젝트 생성</li>
	                		<li>JSP를 이용하여 데이터베이스 내용 출력</li>
	                		<li>departments, dept_emp, dept_manager, employees, salaries, titles 페이지 제작</li>
	                	</ul>
	                	
	                	<br>
	                	
	                	<h4>2020.09.10</h4>
	                	<img src="./image/20200910.png" style="width: 100%; height: auto;">
	                	<ul>
	                		<li>페이징 기능 추가</li>
	                		<li>이전/다음 페이지로 이동할 수 있는 기능 추가</li>
	                		<li>departments, dept_emp, dept_manager, employees, salaries, titles 페이지에 적용</li>
	                	</ul>
	                	
	                	<br>
	                	
	                	<h4>2020.09.11</h4>
	                	<img src="./image/20200911.png" style="width: 50%; height: auto;">
	                	<ul>
	                		<li>검색기능 추가</li>
	                		<li>동적 쿼리를 이용한 검색기능 추가</li>
	                		<li>employees 페이지에 적용</li>
	                	</ul>
	                	
	                	<br>
	                	
	                	<h4>2020.09.14</h4>
	                	<img src="./image/20200914.png" style="width: 100%; height: auto;">
	                	<ul>
	                		<li>동적 쿼리를 이용한 검색기능 추가</li>
	                		<li>departments, employees, dept_emp 페이지에 적용</li>
	                	</ul>
	                	
	                	<h4>2020.09.15</h4>
	                	<img src="./image/20200915.png" style="width: 65%; height: auto;">
	                	<ul>
	                		<li>동적 쿼리를 이용한 검색기능 추가</li>
	                		<li>salaries 페이지에 적용</li>
	                		<li>NavBar에 Bootstrap Framework 적용</li>
	                	</ul>
	                	
	                	<h4>2020.11.16</h4>
	                	<img src="./image/20201116.png" style="width: 100%; height: auto;">
	                	<ul>
	                		<li>Bootstrap Framework를 이용한 디자인 변경</li>
	                		<li>Home, 부서 페이지에 새 디자인 적용</li>
	                		<li>Google Web Fonts 적용 (Righteous, Noto Sans KR, Do Hyeon)</li>
	                	</ul>
	                </td>
	            </tr>
			</table>
		</div>
		
		<br><br>
	</body>
</html>