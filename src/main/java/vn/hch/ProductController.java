package vn.hch;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig()
@WebServlet(urlPatterns = { "/admin/products", "/admin/product/add", "/admin/product/insert",
        "/admin/product/edit", "/admin/product/update", "/admin/product/delete" })
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
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("product", productService.findById(id));
            req.setAttribute("listcate", cateService.findAll());
            req.getRequestDispatcher("/views/admin/product-edit.jsp").forward(req, resp);
        } else {
            int id = Integer.parseInt(req.getParameter("id"));
            productService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = req.getRequestURI();
        if (url.contains("/admin/product/insert")) {
            Product product = new Product();
            bindForm(req, product);
            product.setImages(resolveImage(req, null));
            productService.insert(product);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if (url.contains("/admin/product/update")) {
            int productId = Integer.parseInt(req.getParameter("productId"));
            Product product = productService.findById(productId);
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

    private String resolveImage(HttpServletRequest req, String fileold) throws IOException, ServletException {
        String images = req.getParameter("images");
        String uploadPath = Constant.DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();

        try {
            Part part = req.getPart("images1");
            if (part != null && part.getSize() > 0) {
                if (fileold != null && !fileold.isEmpty() && !fileold.startsWith("https")) {
                    deleteFile(uploadPath + "\\" + fileold);
                }
                String filename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
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
