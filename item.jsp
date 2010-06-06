<%@page session="false" %>
<%@page import="java.sql.*" %><%@page import="java.text.DateFormat" %>
<% String item_id = request.getParameter("id");
Boolean item_found = false;%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
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
           "jdbc:mysql://localhost:3306/simpletrade",
	   "simpletrade", "simpletrade");
       

       // issue a query and read the results
       if (conn != null && item_id != null && item_id.length()>0) {
		   Statement st = conn.createStatement();
		   String query = "SELECT name, description, price, contact, date FROM items WHERE id=" + item_id;
		   ResultSet result = st.executeQuery(query);
		   
		   if (result.next()) {
		       // item found
		       item_found = true;
		       String title = result.getString("name");
		       String description = result.getString("description");
		       String price = result.getString("price");
		       String contact = result.getString("contact");
		       Date date = result.getDate("date");
		       String date_text = DateFormat.getTimeInstance(DateFormat.FULL).format(date);

		       // render it
	%>
		   <h1>Item details</h1>
		   <div id="content">
		     <div><div class="label">Name </div><div class="field"><%=title%></div></div><br/>
		     <div>
		     	<div class="label">Description </div><div class="field"><%=description%></div><br/>
	       		<div><div class="label">Price (€) </div><div class="field"><%=price%></div></div><br/>
	       		<div><div class="label">Contact </div><div class="field"><%=contact%></div></div><br/>
				<div><div class="label">Publication date </div><div class="field"><%=date%></div></div><br/>
	
	<%
			}
		   // close db connection
		   result.close();
		   st.close();
		   conn.close();

       }
       if (!item_found) {
%>
	   <h1>Item not found</h1>
	   <p>Please check the id of the element you're looking for.</p>
<%


       }  // end of "if (conn != null) {" above
       
   } // end of "try {" above
   catch(SQLException e){
       out.println("<h1>Error</h1><h3>"+ e.getMessage()+"</h3>");
       }


%>
  </body>

</html>
