package com.rogo;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.Iterator;

@WebServlet("/")
public class ControllerServlet extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ArrayList<Store> checkings = new ArrayList<>();
        getServletContext().setAttribute("chTable", checkings);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
       String query = request.getRequestURI();

        if (query != null && (query.endsWith(".css") || query.endsWith(".png") || query.endsWith(".js"))) {
            if (query.endsWith(".css")) response.setContentType("text/css;charset=UTF-8");
            if (query.endsWith(".png")) response.setContentType("image/png");
            if (query.endsWith(".js")) response.setContentType("text/javascript;charset=UTF-8");
            String filename = query.split("/")[query.split("/").length - 1];
            InputStream res = getServletContext().getResourceAsStream("/" + filename);
            if (res == null) {
                response.setStatus(404);
            } else {
                byte[] buffer = new byte[1024];
                int len;
                while ((len = res.read(buffer)) != -1) {
                    response.getOutputStream().write(buffer, 0, len);
                }
            }
        } else {
            response.setContentType("text/html;charset=UTF-8");
            request.getRequestDispatcher("FormPage.jsp").forward(request, response);
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String query = request.getRequestURI();
       // String path  = query.split("/")[query.split("/").length - 1];
        if (query.contains("clearHistory")) {
           if (request.getParameter("rad") != null ) {
               int rd = Integer.parseInt(request.getParameter("rad"));
               ArrayList<Store> getTbl = (ArrayList<Store>) getServletContext().getAttribute("chTable");
               Iterator<Store> i = getTbl.iterator();
               while (i.hasNext()) {
                   Store s = i.next();
                  // String[] pieces = s.split("</td><td>");
                   if (s.rad.equals(Integer.toString(rd))) {
                       i.remove();
                   }
               }
               getServletContext().setAttribute("chTable", getTbl);
           } else
            {
           getServletContext().setAttribute("chTable", new ArrayList<Store>()); }
        }
        else {

            response.setContentType("text/html;charset=UTF-8");
                String kx = request.getParameter("koordX");
                request.setAttribute("X", kx);
                String ky = request.getParameter("koordY");
                request.setAttribute("Y", ky);
                String rad = request.getParameter("radius");
                request.setAttribute("RAD", rad);
                if (kx!=null && ky!=null && rad!=null) {
                    request.getRequestDispatcher("/checkServ").forward(request, response);
                } else {
                    response.sendError(400);
                }

        }
    }


}