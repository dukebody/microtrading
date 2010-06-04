<%@page session="false" %>
<%@page import="java.sql.*" %>
<% String item_id = request.getParameter("id");
String hash_attempt = request.getParameter("hash");
Boolean hash_ok = false;
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
	   String query = "SELECT name, description, price, contact, hash FROM items WHERE id=" + item_id;
	   ResultSet result = st.executeQuery(query);
	   
	   if (result.next()) {
	       // item found
	       item_found = true;
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
	     <div><div class="label">Name </div><div class="field"><%=title%></div></div><br/>
	     <div>
	       <div class="label">Description </div>
	       <div class="field"><%=description%></div>
	       </div><br/>
	       <div><div class="label">Price </div><div class="field"><%=price%></div></div><br/>
	       <div><div class="label">Contact </div><div class="field"><%=contact%></div></div><br/>
	       </div><br/>


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

       <div>

<%
     if (hash_ok)
     {

out.println("<p style=\"margin-right:500px; float:left\"><a href=\"form.jsp?hash=" + hash_attempt + "\" />Edit</a></p>");

     }
%>
       </div>
  </body>

</html>
