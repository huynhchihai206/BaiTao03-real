package vn.hch;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/login-session"})
public class LoginSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        
        if (user.equals("chihai") && pass.equals("123")) {
            HttpSession session = req.getSession();
            session.setAttribute("name", user);
            resp.sendRedirect("profile");
        } else {
            resp.sendRedirect("LoginSession.html");
        }
    }
}