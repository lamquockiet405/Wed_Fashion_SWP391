/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Customer_Controller;

import DAO.DAO_Customer.DAOCart;
import DAO.DAO_Customer.DAOProduct;
import Model.Chinh.Categories;
import Model.Chinh.MinMaxPrice;
import Model.Chinh.Products;
import Model.Chinh.ProductsVariant;
import Model.Chinh.images;
import Model.Users;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Dell
 */
@WebServlet(name = "ProductDetail", urlPatterns = {"/product_detail"})
public class ProductDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
         int cartCount = 0;
        String productID_Ip = request.getParameter("productID");
        String imgChose = request.getParameter("img");
        String model = request.getParameter("variantID");
        int productID = Integer.parseInt(productID_Ip);
        DAOProduct dao = new DAOProduct();
        Products product = null;
        List<MinMaxPrice> list_price = null;
        List<ProductsVariant> list_variant = null;
        if (session != null) {
            Users acc = (Users) session.getAttribute("acc");
            if (acc != null) {
                DAOCart ct = new DAOCart();
                cartCount = ct.countCartItems(acc.getUserID());
                session.setAttribute("cartCount", cartCount);
            } else {
                session.removeAttribute("cartCount");
            }
        }
        if (imgChose == null && model == null) {
            List<images> list_image = null;
            images imagesDistinct = null;
            int allQuantity = 0;
            list_price = dao.getPriceMinMax();
            product = dao.getProductsById(productID);
            imagesDistinct = dao.getImageDistinctByID(productID);
            list_image = dao.getImagesByProductId(productID);
            list_variant = dao.getVariantsByProductId(productID);
            for (ProductsVariant productsVariant : list_variant) {
                allQuantity += productsVariant.getStockQuantity();
            }
            request.setAttribute("Listprice", list_price);
            request.setAttribute("Product", product);
            request.setAttribute("Listimage", list_image);
            request.setAttribute("Listvariant", list_variant);
            request.setAttribute("AllQuantity", allQuantity);
            request.setAttribute("ImagesDistinct", imagesDistinct.getImage());
            request.getRequestDispatcher("View/Product/ProductDetail.jsp").forward(request, response);
            return;
        }
        if (imgChose != null && model == null) {
            int img = Integer.parseInt(imgChose);
            images imagesDistinct = null;
            List<images> list_image = null;
            int allQuantity = 0;
            list_price = dao.getPriceMinMax();
            product = dao.getProductsById(productID);
            imagesDistinct = dao.getImagesByImgId(img);
            list_image = dao.getImagesByProductId(productID);
            list_variant = dao.getVariantsByProductId(productID);
            for (ProductsVariant productsVariant : list_variant) {
                allQuantity += productsVariant.getStockQuantity();
            }
            request.setAttribute("Listprice", list_price);
            request.setAttribute("Product", product);
            request.setAttribute("Listimage", list_image);
            request.setAttribute("Listvariant", list_variant);
            request.setAttribute("AllQuantity", allQuantity);
            request.setAttribute("ImagesDistinct", imagesDistinct.getImage());
            request.getRequestDispatcher("View/Product/ProductDetail.jsp").forward(request, response);
            return;
        }
        if (model != null) {
            int variantID = Integer.parseInt(model);
            product = dao.getProductsById(productID);
            List<images> list_image = null;
            list_image = dao.getImagesByProductId(productID);
            list_variant = dao.getVariantsByProductId(productID);
            ProductsVariant variant = dao.getVariantsByVariantId(variantID);
            request.setAttribute("Listprice", list_price);
            request.setAttribute("Product", product);
            session.setAttribute("VariantDetail", variant);
            request.setAttribute("Listimage", list_image);
            request.setAttribute("Listvariant", list_variant);
            request.setAttribute("AllQuantity", variant.getStockQuantity());
            request.setAttribute("ImagesDistinct", variant.getImage());
            request.getRequestDispatcher("View/Product/ProductDetail.jsp").forward(request, response);
            return;
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
