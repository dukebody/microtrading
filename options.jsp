<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search options</title>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<h1>
			Search options
		</h1>
		<form action="start.jsp" method="get">
			<p>
			<%
			// Depending on the request, on of the three radio buttons will be checked.
			String option = request.getParameter("search_options");
			if (option.equals("name")) {
			%>
				<input type="radio" name="search_options" value="name" checked="checked"/>
				Order your search by name<br/>
				<input type="radio" name="search_options" value="price"/>
				Order your search by price<br/>
				<input type="radio" name="search_options" value="date"/>
				Order your search by date of publication<br/>
			<% 
			}
			else if (option.equals("price")) { %>
				<input type="radio" name="search_options" value="name"/>
				Order your search by name<br/>
				<input type="radio" name="search_options" value="price" checked="checked"/>
				Order your search by price<br/>
				<input type="radio" name="search_options" value="date"/>
				Order your search by date of publication<br/>
		<% 	} 
			else {
			%>
				<input type="radio" name="search_options" value="name"/>
				Order your search by name<br/>
				<input type="radio" name="search_options" value="price"/>
				Order your search by price<br/>
				<input type="radio" name="search_options" value="date" checked="checked"/>
				Order your search by date of publication<br/>
		<% } %>
				<div class="center">
					<input name="submit" type="submit" value="Back to your search"/>
				</div>
			</p>
		</form>
	</body>
</html>