package Controller.Seller_Controller.product;

import DAO.DAO_Seller.category.CategoryProcess;
import DAO.DAO_Seller.image.ImageProcess;
import DAO.DAO_Seller.product.ProductProcess;
import DAO.DAO_Seller.shop.ShopProcess;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import Model.Product;
import Model.Shop;
import Model.Users;

@WebServlet(name = "ViewProduct", urlPatterns = {"/view_product"})
public class ViewProduct extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }

        try {
            Shop shop = ShopProcess.INSTANCE.read(user.getUserID());
            int pageSize = 5;
            int page = getCurrentPage(request);

            String ptype = request.getParameter("ptype") == null ? "all" : request.getParameter("ptype");
            String status = ptype.equals("live") ? "1" : ptype.equals("violation") ? "2" : ptype.equals("review") ? "3" : ptype.equals("unlisted") ? "4" : null;
            String search = request.getParameter("search") != null ? request.getParameter("search").trim().replaceAll("\\s+", " ") : request.getParameter("search");
            String sort = request.getParameter("sort") == null ? "DESC" : request.getParameter("sort");
            int totalPage = ProductProcess.INSTANCE.getTotalProducts(pageSize, status, search, sort, shop.getId());
            List<Product> products = ProductProcess.INSTANCE.getProductsByPage(page, pageSize, status, search, sort, shop.getId());

            // Build warning message if any product's category is inactive
            StringBuilder inactiveMsg = new StringBuilder();
            for (Product p : products) {
                try {
                    int catId = p.getCategoryId();
                    // Simple query to check if category is active
                    boolean isActive = DAO.DAO_Seller.category.CategoryProcess.INSTANCE.getCategoryByID(String.valueOf(catId)).getStatus() == 1;
                    if (!isActive) {
                        inactiveMsg.append("Product '").append(p.getProductName()).append("' is hidden because its category is inactive. ");
                    }
                } catch (Exception ignore) {}
            }

            request.setAttribute("sort", sort);
            request.setAttribute("ptype", ptype);
            //Search//
            request.setAttribute("search", search);
            request.setAttribute("productList", products);
            if (inactiveMsg.length() > 0) {
                request.setAttribute("error", inactiveMsg.toString());
            }
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPage);
            request.setAttribute("categoryProcess", CategoryProcess.INSTANCE);
            request.setAttribute("imageProcess", ImageProcess.INSTANCE);

            // Flash messages from redirect (e.g., delete)
            HttpSession session = request.getSession(false);
            if (session != null) {
                Object suc = session.getAttribute("successUpdateProduct");
                Object err = session.getAttribute("errorUpdateProduct");
                if (suc != null) {
                    request.setAttribute("successUpdateProduct", suc.toString());
                    session.removeAttribute("successUpdateProduct");
                }
                if (err != null) {
                    request.setAttribute("errorUpdateProduct", err.toString());
                    session.removeAttribute("errorUpdateProduct");
                }
            }
        } catch (Exception e) {
            request.setAttribute("error", "The server is busy! Plese try again.");
        }
        request.getRequestDispatcher("/View/SellerPage/product/ViewProduct.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Users user = (Users) request.getSession().getAttribute("acc");
        if (user == null || !user.getUserRole().equalsIgnoreCase("seller")) {
            response.sendRedirect(request.getContextPath() + "/LogOutController");
            return;
        }
//Change Status//
        try {
            String statusAction = request.getParameter("p_select");
            String[] splitData = statusAction.split("\\|");
            ProductProcess.INSTANCE.UpdateToDisable(splitData[0], splitData[1]);
            request.setAttribute("successUpdateProduct", "Change status product is successfully!");
        } catch (Exception e) {
            request.setAttribute("errorUpdateProduct", e.getMessage());
        }
        doGet(request, response);
    }

    private int getCurrentPage(HttpServletRequest request) {
        String pageParam = request.getParameter("page");
        int page = 1;
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        return page;
    }
}
