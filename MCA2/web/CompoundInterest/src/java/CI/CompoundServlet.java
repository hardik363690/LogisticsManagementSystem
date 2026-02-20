package CI;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CompoundServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {

            double P = Double.parseDouble(request.getParameter("principal"));
            double R = Double.parseDouble(request.getParameter("rate"));
            double months = Double.parseDouble(request.getParameter("months"));
            int n = Integer.parseInt(request.getParameter("interval"));

            double t = months / 12.0;

            double A = P * Math.pow((1 + (R / (n * 100))), (n * t));
            double interest = A - P;

            out.println("<html>");
            out.println("<head>");
            out.println("<link rel='stylesheet' type='text/css' href='style.css'>");
            out.println("</head>");
            out.println("<body>");
            out.println("<div class='container'>");
            out.println("<h2>Calculation Result</h2>");
            out.println("<p><strong>Principal:</strong> " + P + "</p>");
            out.println("<p><strong>Interest Earned:</strong> " + 
                         String.format("%.2f", interest) + "</p>");
            out.println("<p><strong>Future Value:</strong> " + 
                         String.format("%.2f", A) + "</p>");
            out.println("<a href='index.html'>Calculate Again</a>");
            out.println("</div>");
            out.println("</body>");
            out.println("</html>");

        } catch (Exception e) {
            out.println("<h3>Error: Invalid Input</h3>");
            out.println("<a href='index.html'>Go Back</a>");
        }
    }
}
