package vn.hch;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet(urlPatterns = { "/profile" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        // Giả lập user 'admin' nếu chưa đăng nhập để test lab
        if (user == null) {
            user = userService.findById("admin");
            if (user == null) {
                user = new User();
                user.setUsername("admin");
                user.setPassword("123");
                user.setFullname("Huỳnh Chí Hải");
                user.setPhone("0912345678");
                user.setImages("default.png");
                userService.insert(user);
            }
            session.setAttribute("account", user);
        } else {
            user = userService.findById(user.getUsername());
        }

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("account");
        String username = sessionUser != null ? sessionUser.getUsername() : req.getParameter("username");

        User user = userService.findById(username);
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        user.setFullname(fullname);
        user.setPhone(phone);

        // Xử lý upload ảnh multipart
        Part part = req.getPart("imageFile");
        if (part != null && part.getSize() > 0) {
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            String ext = filename.substring(filename.lastIndexOf("."));
            String newFileName = System.currentTimeMillis() + ext;

            File uploadDir = new File(Constant.UPLOAD_DIRECTORY);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            part.write(Constant.UPLOAD_DIRECTORY + File.separator + newFileName);
            user.setImages(newFileName);
        }

        userService.update(user);
        session.setAttribute("account", user);
        req.setAttribute("user", user);
        req.setAttribute("message", "Cập nhật thông tin thành công!");
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }
}