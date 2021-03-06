<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%
String keywords = request.getParameter("item");
String option = request.getParameter("search_options");

String query_sell = "SELECT * FROM items WHERE buy_sell=0 AND name LIKE ?";
String query_buy = "SELECT * FROM items WHERE buy_sell=1 AND name LIKE ?";

if (option.equals("name") || option.equals("price") || option.equals("date")) {
    String asc_desc;
    if (option.equals("date")) {
        asc_desc = " DESC";
    }
    else {
	asc_desc = " ASC";
    }
	    
    query_sell = query_sell + " ORDER BY " + option + asc_desc;
    query_buy = query_buy + " ORDER BY " + option + asc_desc;
}

Integer id;
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
    	<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
      	<title>Simpletrade - <%=keywords %></title>
      	<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
    </head>
    <body>
    	<div class="header">
	      	<a href="./">
			<img class="noborder" style="float:left;" 
		       	src="images/logo-200x68.jpg" alt="simpletrade" />
	      	</a>
	      	<br />
	      	<form action="result.jsp" method="get">
				<input name="item" id="item" type="text" size="50px" value="<%=keywords%>" />
				<input name="search_options" id="search_options" type="hidden" value="<%=option %>" />
				<input name="submit" type="submit" value="Trade now!" />
	      	</form>
	      	<span class="small">
				Didn't find what you were looking for? Post an add to 
				<a href="form.jsp?name=<%=keywords%>&amp;sell_buy=buy" class="emph">buy</a> or
				<a href="form.jsp?name=<%=keywords%>&amp;sell_buy=sell" class="emph">sell</a> this item.
	      	</span>
      	</div>

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
	%>
	<br style="clear: both;" />
	
	<div id="result_sell">
	  <h2 class="center">For sale</h2>

	    <table>
	      <tr>
		<th class="name">Name</th><th class="price">Price (€)</th><th class="location">Location</th>
	      </tr>
	    <%
		
              PreparedStatement stmt = conn.prepareStatement(query_sell);
              stmt.setString(1, "%" + keywords + "%");
	      ResultSet result_sell = stmt.executeQuery();
	      while (result_sell.next()) {
		  id = result_sell.getInt("id");
                  name = result_sell.getString("name");
		  description = result_sell.getString("description");
		  price = result_sell.getString("price");
		  date = result_sell.getTimestamp("date");
		  location = result_sell.getString("location");
		  contact = result_sell.getString("contact");
	     %>
		
	       <tr>
		 <td class="name"><a href="#" onclick="window.open('item.jsp?id=<%=id%>','pop1','width=600,height=600')"><%=name %></a></td>
		 <td class="price"><%= price %></td>
		 <td class="location"><%=location%></td>
	       </tr>	   
	     <%	}	%>
	     </table>
	   </div>
	 
	 <div id="result_buy">
	   <h2 class="center">Requested</h2>
	    <table>
	      <tr>
		<th class="name">Name</th><th class="price">Price (€)</th><th class="location">Location</th>
	      </tr>			
	      <%
               stmt = conn.prepareStatement(query_buy);
               stmt.setString(1, "%" + keywords + "%");
	       ResultSet result_buy = stmt.executeQuery();
	       while (result_buy.next()) {
		   id = result_buy.getInt("id");
	           name = result_buy.getString("name");
                   description = result_buy.getString("description");
		   price = result_buy.getString("price");
		   date = result_buy.getTimestamp("date");
		   location = result_buy.getString("location"); 
		   contact = result_buy.getString("contact");
	      %>

		
	      <tr>
		<td class="name"><a href="#" onclick="window.open('item.jsp?id=<%=id%>','pop1','width=600,height=600')"><%=name %></a></td>
		<td class="price"><%= price %></td>
		<td class="location"><%=location%></td>
	      </tr>	   
	      <%	}	%>
	 </table>
       </div>
		
			<%
			result_sell.close();
			result_buy.close();
			stmt.close();
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
      </body>
</html>
