<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
String name = request.getParameter("name");
String description = request.getParameter("description");
String price = request.getParameter("price");
String location = request.getParameter("location");
String contact = request.getParameter("contact");
String sell_buy = request.getParameter("sell_buy");
String date = request.getParameter("date");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Detail of item</title>
		<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
	</head>
	<body>
		<h1>Item details</h1>
		<div id="content">
			<div><div class="label">Name: </div><div class="field"><%=name%></div></div><br/>
			<div>
			<div class="label">Description: </div><div class="field"><%=description%></div></div><br/>
			<div><div class="label">Price: </div><div class="field"><%=price%></div></div><br/>
			<div><div class="label">Location: </div><div class="field"><%=location%></div></div><br/>
			<div><div class="label">Contact: </div><div class="field"><%=contact%></div></div><br/>
			<div><div class="label">Date of offer: </div><div class="field"><%=date%></div></div><br/>
		</div><br/>
		<div class="center"><a href="result.jsp?item=<%=name%>">See related results</a></div>
	</body>
</html>