<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>Simpletrade - Post an ad</title>
		<link rel="stylesheet"  type="text/css" href="style.css" />
		<script type="text/javascript" src="validation.js"></script>
	</head>
	<body>
	  <h1>Post an ad</h1>
      <%
String name = request.getParameter("name");
name = (name != null) ? name : "";

String sell_buy = (String) request.getParameter("sell_buy");
sell_buy = (sell_buy != null) ? sell_buy : "sell";

String description = request.getParameter("description"); 
description = (description != null) ? description : "";

String price = request.getParameter("price");
price = (price != null) ? price : "";

String location = request.getParameter("location");
location = (location != null) ? location : "";

String contact = request.getParameter("contact");
contact = (contact != null) ? contact : "";

String submitted = request.getParameter("submit");
if (submitted == null) { // the user hasn't filled in the form yet
    %>	
		<form action="form.jsp" method="post" onsubmit="return validateForm(this);">
		<!-- the form cannot be posted without a name and a contact, and the price must be numeric. !-->
				<label for="name">Name </label><input name="name" id="name" type="text" value="<%=name%>"/>
				<br/><br/>
				<label for="description">Description </label>
				<textarea name="description" id="description" rows="4" cols="50"><%=description%></textarea>
				<br/><br/>
				<label for="price">Price in EUR </label><input name="price" id="price" type="text" value="<%=price%>" />
				<br/><br/>
				<label for="location">Location </label><input name="location" id="location" type="text" value="<%=location%>"/>
				<br/><br/>
				<label for="contact">Contact </label><input name="contact" id="contact" type="text" value="<%=contact%>"/>
				<br/><br/>
				<span class="label">You want to</span>	
				<!-- pre-selection of "sell" or "buy" according to the choice of the user on the page "result"!-->
		<% 
		if (sell_buy.equals("sell") == true) {%>			
				<input name="sell_buy" id="sell" value="sell" type="radio" checked="checked" />Sell
				<input name="sell_buy" id="buy" value="buy" type="radio" />Buy
		<%
		} 
		else {%>
				<input name="sell_buy" id="sell" value="sell" type="radio" />Sell
				<input name="sell_buy" id="buy" value="buy" type="radio" checked="checked" />Buy
		<%}%>
				<br/><br/>
				<div class="center">
					<input name="submit" type="submit" value="Post"/>
				</div>
		</form>
	<%
	// end of if
	}
	else { // The form has already been filled.
	    Float p;
	    if (price != null) {
		p = Float.valueOf(price);
	    }
	    int buy;
	    if (sell_buy.equals("buy")==true) {buy = 1;}
	    else {buy = 0;}
		String query = "INSERT INTO items(name, description, price, date, location, contact, buy_sell, hash)" +
					   String.format("VALUES('%s', '%s', %s, NOW(), '%s', '%s', '%d', '%s')", name, description, p, location, contact, buy, "");
		
		Connection conn = null;
		// load the mysql db driver
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (ClassNotFoundException cnf) { 
		%>
			<h1>Could not find the JDBC driver</h1>
		<%
		}
		try {
			// connect to the database
			conn = DriverManager.getConnection("jdbc:mysql://localhost/simpletrade","simpletrade", "simpletrade");
			if (conn != null) {
				Statement st = conn.createStatement();
				st.executeUpdate(query);
				st.close();
			}
		}
		catch (SQLException e) {
			out.println("<h3>"+ e.getMessage()+"</h3>");
		}
		%>
		<p>
			Your request has been registered.<br/><br/>
			<a href="item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=price%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;sell_buy=<%=sell_buy%>&amp;date=now">
				See the details
			</a><br/><br/>
			<a href="result.jsp?item=<%=name%>">
				See related results
			</a>
		</p>
	<%
	//end of else
	}
	%>
	</body>
</html>
