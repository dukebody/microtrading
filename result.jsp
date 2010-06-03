<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
String keywords = request.getParameter("item"); 
String query_sell = "SELECT * FROM items WHERE buy_sell=0 AND name LIKE '%" + keywords + "%'";
String query_buy = "SELECT * FROM items WHERE buy_sell=1 AND name LIKE '%" + keywords + "%'";
String name;
String description;
String price;
Timestamp date;
String location;
String contact;
String link_item;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Results for "<%=keywords %>"</title>
		<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
	</head>
	<body>
		<form action ="result.jsp" method="get">
				<input name="item" id = "item" type="text" size=60 value="<%=keywords%>" />
				<input name="submit" type="submit" value="Trade now!" />
		</form>
	<%
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
	%>
		<h1>Results for "<%=keywords %>":</h1>
		
		<div id="result_sell">
			<h2>Items for sale:</h2>
			<div class="list">
				<%  	
				ResultSet result_sell = st.executeQuery(query_sell);
				while (result_sell.next()) {
				    name = result_sell.getString("name");
				    description = result_sell.getString("description");
				    price = result_sell.getString("price");
				    date = result_sell.getTimestamp("date");
				    location = result_sell.getString("location");
				    contact = result_sell.getString("contact");
				%>
				
				<a class="tooltip" href= "item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=price%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;date=<%=date%>" ><%=name %> 
					<span>
					Price : <%= price %>� </br>
					Location : <%=location%>
					</span>
				</a>

				<br/>
				<%	}	%>
			</div>
		</div>
		
		<div id="result_buy">
			<h2>Requested items:</h2>
			
			<div class="list">
				<%  	
				ResultSet result_buy = st.executeQuery(query_buy);
				while (result_buy.next()) {
				     name = result_buy.getString("name");
				     description = result_buy.getString("description");
				     price = result_buy.getString("price");
				     date = result_buy.getTimestamp("date");
				     location = result_buy.getString("location"); 
				     contact = result_buy.getString("contact");
				%>
				<a class="tooltip" href= "item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=price%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;date=<%=date%>" ><%=name %> 
					<span>
					Price : <%= price %>� </br>
					Location : <%=location%>
					</span>
				</a>
				<br/>
				<%	}	%>
			</div>
		</div>
		
			<%
			result_sell.close();
			result_buy.close();
			st.close();
			%>
	<%
		// end of if
		}
	// end of try
	}
	catch (SQLException e) {
		out.println("<h3>"+ e.getMessage()+"</h3>");
	}
	%>
	<br/><br/><br/><br/><br/>
	
	<form id="downpage" action="form.jsp" method="get" >
		<input name="item" id = "item" type="text" size=60 value="<%=keywords%>" />
		<br/>
		<input name="sell_buy"  type="submit" value="Sell"/>
		<input name="sell_buy"  type="submit" value="Buy"/>
	</form>
	</body>
</html>
