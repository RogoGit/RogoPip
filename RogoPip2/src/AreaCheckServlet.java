import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

import static java.lang.Math.pow;

@WebServlet("/checkServ")
public class AreaCheckServlet extends HttpServlet {


    public static String CheckArea(double x, double y, double r) {
        if ((x>=0) && (y>=0) && (y<=((-2)*x+r))) {return "Попадает";}
        if ((x>=0) && (y<=0) && ((pow(x,2) + pow(y,2))<=pow((r/2),2))) {return "Попадает";}
        if ((x<=0) && (y<=0) && (x>=(-r)) && (y>=(-r/2))) {return "Попадает";}
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
        String res = AreaCheckServlet.CheckArea(Double.parseDouble(kx), Double.parseDouble(ky), Double.parseDouble(rad));
        request.setAttribute("RESULT", res);

        ServletContext servletContext = getServletContext();
        ArrayList<String> newTr = (ArrayList<String>) servletContext.getAttribute("chTable");
        newTr.add("<tr><td> " + kx + " </td><td> " + ky + " </td><td> " + rad + " </td><td> " + res + " </td></tr>");

         request.getRequestDispatcher("checkTable.jsp").forward(request, response);

    }


}
