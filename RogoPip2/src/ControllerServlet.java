import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/")
public class ControllerServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
        {
            String query = request.getQueryString();
            if (query == null) {
                response.sendRedirect("FormPage.jsp");
            } else {
                response.sendRedirect("AreaCheckServlet.java");
            }
         /*   response.setContentType("text/html");
            PrintWriter pw=response.getWriter();
            response.sendRedirect("FormPage.jsp");
            pw.close();  */
        }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String query = request.getQueryString();
        if (query == null) {
            response.sendRedirect("FormPage.jsp");
        } else {
            response.sendRedirect("AreaCheckServlet.java");
        }

    }


}