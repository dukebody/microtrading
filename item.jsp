<%@page session="false" %>
<%@page import="java.sql.*" %>
<% String item_id = request.getParameter("item_id");
String hash_attempt = request.getParameter("hash");
Boolean hash_ok = false;%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Detail of your item</title>
		<link rel="stylesheet"  type="text/css" href="style.css" />
	</head>
	<body>

<%    
   Connection conn = null;
   // load the mysql db driver
   try {
       Class.forName("com.mysql.jdbc.Driver");
   }
   catch (ClassNotFoundException cnf) {
       out.println("Couldn't load database driver.");
	   }
   
   try{
       // connect to the database
       conn = DriverManager.getConnection(
           "jdbc:mysql://localhost:3306/microtrading",
	   "microtrading", "microtrading");
       
       // issue a query and read the results
       if (conn != null) {
	   Statement st = conn.createStatement();
	   String query = "SELECT name, description, price, contact, hash FROM items WHERE id=" + item_id;
	   ResultSet result = st.executeQuery(query);
	   
	   if (result.next()) {
	       // item found
	       String title = result.getString("name");
	       String description = result.getString("description");
	       Long price = result.getLong("price");
	       String contact = result.getString("contact");
	       String hash_reference = result.getString("hash");
	       if (hash_attempt != null && hash_attempt.contentEquals(hash_reference)) {
		   hash_ok = true;
	       }

	       // render it
%>
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


<%
	   }
	   else {
%>
	   <h1>Item not found</h1>
	   <p>Please check the id of the element you're looking for.</p>
<%
	   }

	   // close db connection
	   result.close();
	   st.close();
	   conn.close();

       }  // end of "if (conn != null) {" above
       
   } // end of "try {" above
   catch(SQLException e){
       out.println("<h1>Error</h1><h3>"+ e.getMessage()+"</h3>");
       }


%>

       <div>

<%
     if (hash_ok)
     {

out.println("<p style=\"margin-right:500px; float:left\"><a href=\"form.jsp?hash=" + hash_attempt + "\" />Edit</a></p>");

     }
%>
          <p style="float:right"><a href="whatever.jsp">Back</a></p>
       </div>
  </body>

</html>