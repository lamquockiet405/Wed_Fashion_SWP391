/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Seller_Controller.product;

import DAO.DAO_Seller.category.CategoryProcess;
import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.productvariant.ProductVariantProcess;
import DAO.DAO_Seller.shop.ShopProcess;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.Category;
import Model.Product;
import Model.ProductVariant;
import Model.Shop;
import Model.User;
import Model.Users;
import jakarta.servlet.annotation.MultipartConfig;
import java.sql.SQLException;
import java.util.ArrayList;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
@WebServlet(name = "AddNewProduct", urlPatterns = {"/add_new_product"})
public class AddNewProduct extends HttpServlet {

    String error = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        try {
            List<Category> categoryList = CategoryProcess.INSTANCE.getAllCategories();
            request.setAttribute("categoryList", categoryList);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/View/SellerPage/product/AddNewProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // get infor user login 
            Users u = (Users) request.getSession().getAttribute("acc");
            if (u == null || !u.getUserRole().equalsIgnoreCase("seller")) {
                response.sendRedirect(request.getContextPath() + "/LogOutController");
                return;
            }

            User userLogin = new User();
            userLogin.setUserId(u.getUserID());

            if (userLogin != null) {
                // get infor shop
                Shop shop = ShopProcess.INSTANCE.read(userLogin.getUserId());

                String image = request.getParameter("img_convert_base64");
                request.setAttribute("image", image);

                String productName = request.getParameter("productName") == null ? request.getParameter("productName") : request.getParameter("productName").trim().replaceAll("\\s+", " ");
                String category = request.getParameter("category");
                String description = request.getParameter("description") == null ? request.getParameter("description") : request.getParameter("description").trim();

                Product p = new Product();
                p.setProductName(productName);
                p.setCategoryId(Integer.parseInt(category));
                p.setDescription(description);
                request.setAttribute("product", p);

                List<ProductVariant> productVariantList = new ArrayList<>();
                String[] productVariantPrice = request.getParameterValues("price") == null ? new String[0] : request.getParameterValues("price");
                String[] productVariantStockQuantity = request.getParameterValues("stockQuantity") == null ? new String[0] : request.getParameterValues("stockQuantity");
                String[] productVariantName = request.getParameterValues("product_variant_name") == null ? new String[0] : request.getParameterValues("product_variant_name");
                String[] img_product_variant = request.getParameterValues("img_product_variant") == null ? new String[0] : request.getParameterValues("img_product_variant");
                for (int i = 0; i < img_product_variant.length; i++) {
                    ProductVariant pv = new ProductVariant();
                    pv.setImage(img_product_variant[i].trim());
                    pv.setStockQuantity(Integer.parseInt(productVariantStockQuantity[i]));
                    pv.setPrice(Float.parseFloat(productVariantPrice[i]));
                    pv.setProductVariantName(productVariantName[i].trim());
                    productVariantList.add(pv);
                }
                request.setAttribute("productVariantList", productVariantList.isEmpty() ? null : productVariantList);
                if (shop != null) {
                    if (!productVariantList.isEmpty() && image != null && productName != null && category != null && description != null
                            && !image.isBlank() && !productName.isBlank() && !category.isBlank() && !description.isBlank()) {
                        try {
                            int idProduct = ProductProcess.INSTANCE.add(productName, description, 3, category, shop.getId());
                            if (idProduct < 0) {
                                request.setAttribute("error", "System error, cannot add product! Please try again later.");
                            } else {
                                ImageProcess.INSTANCE.add(image, idProduct, 1);

                                try {
                                    for (ProductVariant pv : productVariantList) {
                                        pv.setProductId(idProduct);
                                        pv.setStatus(1);
                                    }
                                    ProductVariantProcess.INSTANCE.add(productVariantList);
                                    request.setAttribute("success", "Add new product successfull!");
                                } catch (SQLException e) {
                                    request.setAttribute("error", e.getMessage());
                                }
                            }
                        } catch (Exception e) {
                            request.setAttribute("errorAddProduct", e.getMessage());
                        }
                    } else {
                        request.setAttribute("error", "Have the file is null! Plese add again.");
                    }
                } else {
                    request.setAttribute("error", "Cannot find your shop! Plese add again.");
                }

            } else {
                response.sendRedirect(request.getContextPath() + "/login?error=The system error! Plese try again.");
            }
        } catch (Exception e) {
            error = e.getMessage();
            request.setAttribute("error", "The system error! Plese try again.");
        }
        doGet(request, response);
    }
}
