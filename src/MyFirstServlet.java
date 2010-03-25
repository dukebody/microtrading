import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MyFirstServlet extends HttpServlet {
   public void service (HttpServletRequest req, HttpServletResponse resp)
   throws IOException, ServletException {
      ServletOutputStream out = resp.getOutputStream();

      // Throws IOException, which is already declared
      // in the throws section of this method
      String title= "My second CGI response, a Servlet!";

      out.println("<html><head><title>"+title+"</title></head><body>");

      out.println("<h1>"+title+"</h1>");

      // Read the CGI query string as set by javacgi.sh
      String queryString = req.getQueryString();

      // Print the query string in HTML, nicely preformatted
      out.println("<b><pre>"+queryString+"</pre></b><br>");

      out.println("</body></html>");
   }
}
