<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Search options</title>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<h1>
			Search options
		</h1>
		<form action="index.jsp" method="get">
		  <p>
			<%
			// Depending on the request, on of the three radio buttons will be checked.
			String option = request.getParameter("search_options");
			%>
			<input type="radio" name="search_options" value="name" 
                          <% if (option.equals("name")) { %>checked="checked"<%} %> />
			  Order your search by name<br />
			<input type="radio" name="search_options" value="price"
			       <% if (option.equals("price")) { %>checked="checked"<%} %>/>
			  Order your search by price<br />
			<input type="radio" name="search_options" value="date"
                           <% if (option.equals("date")) { %>checked="checked"<%} %>/>
				Order your search by date of publication<br />

				<div class="center">
					<input name="submit" type="submit" value="Back to your search"/>
				</div>
			</p>
		</form>
	</body>
</html>