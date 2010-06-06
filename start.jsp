<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
		<title>Welcome to Simple Trade </title>
		<link rel="stylesheet" type="text/css" href="style.css" />
	</head>
	<body>
		<div class="center"> 
			<img src="images/simpletradelogo2.jpg" alt="logo"/>
		</div>
		<br />
		<%
		String option = request.getParameter("search_options"); 
		// Search options chosen by the user or the default search option, i.e. sorting by date.
		%>
		<a href="options.jsp?search_options=<%=option %>" class="options">Advanced search</a>
		<form action="result.jsp" method="get">
			<div class="center">
				<input name="item" id ="item" type="text" size="60" />
				<input name="search_options" id="search_options" type="hidden" value="<%=option %>" />
				<input name="submit" type="submit" value="Trade now!" />
			</div>
			<br/>
			<div class="center help">e.g.: Computer Dell Inspiron 2 years</div>
		</form>
		<br />
		<div class="center footer">
			<a href="aboutUs.html">About Us</a>
			<a href="tos.html">Terms of Service</a>
		</div>
	</body>
</html>