/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Seller_Controller.shop;

import DAO.DAO_Seller.shop.ShopProcess;
import DAO.DAO_User.DAOUsers;
import Model.Shop;
import Model.Users;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
@WebServlet(name = "EditInformationShop", urlPatterns = {"/manager-edit-shop"})
public class EditInformationShop extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        Integer sellerId = (Integer) request.getSession().getAttribute("sellerId");
        if (sellerId == null) {
            sellerId = new DAOUsers().getSellerIdByEmail(user.getEmail());
            if (sellerId != null) {
                request.getSession().setAttribute("sellerId", sellerId);
            }
        }

        Shop shop = sellerId == null ? null : ShopProcess.INSTANCE.getShopByUserId(sellerId);

        request.setAttribute("shop", shop);
        request.getRequestDispatcher("/View/SellerPage/shop/EditInformationShop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
        Integer sellerId = (Integer) request.getSession().getAttribute("sellerId");
        if (sellerId == null) {
            sellerId = new DAOUsers().getSellerIdByEmail(user.getEmail());
            if (sellerId != null) {
                request.getSession().setAttribute("sellerId", sellerId);
            }
        }
        Shop current = sellerId == null ? null : ShopProcess.INSTANCE.getShopByUserId(sellerId);
        if (current == null) {
            request.setAttribute("error", "Shop not found or not approved yet.");
            request.getRequestDispatcher("/View/SellerPage/shop/EditInformationShop.jsp").forward(request, response);
            return;
        }

        String name = request.getParameter("name");
        String tax = request.getParameter("tax");
        String describe = request.getParameter("describe");
        String blobImage = request.getParameter("blobImage");

        // Normalize inputs; keep old values if empty
        if (name != null) name = name.trim().replaceAll("\\s+", " ");
        if (tax != null) tax = tax.trim().replaceAll("\\s+", " ");
        if (describe != null) describe = describe.trim();

        if (name == null || name.isBlank()) name = current.getName();
        if (tax == null || tax.isBlank()) tax = current.getTax();
        if (describe == null || describe.isBlank()) describe = current.getDescribe();
        String logo = (blobImage != null && !blobImage.isBlank()) ? blobImage : current.getLogo();

        try {
            current.setName(name);
            current.setTax(tax);
            current.setDescribe(describe);
            current.setLogo(logo);
            ShopProcess.INSTANCE.update(current);
            request.setAttribute("success", "Update shop information successfully.");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        request.setAttribute("shop", current);
        request.getRequestDispatcher("/View/SellerPage/shop/EditInformationShop.jsp").forward(request, response);
    }
}
