import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/checkServ")
public class AreaCheckServlet extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        String pr=request.getParameter("koordX");
        request.setAttribute("X",pr);
        request.getRequestDispatcher("checkTable.jsp").forward(request, response);
       // String pr=request.getParameter("koordX");

     //   PrintWriter res = response.getWriter();
       // res.println(pr);
        //res.println("<body>");
        //res.println("KKKKK");
        //res.println("</body>");

    }

}
