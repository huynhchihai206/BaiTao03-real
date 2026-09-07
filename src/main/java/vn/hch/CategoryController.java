package vn.hch;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

public class CategoryController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/categories")) {
            List<Category> list = cateService.findAll();
            req.setAttribute("listcate", list);
            req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/add")) {
            req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/category/edit")) {
            int id = parseId(req.getParameter("id"));
            Category category = cateService.findById(id);
            if (category == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy danh mục");
                return;
            }
            req.setAttribute("cate", category);
            req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
        } else {
            int id = parseId(req.getParameter("id"));
            if (id < 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã danh mục không hợp lệ");
                return;
            }
            try {
                cateService.delete(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/category/insert")) {
            String categoryname = req.getParameter("categoryname");
            String statusValue = req.getParameter("status");
            String images = req.getParameter("images");

            String error = ValidationUtil.required(categoryname, "Tên danh mục");
            if (error == null) {
                error = ValidationUtil.imageUrl(images);
            }
            int status;
            try {
                status = Integer.parseInt(statusValue);
                if (status != 0 && status != 1) {
                    error = "Trạng thái không hợp lệ";
                }
            } catch (NumberFormatException e) {
                error = "Trạng thái không hợp lệ";
                status = 0;
            }
            if (error != null) {
                req.setAttribute("error", error);
                req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                return;
            }

            Category category = new Category();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String uploadedFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String imageError = ValidationUtil.imageFilename(uploadedFilename);
                    if (imageError != null || part.getContentType() == null
                            || !part.getContentType().toLowerCase().startsWith("image/")) {
                        req.setAttribute("error",
                                imageError != null ? imageError : "File tải lên phải có định dạng ảnh");
                        req.getRequestDispatcher("/views/admin/category-add.jsp").forward(req, resp);
                        return;
                    }
                    int index = uploadedFilename.lastIndexOf(".");
                    String ext = uploadedFilename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    category.setImages(fname);
                } else if (images != null && !images.isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages("avatar.png");
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }
            cateService.insert(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }

        if (url.contains("/admin/category/update")) {
            int categoryid = parseId(req.getParameter("categoryid"));
            if (categoryid < 0 || cateService.findById(categoryid) == null) {
                req.setAttribute("error", "Mã danh mục không hợp lệ");
                req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
                return;
            }
            String categoryname = req.getParameter("categoryname");
            String statusValue = req.getParameter("status");
            String images = req.getParameter("images");

            String error = ValidationUtil.required(categoryname, "Tên danh mục");
            if (error == null) {
                error = ValidationUtil.imageUrl(images);
            }
            int status;
            try {
                status = Integer.parseInt(statusValue);
                if (status != 0 && status != 1) {
                    error = "Trạng thái không hợp lệ";
                }
            } catch (NumberFormatException e) {
                error = "Trạng thái không hợp lệ";
                status = 0;
            }
            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("cate", cateService.findById(categoryid));
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }

            Category category = cateService.findById(categoryid);
            String fileold = category.getImages();
            category.setCategoryname(categoryname);
            category.setStatus(status);

            String fname = "";
            String uploadPath = Constant.DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists())
                uploadDir.mkdir();

            try {
                Part part = req.getPart("images1");
                if (part != null && part.getSize() > 0) {
                    String uploadedFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String imageError = ValidationUtil.imageFilename(uploadedFilename);
                    if (imageError != null || part.getContentType() == null
                            || !part.getContentType().toLowerCase().startsWith("image/")) {
                        req.setAttribute("error",
                                imageError != null ? imageError : "File tải lên phải có định dạng ảnh");
                        req.setAttribute("cate", category);
                        req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                        return;
                    }
                    if (category.getImages() != null && !category.getImages().startsWith("https")) {
                        deleteFile(uploadPath + "\\" + fileold);
                    }
                    int index = uploadedFilename.lastIndexOf(".");
                    String ext = uploadedFilename.substring(index + 1);
                    fname = System.currentTimeMillis() + "." + ext;
                    part.write(uploadPath + "/" + fname);
                    category.setImages(fname);
                } else if (images != null && !images.isEmpty()) {
                    category.setImages(images);
                } else {
                    category.setImages(fileold);
                }
            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            }
            cateService.update(category);
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }

    private int parseId(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }
}