<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>departmentsList</title>
		
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
		</style>
	</head>
	<body>
		<%@ include file="./menu.jsp" %>
		<div class="container center">
			<%
				int currentPage = 1;	// 기본적으로 1페이지 표시하기 위함
				
				if (request.getParameter("currentPage") != null) { // null인지 아닌지 체크
					currentPage = Integer.parseInt(request.getParameter("currentPage"));	// currentPage를 파라미터 값으로 변경
				}
				
				String deptName = "";	// 재직여부 검색 기본값
				
				if (request.getParameter("deptName") != null) { // null인지 아닌지 체크
					deptName = request.getParameter("deptName"); // deptName를 파라미터 값으로 변경
				}
				
				int rowPerPage = 10; // 한 페이지당 데이터를 표시할 개수
				
				/*
					select dept_no, dept_name from departments	-> departments 테이블 참조
					order by dept_no desc						-> dept_no를 기준으로 내림차순 정렬
					limit 0, 10;								-> 1페이지
					limit 10, 10;								-> 2페이지
					limit 20, 10;								-> 3페이지
					...
					
					=> 정규화: (limit currentPage - 1) * rowPerPage, rowPerPage;
				*/
				
				%><%@include file="./DBConnection.jsp" %><%
		        
		        // 데이터 출력 위한 SQL문 (동적 쿼리)
		        String sql;
		        PreparedStatement stmt; // 데이터베이스 접속
		        
		        if (deptName.equals("")) {	// 검색을 안 하면 (혹은 기본 값)
		        	sql= "select dept_no, dept_name from departments order by dept_no desc limit ?, ?";
			        stmt = conn.prepareStatement(sql);
			        
			        stmt.setInt(1, (currentPage - 1) * rowPerPage);	// 첫 번째 인자 (시작 데이터)
			        stmt.setInt(2, rowPerPage);						// 두 번째 인자 (데이터 개수)
		        } else { // 부서 이름 검색시
		        	sql= "select dept_no, dept_name from departments where dept_name like ? order by dept_no desc limit ?, ?";
			        stmt = conn.prepareStatement(sql);
			        
			        stmt.setString(1, "%"+deptName+"%");				// 첫 번째 인자 (부서 이름 검색)
			        stmt.setInt(2, (currentPage - 1) * rowPerPage);		// 두 번째 인자 (시작 데이터)
			        stmt.setInt(3, rowPerPage);							// 세 번째 인자 (데이터 개수)
		        }
		        
		        // 쿼리 실행
		        ResultSet rs = stmt.executeQuery();
						
				
		     	// 마지막 페이지를 처리하기 위한  SQL문
	   			String sql2;
	   			PreparedStatement stmt2; // 데이터베이스 접속
	   	     	
	   			if (deptName.equals("")) {	// 검색을 안 하면 (혹은 기본 값)
	   	        	sql2= "select count(*) from departments";
	   	        	stmt2 = conn.prepareStatement(sql2);
	   	        } else { // 부서이름 검색시
	   	        	sql2= "select count(*) from departments where dept_name like ?";
	   	        	stmt2 = conn.prepareStatement(sql2);
	   		        
	   		        stmt2.setString(1, "%"+deptName+"%");			// 첫 번째 인자 (부서 검색)
	   	        }
	   	     				
	   			// 쿼리 실행
	   	        ResultSet rs2 = stmt2.executeQuery();
		    %>
		
			<br>
		
			<h1>부서 목록</h1>
			
			<br>
		    
		    <!-- 데이터 목록 -->
		    <table class="table table-hover tb-width center">
	        	<thead>
		        	<tr>
		                <th>부서 번호</th>
		                <th>부서 이름</th>
		            </tr>
	        	</thead>
	            <tbody>
	            	<%    
				        // 최종결과 출력
				        while(rs.next()) {
				        	String no = rs.getString("dept_no");
				        	String name = rs.getString("dept_name");
				    %>
				            <tr>
				                <td><%=no %></td>
				                <td><%=name %></td>
				            </tr>
		            <%
				        }
		            %>
	            </tbody>
			</table>
			
			<br>
			
			<!-- 페이지 네비게이션 -->
			<ul class="pagination justify-content-center">
				<!-- 처음으로 버튼 -->
				<%
					if (currentPage > 1) { // currentPage가 1보다 클 때만 처음으로 갈 수 있음
						%>
							<li class="page-item">
								<a class="page-link" href="./departmentsList.jsp?deptName=<%=deptName %>&currentPage=1">
									<i class='fas fa-angle-double-left'></i>
								</a>
							</li>
						<%
					} else { // 첫 페이지 일 때 처음으로 버튼 표시 안 함
						%>
							<li class="page-item disabled">
								<a class="page-link" href="#">
									<i class='fas fa-angle-double-left'></i>
								</a>
							</li>
						<%
					}
				%>
				<!-- 이전 버튼 -->
				
				<%
					if (currentPage > 1) { // currentPage가 1보다 클 때만 이전으로 갈 수 있음
						%>
							<li class="page-item">
								<a class="page-link" href="./departmentsList.jsp?deptName=<%=deptName %>&currentPage=<%=currentPage - 1 %>">
									<i class='fas fa-angle-left'></i>
								</a>
							</li>
						<%
					} else { // 1이거나 그 이하면 버튼 표시 안 함
						%>
							<li class="page-item disabled">
								<a class="page-link" href="#">
									<i class='fas fa-angle-left'></i>
								</a>
							</li>
						<%
					}
				%>
				<!-- 현재 페이지 표시 -->
				<%
					int totalCount = 0; // 기본값은 0으로
					if (rs2.next()) {
						totalCount = rs2.getInt("count(*)");
					}
					
					int lastPage = totalCount / rowPerPage;
					if (totalCount % rowPerPage != 0) {	// 10 미만의 개수의 데이터가 있는 페이지를 표시
						lastPage += 1;
					}
				
					int navPerPage = 10;	// 네비게이션에 표시할 페이지 수
					int navFirstPage = currentPage - (currentPage % navPerPage) + 1;	// 네비게이션 첫번째 페이지
					int navLastPage = navFirstPage + navPerPage - 1;	// 네비게이션 마지막 페이지
					
					if (currentPage % navPerPage == 0) {	// 10으로 나누어 떨어지는 경우 처리하는 코드
						navFirstPage = navFirstPage - navPerPage;
						navLastPage = navLastPage - navPerPage;
					}
				
					for(int i = navFirstPage; i <= navLastPage; i++) {
						if (i <= lastPage) {
							if (i == currentPage) {
								%><li class="page-item active"><a class="page-link" href="#"><%=i %></a></li><%	// 현재 페이지
							} else {
								%><li class="page-item"><a class="page-link" href="./departmentsList.jsp?deptName=<%=deptName %>&currentPage=<%=i %>"><%=i %></a></li><%	// 다른 페이지
							}
						}
					}
				%>
				<!-- 다음 버튼 -->
				<%
					if (currentPage < lastPage) { // currentPage가 lastPage보다 작을 때만 다음으로 갈 수 있음
						%>
							<li class="page-item">
								<a class="page-link" href="./departmentsList.jsp?deptName=<%=deptName %>&currentPage=<%=currentPage + 1 %>">
									<i class='fas fa-angle-right'></i>
								</a>
							</li>
						<%
					} else { // 마지막 페이지 일 때 다음 버튼 표시 안 함
						%>
							<li class="page-item disabled">
								<a class="page-link" href="#">
									<i class='fas fa-angle-right'></i>
								</a>
							</li>
						<%
					}
				%>
				<!-- 마지막으로 버튼 -->
				<%
					if (currentPage < lastPage) { // currentPage가 lastPage보다 작을 때만 마지막으로 갈 수 있음
						%>
							<li class="page-item">
								<a class="page-link" href="./departmentsList.jsp?deptName=<%=deptName %>&currentPage=<%=lastPage %>">
									<i class='fas fa-angle-double-right'></i>
								</a>
							</li>
						<%
					} else { // 마지막 페이지 일 때 마지막으로 버튼 표시 안 함
						%>
							<li class="page-item disabled">
								<a class="page-link" href="#">
									<i class='fas fa-angle-double-right'></i>
								</a>
							</li>
						<%
					}
				%>
			</ul>
			
			<!-- 총 페이지 수 출력 -->
			<button type="button" class="btn btn-sm btn-dark"><%=currentPage %> / <%=lastPage %> 페이지</button>
			
			<br><br>
			
			<!-- 검색기능 -->
			<form method="post" action="./departmentsList.jsp" class="form-inline">
				<div class="input-group mb-3 center" style="width: 40%;">
					<div class="input-group-prepend">
				    	<span class="input-group-text">부서 이름</span>
				    </div>
				    <input type="text" class="form-control" name="deptName" value=<%=deptName %>>
				    <div class="input-group-append">
				    	<button class="btn btn-secondary" type="submit">검색</button>
				    </div>
				</div>
			</form>
        </div>
	</body>
</html>