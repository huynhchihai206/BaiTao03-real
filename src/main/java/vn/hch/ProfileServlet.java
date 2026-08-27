package vn.hch;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        HttpSession session = req.getSession(false);
        
        if (session != null && session.getAttribute("name") != null) {
            String name = (String) session.getAttribute("name");
            resp.getWriter().print("Chào bạn, " + name + " đến với trang quản lý tài khoản. <br><a href='logout'>Đăng xuất</a>");
        } else {
            resp.sendRedirect("LoginSession.html");
        }
    }
}