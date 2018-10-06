import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;

@WebServlet("/checkServ")
public class AreaCheckServlet extends HttpServlet {


    public static String CheckArea(double x, double y, double r) {
        if ((x>=200) && (y>=200) && ((Math.pow((x-200),2) + Math.pow((y-200),2)) <= Math.pow((r*20),2))) {return "Попадает";}
        if ((x>=200) && (y<=200) && ((200-(200+(y-200)))<=((-2)*(x-200)+r*40))) {return "Попадает";}
        if ((x<=200) && (y>=200) && (x>=(200-(r*40))) && (y<=(200+(r*20)))) {return "Попадает";}
        return "Не попадает";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        response.setContentType("text/html");
        String kx=request.getParameter("koordX");
        request.setAttribute("X",kx);
        String ky=request.getParameter("koordY");
        request.setAttribute("Y",ky);
        String rad=request.getParameter("radius");
        request.setAttribute("RAD",rad);

        request.setAttribute("RESULT", AreaCheckServlet.CheckArea(Double.parseDouble(kx), Double.parseDouble(ky), Double.parseDouble(rad)));

     //   request.getRequestDispatcher("checkTable.jsp").forward(request, response);
       // String pr=request.getParameter("koordX");

       PrintWriter res = response.getWriter();
       res.println("<tr>");
        res.println("<td> " + kx  + " </td>");
        res.println("<td> " + ky  + " </td>");
        res.println("<td> " + rad  + " </td>");
        res.println("<td> " + AreaCheckServlet.CheckArea(Double.parseDouble(kx), Double.parseDouble(ky), Double.parseDouble(rad)) + " </td>");
        res.println("</tr>");

    }


}
