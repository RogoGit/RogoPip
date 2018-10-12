
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

@WebServlet("/")
public class ControllerServlet extends HttpServlet {

    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ArrayList<String> checkings = new ArrayList<>();
        getServletContext().setAttribute("chTable", checkings);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String query = request.getRequestURI();

        if (query != null && (query.endsWith(".css") || query.endsWith(".png"))) {
            if (query.endsWith(".css")) response.setContentType("text/css;charset=UTF-8");
            if (query.endsWith(".png")) response.setContentType("image/png");
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
        String path  = query.split("/")[query.split("/").length - 1];
        if (path.equals("clearHistory")) {
           getServletContext().setAttribute("chTable", new ArrayList<String>());
        }
        else {
            response.setContentType("text/html;charset=UTF-8");
            String kx = request.getParameter("koordX");
            request.setAttribute("X", kx);
            String ky = request.getParameter("koordY");
            request.setAttribute("Y", ky);
            String rad = request.getParameter("radius");
            request.setAttribute("RAD", rad);
            request.getRequestDispatcher("/checkServ").forward(request, response);
        }
    }


}