package vn.hch;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private IUserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("account");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        user = userService.findById(user.getUsername());

        req.setAttribute("user", user);
        req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User sessionUser = (User) session.getAttribute("account");
        if (sessionUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = userService.findById(sessionUser.getUsername());
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        String error = ValidationUtil.required(fullname, "Họ và tên");
        if (error == null) {
            error = ValidationUtil.phone(phone);
        }
        if (error != null) {
            req.setAttribute("error", error);
            req.setAttribute("user", user);
            req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
            return;
        }

        user.setFullname(fullname.trim());
        user.setPhone(phone.trim());

        // Xử lý upload ảnh multipart
        Part part = req.getPart("imageFile");
        if (part != null && part.getSize() > 0) {
            String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            error = ValidationUtil.imageFilename(filename);
            if (error != null || part.getContentType() == null
                    || !part.getContentType().toLowerCase().startsWith("image/")) {
                req.setAttribute("error", error != null ? error : "File tải lên phải có định dạng ảnh");
                req.setAttribute("user", user);
                req.getRequestDispatcher("/views/admin/profile.jsp").forward(req, resp);
                return;
            }
            String ext = filename.substring(filename.lastIndexOf('.'));
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