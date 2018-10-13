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
    String res;
    String kx;
    String ky;
    String rad;
    int getFl=0;

    private static String CheckArea(double x, double y, double r) {
        if ((x>=0) && (y>=0) && (y<=((-2)*x+r))) {return "Попадает";}
        if ((x>=0) && (y<=0) && ((pow(x,2) + pow(y,2))<=pow((r/2),2))) {return "Попадает";}
        if ((x<=0) && (y<=0) && (x>=(-r)) && (y>=(-r/2))) {return "Попадает";}
        return "Не попадает";
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
         getFl=0;
        response.setContentType("text/html");
         kx=request.getParameter("koordX");
        request.setAttribute("X",kx);
         ky=request.getParameter("koordY");
        request.setAttribute("Y",ky);
         rad=request.getParameter("radius");
        request.setAttribute("RAD",rad);
        try {
            res = AreaCheckServlet.CheckArea(Double.parseDouble(kx), Double.parseDouble(ky), Double.parseDouble(rad));
        request.setAttribute("RESULT", res); }
        catch (NumberFormatException c) {
            kx = "--";
            ky = "--";
            rad = "--";
            res = "НЕ ВСЕ ПАРАМЕТРЫ ЧИСЛА";
            request.setAttribute("X",kx);
            request.setAttribute("Y",ky);
            request.setAttribute("RAD",rad);
            request.setAttribute("RESULT", res);
            getFl=1;
        }

        ServletContext servletContext = getServletContext();
        ArrayList<String> newTr = (ArrayList<String>) servletContext.getAttribute("chTable");
        if (getFl==0) {
        newTr.add("<tr><td> " + kx + " </td><td> " + ky + " </td><td> " + rad + " </td><td> " + res + " </td></tr>"); }
         request.getRequestDispatcher("checkTable.jsp").forward(request, response);

    }


}
