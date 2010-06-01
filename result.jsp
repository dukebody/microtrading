<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
String keywords = request.getParameter("item"); 
String query_sell = "SELECT * FROM items WHERE buy_sell=0 AND name LIKE '%" + keywords + "%'";
String query_buy = "SELECT * FROM items WHERE buy_sell=1 AND name LIKE '%" + keywords + "%'";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Results for "<%=keywords %>"</title>
		<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
	</head>
	<body>
		<form action = result.jsp method="get">
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
				String name; String price; String location; String description; String link_item; String contact; String date;
				while (result_sell.next()) {
				 
				 name = (result_sell.getString(2));
				 description = (result_sell.getString(3));
				 price = (result_sell.getString(4));
				 date = (result_sell.getString(5));
				 location = (result_sell.getString(6));
				 contact = (result_sell.getString(7));
				%>
				
				<a class="tooltip" href= "item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=price%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;date=<%=date%>" ><%=name %> 
					<span>
					Price : <%= price %>€ </br>
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
					
					name = (result_buy.getString(2));
					description = (result_buy.getString(3));
					price = (result_buy.getString(4));
					date = (result_buy.getString(5));
					location = (result_buy.getString(6)); 
					contact = (result_buy.getString(7));
				%>
				<a class="tooltip" href= "item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=price%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;date=<%=date%>" ><%=name %> 
					<span>
					Price : <%= price %>€ </br>
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
	
	<div id="downpage">
	<form action = "form.jsp" method="get" >
		<input name="item" id = "item" type="text" size=60 value="<%=keywords%>" />
		<br/>
		<input name="sell_buy"  type="submit" value="Sell"/>
		<input name="sell_buy"  type="submit" value="Buy"/>
	</form>
	</div>
	</body>
</html>