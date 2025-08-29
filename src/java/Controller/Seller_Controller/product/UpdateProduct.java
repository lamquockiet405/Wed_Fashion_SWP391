/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Seller_Controller.product;

import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.productvariant.ProductVariantProcess;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import Model.Image;
import Model.Product;
import Model.ProductVariant;
import Model.Users;
import jakarta.servlet.annotation.MultipartConfig;
import java.util.ArrayList;
import ultil.GetValueArray;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
@WebServlet(name = "UpdateProduct", urlPatterns = {"/update_product"})
public class UpdateProduct extends HttpServlet {

    List<ProductVariant> productVariantListRead;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        } 
        
        String pid = request.getParameter("pid");
        try {
            Product product = ProductProcess.INSTANCE.getProductById(pid);

            List<Image> imageList = ImageProcess.INSTANCE.getAllImagesByProductID(product.getProductId());
            StringBuilder image = new StringBuilder();
            for (Image img : imageList) {
                if (image.length() > 0) {
                    image.append("|");
                }
                image.append(img.getImage());
            }

            productVariantListRead = ProductVariantProcess.INSTANCE.read(pid);
            request.setAttribute("productVariantList", productVariantListRead.isEmpty() ? null : productVariantListRead);

            request.setAttribute("image", image.toString());
            request.setAttribute("product", product);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.setAttribute("action", "Update");
        request.getRequestDispatcher("/View/SellerPage/product/AddNewProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        } 
        
        String idProduct = request.getParameter("idProduct");
        try {
            String image = request.getParameter("img_convert_base64");
            request.setAttribute("image", image);

            String productName = request.getParameter("productName") != null ? request.getParameter("productName").trim().replaceAll("\\s+", " ") : request.getParameter("productName");
            String description = request.getParameter("description") != null ? request.getParameter("description").trim() : request.getParameter("description");

            Product p = new Product();
            p.setProductId(Integer.parseInt(idProduct));
            p.setProductName(productName);
            p.setDescription(description);
            request.setAttribute("product", p);
            
            List<ProductVariant> productVariantList = processValueProductVariant(request, idProduct);

            request.setAttribute("productVariantList", productVariantList.isEmpty() ? null : productVariantList);

            if (!productVariantList.isEmpty() && image != null && productName != null && description != null
                    && !image.isBlank() && !productName.isBlank() && !description.isBlank()) {
                try {
                    ProductProcess.INSTANCE.update(idProduct, productName, description);
                    ImageProcess.INSTANCE.add(image, Integer.parseInt(idProduct), 1);
                    try {
                        ProductVariantProcess.INSTANCE.update(productVariantListRead, productVariantList);
                        request.setAttribute("success", "Update product successfull!");
                    } catch (Exception e) {
                        request.setAttribute("error", e.getMessage());
                    }
                } catch (NumberFormatException e) {
                    request.setAttribute("errorAddProduct", e.getMessage());
                }
            } else {
                request.setAttribute("error", "Have the file is null. Plese add again!");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "The system error cannot change value! Plese try again.");
        }
        request.setAttribute("action", "Update");
        request.getRequestDispatcher("/View/SellerPage/product/AddNewProduct.jsp").forward(request, response);
    }

    private List<ProductVariant> processValueProductVariant(HttpServletRequest request, String idProduct) throws ServletException, IOException {
        String[] productVariantId = request.getParameterValues("productVariantId") == null ? new String[0] : request.getParameterValues("productVariantId");
        String[] productVariantPrice = request.getParameterValues("price") == null ? new String[0] : request.getParameterValues("price");
        String[] productVariantStockQuantity = request.getParameterValues("stockQuantity") == null ? new String[0] : request.getParameterValues("stockQuantity");
        String[] productVariantName = request.getParameterValues("product_variant_name") == null ? new String[0] : request.getParameterValues("product_variant_name");
        String[] img_product_variant = request.getParameterValues("img_product_variant") == null ? new String[0] : request.getParameterValues("img_product_variant");
        List<ProductVariant> productVariantList = productVariantList(productVariantId, productVariantPrice, productVariantStockQuantity, productVariantName, img_product_variant, idProduct);
        request.setAttribute("productVariantList", productVariantList.isEmpty() ? null : productVariantList);
        return productVariantList;
    }

    private List<ProductVariant> productVariantList(String[] productVariantId, String[] productVariantPrice,
            String[] productVariantStockQuantity, String[] productVariantName, String[] img_product_variant, String idProduct) {
        List<ProductVariant> productVariantList = new ArrayList<>();
        for (int i = 0; i < img_product_variant.length; i++) {
            ProductVariant pv = new ProductVariant();
            String pvId = GetValueArray.getSafeValue(productVariantId, i) == null ? "-1" : GetValueArray.getSafeValue(productVariantId, i);
            pv.setProductVariantId(Integer.parseInt(pvId));
            pv.setImage(img_product_variant[i].trim());
            String quantity = GetValueArray.getSafeValue(productVariantStockQuantity, i) == null ? "9999" : GetValueArray.getSafeValue(productVariantStockQuantity, i);
            pv.setStockQuantity(Integer.parseInt(quantity));
            String price = GetValueArray.getSafeValue(productVariantPrice, i) == null ? "999999" : GetValueArray.getSafeValue(productVariantPrice, i);
            pv.setPrice(Float.parseFloat(price));
            pv.setProductVariantName(GetValueArray.getSafeValue(productVariantName, i) != null
                    ? GetValueArray.getSafeValue(productVariantName, i).trim()
                    : GetValueArray.getSafeValue(productVariantName, i));
            pv.setProductId(Integer.parseInt(idProduct));
            productVariantList.add(pv);
        }
        return productVariantList;
    }
}
