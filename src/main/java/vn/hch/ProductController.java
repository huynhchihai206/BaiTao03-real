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

public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public IProductService productService = new ProductServiceImpl();
    public ICategoryService cateService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/products")) {
            List<Product> list = productService.findAll();
            req.setAttribute("listproduct", list);
            req.getRequestDispatcher("/views/admin/product-list.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/add")) {
            req.setAttribute("listcate", cateService.findAll());
            req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
        } else if (url.contains("/admin/product/edit")) {
            int id = parseId(req.getParameter("id"));
            Product product = productService.findById(id);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm");
                return;
            }
            req.setAttribute("product", product);
            req.setAttribute("listcate", cateService.findAll());
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else {
            int id = parseId(req.getParameter("id"));
            if (id < 0) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Mã sản phẩm không hợp lệ");
                return;
            }
            productService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/product/insert")) {
            String error = validateForm(req);
            if (error == null) {
                error = validateImagePart(req);
            }
            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("listcate", cateService.findAll());
                req.getRequestDispatcher("/views/admin/product-add.jsp").forward(req, resp);
                return;
            }
            Product product = new Product();
            bindForm(req, product);
            product.setImages(resolveImage(req, null));
            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (url.contains("/admin/product/update")) {
            String error = validateForm(req);
            if (error == null) {
                error = validateImagePart(req);
            }
            if (error != null) {
                req.setAttribute("error", error);
                req.setAttribute("product", productService.findById(parseId(req.getParameter("productId"))));
                req.setAttribute("listcate", cateService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }
            int productId = parseId(req.getParameter("productId"));
            Product product = productService.findById(productId);
            if (product == null) {
                req.setAttribute("error", "Sản phẩm không tồn tại");
                req.setAttribute("listcate", cateService.findAll());
                req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
                return;
            }
            String fileold = product.getImages();
            bindForm(req, product);
            product.setImages(resolveImage(req, fileold));
            productService.update(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    private void bindForm(HttpServletRequest req, Product product) {
        product.setProductname(req.getParameter("productname"));
        product.setPrice(Double.parseDouble(req.getParameter("price")));
        product.setDescription(req.getParameter("description"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        product.setCategory(cateService.findById(categoryId));
    }

    private String validateForm(HttpServletRequest req) {
        String error = ValidationUtil.required(req.getParameter("productname"), "Tên sản phẩm");
        if (error != null) {
            return error;
        }
        try {
            double price = Double.parseDouble(req.getParameter("price"));
            if (!Double.isFinite(price) || price < 0) {
                return "Giá sản phẩm phải là số không âm";
            }
            int categoryId = Integer.parseInt(req.getParameter("categoryId"));
            if (categoryId <= 0 || cateService.findById(categoryId) == null) {
                return "Danh mục không hợp lệ";
            }
            return ValidationUtil.imageUrl(req.getParameter("images"));
        } catch (NumberFormatException e) {
            return "Giá và danh mục phải là số hợp lệ";
        }
        return null;
    }

    private String validateImagePart(HttpServletRequest req) throws IOException, ServletException {
        Part part = req.getPart("images1");
        if (part == null || part.getSize() == 0) {
            return null;
        }
        String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
        String error = ValidationUtil.imageFilename(filename);
        if (error != null) {
            return error;
        }
        return part.getContentType() != null && part.getContentType().toLowerCase().startsWith("image/")
                ? null
                : "File tải lên phải có định dạng ảnh";
    }

    private int parseId(String value) {
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private String resolveImage(HttpServletRequest req, String fileold) throws IOException, ServletException {
        String images = req.getParameter("images");
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();

        try {
            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0) {
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String imageError = ValidationUtil.imageFilename(filename);
                if (imageError != null || part.getContentType() == null
                        || !part.getContentType().toLowerCase().startsWith("image/")) {
                    throw new ServletException(imageError != null ? imageError : "File tải lên phải có định dạng ảnh");
                }
                if (fileold != null && !fileold.isEmpty() && !fileold.startsWith("https")) {
                    deleteFile(uploadPath + "\\" + fileold);
                }
                int index = filename.lastIndexOf(".");
                String ext = filename.substring(index + 1);
                String fname = System.currentTimeMillis() + "." + ext;
                part.write(uploadPath + "/" + fname);
                return fname;
            } else if (images != null && !images.isEmpty()) {
                return images;
            }
        } catch (FileNotFoundException fne) {
            fne.printStackTrace();
        }
        return fileold != null ? fileold : "avatar.png";
    }

    public static void deleteFile(String filePath) throws IOException {
        Path path = Paths.get(filePath);
        Files.deleteIfExists(path);
    }
}
