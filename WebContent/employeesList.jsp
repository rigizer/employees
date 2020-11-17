<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>employeesList</title>
		
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
				
				String searchGender = "";	// 성별 검색 기본값
				
				if (request.getParameter("searchGender") != null) { // null인지 아닌지 체크
					searchGender = request.getParameter("searchGender"); // searchGender를 파라미터 값으로 변경
				}
				
				String searchNameOpt = "FL"; // 이름 검색 옵션 기본값
				
				if (request.getParameter("searchNameOpt") != null) { // null인지 아닌지 체크
					searchNameOpt = request.getParameter("searchNameOpt"); // searchNameOpt를 파라미터 값으로 변경
				}
				
				String searchName = ""; // 이름 검색 기본값
				
				if (request.getParameter("searchName") != null) { // null인지 아닌지 체크
					searchName = request.getParameter("searchName"); // searchName를 파라미터 값으로 변경
				}
				
				int rowPerPage = 10; // 한 페이지당 데이터를 표시할 개수
				
				/*
					select emp_no, birth_date, first_name, last_name, gender, hire_date from employees	-> employees 테이블 참조
					order by emp_no desc																-> emp_no를 기준으로 내림차순 정렬
					limit 0, 10;																		-> 1페이지
					limit 10, 10;																		-> 2페이지
					limit 20, 10;																		-> 3페이지
					...
					
					=> 정규화: (limit currentPage - 1) * rowPerPage, rowPerPage;
				*/
			
				%><%@include file="./DBConnection.jsp" %><%
		        
		     	// 데이터 출력 위한 SQL문 (동적 쿼리)
		        String sql;
		        PreparedStatement stmt; // 데이터베이스 접속
		        
		        if (searchGender.equals("") && searchName.equals("")) {	// 검색을 안 하면 (혹은 기본 값)
		        	sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees order by emp_no desc limit ?, ?";
			        stmt = conn.prepareStatement(sql);
			        
			        stmt.setInt(1, (currentPage - 1) * rowPerPage);	// 첫 번째 인자 (시작 데이터)
			        stmt.setInt(2, rowPerPage);						// 두 번째 인자 (데이터 개수)
		        } else if (!searchGender.equals("") && searchName.equals("")) {	// 성별만 검색시
		        	sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where gender = ? order by emp_no desc limit ?, ?";
			        stmt = conn.prepareStatement(sql);
			        
			        stmt.setString(1, searchGender);					// 첫 번째 인자 (성별)
			        stmt.setInt(2, (currentPage - 1) * rowPerPage);		// 두 번째 인자 (시작 데이터)
			        stmt.setInt(3, rowPerPage);							// 세 번째 인자 (데이터 개수)
		        } else if (searchGender.equals("") && !searchName.equals("")) {	// 성별 상관없이 이름만 검색시
			        if (searchNameOpt.equals("F")) {	// FirstName만 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where first_name like ? order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, "%"+searchName+"%");				// 첫 번째 인자 (first_name)
				        stmt.setInt(2, (currentPage - 1) * rowPerPage);		// 두 번째 인자 (시작 데이터)
				        stmt.setInt(3, rowPerPage);							// 세 번째 인자 (데이터 개수)
		        	} else if (searchNameOpt.equals("L")) {	// SecondName만 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where last_name like ? order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, "%"+searchName+"%");				// 첫 번째 인자 (last_name)
				        stmt.setInt(2, (currentPage - 1) * rowPerPage);		// 두 번째 인자 (시작 데이터)
				        stmt.setInt(3, rowPerPage);							// 세 번째 인자 (데이터 개수)
		        	} else {	// FirstName과 SecondName 모두 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where (first_name like ? or last_name like ?) order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, "%"+searchName+"%");				// 첫 번째 인자 (first_name)
				        stmt.setString(2, "%"+searchName+"%");				// 두 번째 인자 (last_name)
				        stmt.setInt(3, (currentPage - 1) * rowPerPage);		// 세 번째 인자 (시작 데이터)
				        stmt.setInt(4, rowPerPage);							// 네 번째 인자 (데이터 개수)
		        	}
		        } else { // 성별과 이름 모두 검색시
		        	if (searchNameOpt.equals("F")) {	// FirstName만 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where gender = ? and first_name like ? order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, searchGender);					// 첫 번째 인자 (성별)
				        stmt.setString(2, "%"+searchName+"%");				// 두 번째 인자 (first_name)
				        stmt.setInt(3, (currentPage - 1) * rowPerPage);		// 세 번째 인자 (시작 데이터)
				        stmt.setInt(4, rowPerPage);							// 네 번째 인자 (데이터 개수)
		        	} else if (searchNameOpt.equals("L")) {	// SecondName만 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where gender = ? and last_name like ? order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, searchGender);					// 첫 번째 인자 (성별)
				        stmt.setString(2, "%"+searchName+"%");				// 두 번째 인자 (last_name)
				        stmt.setInt(3, (currentPage - 1) * rowPerPage);		// 세 번째 인자 (시작 데이터)
				        stmt.setInt(4, rowPerPage);							// 네 번째 인자 (데이터 개수)
		        	} else {	// FirstName과 SecondName 모두 검색할 때
		        		sql= "select emp_no, birth_date, first_name, last_name, gender, hire_date from employees where gender = ? and (first_name like ? or last_name like ?) order by emp_no desc limit ?, ?";
				        stmt = conn.prepareStatement(sql);
				        
				        stmt.setString(1, searchGender);					// 첫 번째 인자 (성별)
				        stmt.setString(2, "%"+searchName+"%");				// 두 번째 인자 (first_name)
				        stmt.setString(3, "%"+searchName+"%");				// 세 번째 인자 (last_name)
				        stmt.setInt(4, (currentPage - 1) * rowPerPage);		// 네 번째 인자 (시작 데이터)
				        stmt.setInt(5, rowPerPage);							// 다섯 번째 인자 (데이터 개수)
		        	}
		        }
		        
		        // 쿼리 실행
		        ResultSet rs = stmt.executeQuery();
		        
		        
		        
		        
		        
		     	// 마지막 페이지를 처리하기 위한 코드
				String sql2 = "select count(*) from employees";
				PreparedStatement stmt2;// 데이터베이스 접속
				
				
				
				
				if (searchGender.equals("") && searchName.equals("")) {	// 검색을 안 하면 (혹은 기본 값)
		        	sql2= "select count(*) from employees order by emp_no desc";
			        stmt2 = conn.prepareStatement(sql2);
		        } else if (!searchGender.equals("") && searchName.equals("")) {	// 성별만 검색시
		        	sql2= "select count(*) from employees where gender = ? order by emp_no desc";
			        stmt2 = conn.prepareStatement(sql2);
			        
			        stmt2.setString(1, searchGender);						// 첫 번째 인자 (성별)
		        } else if (searchGender.equals("") && !searchName.equals("")) {	// 성별 상관없이 이름만 검색시
			        if (searchNameOpt.equals("F")) {	// FirstName만 검색할 때
			        	sql2= "select count(*) from employees where first_name like ?";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, "%"+searchName+"%");					// 첫 번째 인자 (first_name)
		        	} else if (searchNameOpt.equals("L")) {	// SecondName만 검색할 때
		        		sql2= "select count(*) from employees where last_name like ?";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, "%"+searchName+"%");					// 첫 번째 인자 (last_name)
		        	} else {	// FirstName과 SecondName 모두 검색할 때
		        		sql2= "select count(*) from employees where (first_name like ? or last_name like ?)";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, "%"+searchName+"%");					// 첫 번째 인자 (first_name)
				        stmt2.setString(2, "%"+searchName+"%");					// 두 번째 인자 (last_name)
		        	}
		        } else { // 성별과 이름 모두 검색시
			        if (searchNameOpt.equals("F")) {	// FirstName만 검색할 때
			        	sql2= "select count(*) from employees where gender = ? and first_name like ?";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, searchGender);						// 첫 번째 인자 (성별)
				        stmt2.setString(2, "%"+searchName+"%");					// 두 번째 인자 (first_name)
		        	} else if (searchNameOpt.equals("L")) {	// SecondName만 검색할 때
		        		sql2= "select count(*) from employees where gender = ? and last_name like ?";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, searchGender);						// 첫 번째 인자 (성별)
				        stmt2.setString(2, "%"+searchName+"%");					// 두 번째 인자 (last_name)
		        	} else {	// FirstName과 SecondName 모두 검색할 때
		        		sql2= "select count(*) from employees where gender = ? and (first_name like ? or last_name like ?)";
				        stmt2 = conn.prepareStatement(sql2);
				        
				        stmt2.setString(1, searchGender);						// 첫 번째 인자 (성별)
				        stmt2.setString(2, "%"+searchName+"%");					// 두 번째 인자 (first_name)
				        stmt2.setString(3, "%"+searchName+"%");					// 세 번째 인자 (last_name)
		        	}
		        }
				
				// 쿼리 실행
		        ResultSet rs2 = stmt2.executeQuery();
		    %>
		
			<br>
		
			<h1>직원 목록</h1>
			
			<br>
		    
		    <!-- 데이터 목록 -->
		    <table class="table table-hover tb-width center">
	        	<thead>
		        	<tr>
		                <th>직원 번호</th>
		                <th>생일</th>
		                <th>나이</th>
		                <th>이름</th>
		                <th>성</th>
		                <th>성별</th>
		                <th>입사일</th>
		            </tr>
	        	</thead>
	            <tbody>
	            	<%    
				        // 최종결과 출력
				        while(rs.next()) {
				        	String empNo = rs.getString("emp_no");
				        	String birthDate = rs.getString("birth_date");
				        	String firstName = rs.getString("first_name");
				        	String lastName = rs.getString("last_name");
				        	String gender = rs.getString("gender");
				        	String hireDate = rs.getString("hire_date");
				    %>
				            <tr>
				                <td><%=empNo %></td>
				                <td><%=birthDate %></td>
				                <td>
				                	<%
				                		String age = birthDate;		// 데이터베이스에서 받아온 출생년도를 저장한다.
				                		age = age.substring(0, 4);	// 출생년도에서 앞 4자리에 대해 문자열을 잘라낸다.
				                		
				                		Calendar cal = Calendar.getInstance();	// java.util.Calendar 사용
				                		int nowYear = cal.get(Calendar.YEAR); // 현재 년도
				                		int ageInt = nowYear - Integer.parseInt(age); // 현재 년도에서 출생 년도를 뺀다.(만 나이)
				                		
				                		out.print(ageInt);
				                	%>
				                </td>
				                <td><%=firstName %></td>
				                <td><%=lastName %></td>
				                <td>
				                	<%
				                		if (gender.equals("M")) {	// 남녀출력을 한글로 변환
				                			%>남자<%
				                		} else {
				                			%>여자<%
				                		}
				                	%>
				                </td>
				                <td><%=hireDate %></td>
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
								<a class="page-link" href="./employeesList.jsp?searchGender=<%=searchGender %>&searchNameOpt=<%=searchNameOpt %>&searchName=<%=searchName %>&currentPage=1">
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
								<a class="page-link" href="./employeesList.jsp?searchGender=<%=searchGender %>&searchNameOpt=<%=searchNameOpt %>&searchName=<%=searchName %>&currentPage=<%=currentPage - 1 %>">
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
								%><li class="page-item"><a class="page-link" href="./employeesList.jsp?searchGender=<%=searchGender %>&searchNameOpt=<%=searchNameOpt %>&searchName=<%=searchName %>&currentPage=<%=i %>"><%=i %></a></li><%	// 다른 페이지
							}
						}
					}
				%>
				<!-- 다음 버튼 -->
				<%
					if (currentPage < lastPage) { // currentPage가 lastPage보다 작을 때만 다음으로 갈 수 있음
						%>
							<li class="page-item">
								<a class="page-link" href="./employeesList.jsp?searchGender=<%=searchGender %>&searchNameOpt=<%=searchNameOpt %>&searchName=<%=searchName %>&currentPage=<%=currentPage + 1 %>">
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
								<a class="page-link" href="./employeesList.jsp?searchGender=<%=searchGender %>&searchNameOpt=<%=searchNameOpt %>&searchName=<%=searchName %>&currentPage=<%=lastPage %>">
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
			<form method="post" action="./employeesList.jsp" class="form-inline">
				<div class="input-group mb-3 center" style="width: 50%;">
					<div class="input-group-prepend">
				    	<span class="input-group-text">
							<label class="form-check-label">
						    	성별
							</label>
						</span>
				    </div>
				    
				    <select name="searchGender" class="form-control">
						<%
							if (searchGender.equals("")) {	
								%><option value="" selected="selected">선택 없음</option><%
							} else {
								%><option value="">선택 없음</option><%
							}
			            %>
			            
			            <%
							if (searchGender.equals("M")) {	
								%><option value="M" selected="selected">남자</option><%
							} else {
								%><option value="M">남자</option><%
							}
			            %>
			            
			            <%
							if (searchGender.equals("F")) {	
								%><option value="F" selected="selected">여자</option><%
							} else {
								%><option value="F">여자</option><%
							}
			            %>
					</select>
				    
				    <div class="input-group-prepend">
				    	<span class="input-group-text">
							<label class="form-check-label">
						    	이름
							</label>
						</span>
				    </div>
				    
				    <select name="searchNameOpt" class="form-control">
			            <%
							if (searchNameOpt.equals("FL")) {	
								%><option value="FL" selected="selected">이름 + 성</option><%
							} else {
								%><option value="FL">이름 + 성</option><%
							}
			            %>
			            
			            <%
							if (searchNameOpt.equals("F")) {	
								%><option value="F" selected="selected">이름</option><%
							} else {
								%><option value="F">이름</option><%
							}
			            %>
			            
			            <%
							if (searchNameOpt.equals("L")) {	
								%><option value="L" selected="selected">성</option><%
							} else {
								%><option value="L">성</option><%
							}
			            %>
					</select>
				    
				    <input type="text" class="form-control" name="searchName" value=<%=searchName %>>
				    
				    <div class="input-group-append">
				    	<button class="btn btn-secondary" type="submit">검색</button>
				    </div>
				</div>
			</form>
        </div>
	</body>
</html>