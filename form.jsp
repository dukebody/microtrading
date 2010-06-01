<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Form</title>
		<link rel="stylesheet"  type="text/css" title="Style" href="style.css" />
		
	<script type="text/javascript">
	<!--
			function isEmpty(str) {
				if (str == null || str == "")
					return true;
				return false;
			}
			function trim(str) {
				if (str!=null) {
					while (str.length > 0 && str.charAt(str.length - 1) == " ")
						str = str.substring(0, str.length - 1);
					while (str.length > 0 && str.charAt(0) == " ")
						str = str.substring(1, str.length);
				}
				return str;
			}
				
			function validateForm(theForm) {
				
				if (isEmpty(trim(theForm.elements["name"].value))) {
					alert("Please enter a name"); return false;
				}
				if (isEmpty(trim(theForm.elements["contact"].value))) {
					alert("Please fill the contact field"); return false;
				}
				
				if (isNaN(theForm.elements["price"].value)== true ){
					alert("Please enter a numeric price"); return false;
				
				}
				return true;
			}
	//-->		
	</script>
	</head>
	<body>
	<%
	String name = request.getParameter("name");
	if (name == null) { // i.e. if the user hasn't filled in the form yet
	%>	
		<form action="form.jsp" method="post" class="form" onSubmit="return validateForm(this);">
		<!-- the form cannot be posted without a name and a contact, and the price must be numeric. !-->
		<%
		String item = request.getParameter("item");
		String sell_buy = request.getParameter("sell_buy");
		%>
			<p>
				<label for="name">Name: </label><input name="name" id="name" type="text" value="<%=item%>"/>
				<br/><br/>
				<label for="description">Description: </label>
				<textarea name="description" id="description" rows="4" cols="80"></textarea>
				<br/><br/>
				<label for="price">Price in EUR: </label><input name="price" id="price" type="text" />
				<br/><br/>
				<label for="location">Location: </label><input name="location" id="location" type="text"/>
				<br/><br/>
				<label for="contact">Contact: </label><input name="contact" id="contact" type="text"/>
				<br/><br/>
				<span class="label">Sell or buy?</span>	
				<!-- pre-selection of "sell" or "buy" according to the choice of the user on the page "result"!-->
		<% 
		if (sell_buy.equals("Sell") == true) {%>			
				<input name="sell_buy" id="sell" value="sell" type="radio" checked="checked"/>Sell
				<input name="sell_buy" id="buy" value="buy" type="radio"/>Buy
		<%
		} 
		else {%>
				<input name="sell_buy" id="sell" value="sell" type="radio" />Sell
				<input name="sell_buy" id="buy" value="buy" type="radio"checked="checked"/>Buy
		<%}%>
				<br/><br/>
				<p class="center">
					<input name="submit" type="submit" value="Send"/>
					<input name="reset" type="reset" value="Reset"/>
				</p>
			</p>
		</form>
	<%
	// end of if
	}
	else { // The form has already been filled.
		String description = request.getParameter("description");
		String p = request.getParameter("price");
		Float price;
		if (p != null) {
			price = Float.valueOf(p);
		}
		String location = request.getParameter("location");
		String contact = request.getParameter("contact");
		String sell_buy = request.getParameter("sell_buy");
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
			conn = DriverManager.getConnection("jdbc:mysql://localhost/simpletrade","root", "");
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
			<a href="item.jsp?name=<%=name%>&amp;description=<%=description%>&amp;price=<%=p%>&amp;location=<%=location%>&amp;contact=<%=contact%>&amp;sell_buy=<%=sell_buy%>&amp;date=now">
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