<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String title = request.getParameter("name");
String description = request.getParameter("description");
String price = request.getParameter("price");
String contact = request.getParameter("contact");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Detail of your item</title>
		<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
	</head>
	<body>
		<h1>Item details</h1>
		<div id="content">
			<div><div class="label">Title: </div><div class="field"><%=title%></div></div><br/>
			<div>
				<div class="label">Description: </div>
				<div class="field"><%=description%></div>
			</div><br/>
			<div><div class="label">Price: </div><div class="field"><%=price%></div></div><br/>
			<div><div class="label">Contact: </div><div class="field"><%=contact%></div></div><br/>
		</div><br/>
		<div class="center"><a href="form.html">back</a>
	</body>
</html>